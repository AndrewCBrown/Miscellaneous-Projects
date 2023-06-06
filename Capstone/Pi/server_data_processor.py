#Header==================================================================================
#Program is designed to listen for door lock requests and execute them if valid
#    Will also record log statements to a file
#
#Note: This script will not actually que requests, if multiple requests are sent in quick
#    succession then only the last most recent request will be processed. The idea is to
#    prevent a system slowdown or overload if someone spams requests. The only issue I
#    see with this is someone spamming requests could (almost) prevent any legitimate
#    requests from being processed.
#
#Python file referenced: Lock_Functions.py
#Files used: lastProcessedComment.txt, validUsers.txt, allowed_code.txt, log.txt
#========================================================================================


#Import the various libraries needed
import RPi.GPIO as GPIO
import time
import datetime

from Lock_Functions import *
from urllib.request import urlopen, Request
from bs4 import BeautifulSoup

#Function to download a webpage and parse the html into 'soup'
def getSoup(url_as_str):
    hdrs = {'User-Agent': 'Chrome/23.0.1271.64 Safari/537.11'}
    req = Request(url = url_as_str, headers = hdrs)
    response = urlopen(req)
    
    page_html = response.read()
    response.close()
    return BeautifulSoup(page_html, "html.parser")

def extractComments(some_soup):
    foo = some_soup.body.contents[7].text
    foo = foo.split(',"text":"')
    comment_list = []
    for x in range(1, len(foo)):
        section = foo[x].split('","time":')
        comment_list.append(section[0])
    return comment_list

def lastProcessedComment():
    file = open("lastProcessedComment.txt", "r")
    com = file.read()
    file.close()
    return com

def updateLastProcessedComment(comment_string):
    file = open("lastProcessedComment.txt", "w")
    file.write(comment_string)
    file.close()

def checkUser(username):
    file = open("validUsers.txt", "r")
    validUsers = file.readlines()
    file.close()
    
    valid = False
    
    for x in range(len(validUsers)):
        if username + '\n' == validUsers[x]: valid = True
    return valid

def checkReqTime(request_time):
    if request_time == ifd or request_time == mv: return False
    request_age = datetime.datetime.now() - request_time
    valid = True if request_age.seconds < 60 else False
    return valid

def checkCode(code):
    file = open("allowed_code.txt", "r")
    validCode = file.readlines()
    file.close()
    
    valid = False
    
    for x in range(len(validCode)):
        if code + '\n' == validCode[x]: valid = True
    return valid

def extractUser(comment_string):
    temp = comment_string.split('User:')
    temp = temp[1]
    temp = temp.split(';')
    #Note that is no semi-colon is found, the return value will be the rest of the comment following 'User:'
    return temp[0]

def extractReqTime(comment_string):
    temp = comment_string.split('Request Time:')
    temp = temp[1]
    temp = temp.split(';')
    temp = temp[0]
    temp = 'datetime.datetime(' + temp + ')'
    #Will need a try and catch here incase the datetime format is invalid and we can't execute
    try:
        return_val = eval(temp)
    except:
        return_val = ifd
    
    return return_val

def extractCode(comment_string):
    temp = comment_string.split('Code:')
    temp = temp[1]
    temp = temp.split(';')
    return temp[0]

def writeLog(uf, rf, cf, u, r, c, uv, rv, cv, et):
    logLines = ['', '', '', '', '', '\n']
    
    logLines[0] = 'Comment processed on ' + et.strftime("%Y-%m-%d at %H:%M") + '\n'
    
    if uf:
        if uv:
            logLines[1] = 'User: ' + u + '\n'
        else:
            logLines[1] = 'User: ' + u + ' Note: User was not valid' + '\n'
    else:
        logLines[1] = 'Error: User could not be parsed' + '\n'
    
    if rf:
        if rv:
            logLines[2] = 'Request Time: ' + r.strftime("%Y-%m-%d %H:%M:%S") + '\n'
        else:
            try:
                logLines[2] = 'Request Time: ' + r.strftime("%Y-%m-%d %H:%M:%S") + ' Note: Request timed out and could not be executed' + '\n'
            except:
                logLines[2] = 'Request Time: Unknown Note: The request time was sent in an invalid format' + '\n'
    else:
        logLines[2] = 'Error: Request Time could not be parsed' + '\n'
    
    if cf:
        if cv:
            logLines[3] = 'Code: ' + c + '\n'
        else:
            logLines[3] = 'Code: ' + c + ' Note: This code is not allowed to be run via a request' + '\n'
    else:
        logLines[3] = 'Error: Code could not be parsed' + '\n'
    
    if uv and rv and cv:
        if c == 'lockDoor()':
            logLines[4] = 'Door was locked on ' + et.strftime("%Y-%m-%d at %H:%M:%S") + ' by ' + u + '\n'
        elif c == 'unlockDoor()':
            logLines[4] = 'Door was unlocked on ' + et.strftime("%Y-%m-%d at %H:%M:%S") + ' by ' + u + '\n'
        else:
            logLines[4] = 'Error: Unrecognized code, please update the log writing function' + '\n'
    else:
        logLines[4] = 'The request could not be acted upon for one or more reasons' + '\n'
    
    file = open("log.txt", "a")
    file.writelines(logLines)
    file.close()
    
    #The following print statement is optional, for long term use this should be commented
        #out to decrease delays, it is useful for debugging though
    print(logLines[0] + logLines[1] + logLines[2] + logLines[3] + logLines[4])

#Assign variable values
comment_page_url = 'https://app.commentsplugin.com/widget-wix?instance=i3YAssLbOwWkBkd0jLI-t0fpAl38lq_hWk538c_dqjU.eyJpbnN0YW5jZUlkIjoiM2MxZmNjZjAtYzViYS00ZGY5LWJmMWEtODRhOTFkOWEwODI5IiwiYXBwRGVmSWQiOiIxMzAxNjU4OS1hOWViLTQyNGEtOGE2OS00NmNiMDVjZTBiMmMiLCJzaWduRGF0ZSI6IjIwMjAtMTAtMDVUMDQ6NTE6MDAuMDE1WiIsImRlbW9Nb2RlIjpmYWxzZSwiYWlkIjoiYzU0ODM0NDAtMDFlOS00YjgzLWI2NjctOGQ1MmEzZWUzMjQwIiwic2l0ZU93bmVySWQiOiI0NTI5YjQ0ZC1iYmJmLTQyNzQtODFjMi0wZDdkNWQwYWJhNzUifQ&pageId=za9wj&compId=comp-kfvqswnt&viewerCompId=comp-kfvqswnt&siteRevision=14&viewMode=site&deviceType=desktop&locale=en&commonConfig=%7B%22brand%22%3A%22wix%22%2C%22bsi%22%3A%224c8e3b3c-1e96-44e2-84cf-70a8a6abac85%7C1%22%2C%22consentPolicy%22%3A%7B%22essential%22%3Atrue%2C%22functional%22%3Atrue%2C%22analytics%22%3Atrue%2C%22advertising%22%3Atrue%2C%22dataToThirdParty%22%3Atrue%7D%2C%22consentPolicyHeader%22%3A%7B%7D%7D&tz=America%2FChicago&vsi=9b80c703-6ac9-4689-8a0e-934f28dc3dcd&currency=USD&currentCurrency=USD&width=500&height=168'
mv = 'missing_value'
ifd = 'invalid_format_detected'


#Main
while True:
#for x in range(100):

    #Scrape webpage for comments
    page_soup = getSoup(comment_page_url)
    comments = extractComments(page_soup)

    #Determine if the most recent comment was already processed by the system
    #If it was then do nothing and just go back to look for new comments
    if comments[9] != lastProcessedComment():
        #If it wasn't processed or a new comment has come in now then...
        #Parse the comment to get the information
        user_found = True if 'User:' in comments[9] else False
        user = extractUser(comments[9]) if user_found else mv

        reqTime_found = True if 'Request Time:' in comments[9] else False
        reqTime = extractReqTime(comments[9]) if reqTime_found else mv
        
        code_found = True if 'Code:' in comments[9] else False
        code = extractCode(comments[9]) if code_found else mv
        
        #Check that the user, request time, and code are all valid
        user_valid = checkUser(user)
        reqTime_valid = checkReqTime(reqTime)
        code_valid = checkCode(code)
        comment_is_valid = True if user_valid and reqTime_valid and code_valid else False
        execution_time = datetime.datetime.now()
        if comment_is_valid:
            exec(code)
        
        writeLog(user_found, reqTime_found, code_found, user, reqTime, code, user_valid, reqTime_valid, code_valid, execution_time)

        #Update what the most recent processed comment was and go back to the main loop
        updateLastProcessedComment(comments[9])
