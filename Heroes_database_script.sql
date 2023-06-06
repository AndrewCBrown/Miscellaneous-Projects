--This script is for the database fundamentals class final project
--Written by Andrew Brown
--Notice: I do not own the rights to the fictional characters represented in this
--	database, but I have compiled all this information together myself

--Drop constraints if they exist
ALTER TABLE superheroes DROP CONSTRAINT "SUPR_SID_FK";
ALTER TABLE superheroes DROP CONSTRAINT "SUPR_AID_FK";
ALTER TABLE superheroes DROP CONSTRAINT "SUPR_LID_FK";
ALTER TABLE alteregos DROP CONSTRAINT "ALTE_LID_FK";
ALTER TABLE villains DROP CONSTRAINT "VILL_AID_FK";
ALTER TABLE villains DROP CONSTRAINT "VILL_NID_FK";
ALTER TABLE villains DROP CONSTRAINT "VILL_LID_FK";
ALTER TABLE citizens DROP CONSTRAINT "CITZ_RID_FK";
ALTER TABLE citizens DROP CONSTRAINT "CITZ_LID_FK";

--Drop all tables if they exist
DROP TABLE superheroes CASCADE CONSTRAINTS;
DROP TABLE alteregos CASCADE CONSTRAINTS;
DROP TABLE villains CASCADE CONSTRAINTS;
DROP TABLE citizens CASCADE CONSTRAINTS;
DROP TABLE locations CASCADE CONSTRAINTS;
DROP TABLE gadgets CASCADE CONSTRAINTS;

--Drop all sequences if they exist
DROP SEQUENCE "SUPERHEROES_SEQ";
DROP SEQUENCE "VILLAINS_SEQ";
DROP SEQUENCE "LOCATIONS_SEQ";



--Create superheroes table
CREATE TABLE  superheroes
	("HERO_ID" NUMBER(4,0) CONSTRAINT "SUPR_HID_CK" CHECK ("HERO_ID" > 0),
	"NAME" VARCHAR2(30),
	"STRENGTH" VARCHAR2(30),
	"WEAKNESS" VARCHAR2(30),
	"SUPERIOR_ID" NUMBER(4,0),
	"ALTER_EGO_ID" NUMBER(4,0),
	"LOCATION_ID" NUMBER(3,0),
	CONSTRAINT "SUPR_HID_PK" PRIMARY KEY ("HERO_ID")
	);

--Create alteregos table
CREATE TABLE  alteregos
	("ALTER_EGO_ID" NUMBER(4,0),
	"NAME" VARCHAR2(30),
	"BACKGROUND" VARCHAR2(100),
	"LOCATION_ID" NUMBER(3,0),
	CONSTRAINT "ALTE_AID_PK" PRIMARY KEY ("ALTER_EGO_ID")
	);

--Create villains table
CREATE TABLE  villains
	("VILLAIN_ID" NUMBER(4,0) CONSTRAINT "VILL_VID_CK" CHECK ("VILLAIN_ID" < 0),
	"NAME" VARCHAR2(30),
	"STRENGTH" VARCHAR2(30),
	"WEAKNESS" VARCHAR2(30),
	"THREAT_LEVEL" NUMBER(1,0),
	"ALTER_EGO_ID" NUMBER(4,0),
	"NEMESIS_ID" NUMBER(4,0),
	"LOCATION_ID" NUMBER(3,0),
	CONSTRAINT "VILL_VID_PK" PRIMARY KEY ("VILLAIN_ID")
	);

--Create citizens table
CREATE TABLE  citizens
	("CITIZEN_ID" NUMBER(5,0),
	"NAME" VARCHAR2(30),
	"OCCUPATION" VARCHAR2(30),
	"RELATION" VARCHAR2(20),
	"RELATIONS_ID" NUMBER(4,0),
	"LOCATION_ID" NUMBER(3,0),
	CONSTRAINT "CITZ_CID_PK" PRIMARY KEY ("CITIZEN_ID")
	);

--Create locations table
CREATE TABLE  locations
	("LOCATION_ID" NUMBER(3,0),
	"NAME" VARCHAR2(30),
	"CITY" VARCHAR2(20),
	"STATE" VARCHAR2(2),
	CONSTRAINT "LOCA_LID_PK" PRIMARY KEY ("LOCATION_ID")
	);

--Create gadgets table
CREATE TABLE  gadgets
	("GADGET_ID" CHAR(3),
	"NAME" VARCHAR2(30),
	"USE" VARCHAR2(1000),
	"LAST_ACTIVE" DATE,
	"USER_ID" NUMBER(4,0),
	CONSTRAINT "GADG_GID_PK" PRIMARY KEY ("GADGET_ID")
	);


--Create squences
CREATE SEQUENCE "SUPERHEROES_SEQ"
	INCREMENT BY 1
	START WITH 1000
	MAXVALUE 9999
	MINVALUE 1000
	NOCYCLE
	NOCACHE;
CREATE SEQUENCE "VILLAINS_SEQ"
	INCREMENT BY -1
	START WITH -1000
	MAXVALUE -1000
	MINVALUE -9999
	NOCYCLE
	NOCACHE;
CREATE SEQUENCE "LOCATIONS_SEQ"
	INCREMENT BY 1
	START WITH 100
	MAXVALUE 999
	MINVALUE 100
	NOCYCLE
	NOCACHE;


--Populate superheroes table
INSERT INTO superheroes (hero_id, name, strength, weakness, superior_id, alter_ego_id, location_id)
VALUES (SUPERHEROES_SEQ.NEXTVAL,'Batman','Intellect',NULL,NULL,8704,103);
INSERT INTO superheroes (hero_id, name, strength, weakness, superior_id, alter_ego_id, location_id)
VALUES (SUPERHEROES_SEQ.NEXTVAL,'Robin','Combat','Low physical strength',1000,3353,103);
INSERT INTO superheroes (hero_id, name, strength, weakness, superior_id, alter_ego_id, location_id)
VALUES (SUPERHEROES_SEQ.NEXTVAL,'Batgirl','Intellect','Unknown',1000,5147,103);
INSERT INTO superheroes (hero_id, name, strength, weakness, superior_id, alter_ego_id, location_id)
VALUES (SUPERHEROES_SEQ.NEXTVAL,'Martian Manhunter','Telepathy','Fire',NULL,6508,102);
INSERT INTO superheroes (hero_id, name, strength, weakness, superior_id, alter_ego_id, location_id)
VALUES (SUPERHEROES_SEQ.NEXTVAL,'Green Arrow','Marksmanship','His psychiatric state',NULL,3469,107);
INSERT INTO superheroes (hero_id, name, strength, weakness, superior_id, alter_ego_id, location_id)
VALUES (SUPERHEROES_SEQ.NEXTVAL,'Wonder Woman','Physical Strength','Her braclets',NULL,9276,106);
INSERT INTO superheroes (hero_id, name, strength, weakness, superior_id, alter_ego_id, location_id)
VALUES (SUPERHEROES_SEQ.NEXTVAL,'Superman','Physical Strength','Kyrptonite',NULL,2080,111);

--Populate alteregos table
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (8704,'Bruce Wayne','Orphaned at a young age',100);
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (3353,'Dick Grayson','Ophaned at a young age',100);
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (5147,'Barbara Gordon','Police officer''s daughter',104);
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (6508,'J''onn J''onzz','Survivor of Martian civil war',102);
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (3469,'Oliver Queen','Survived after being stranded on Lian Yu',108);
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (9276,'Diana Prince','United States Army nurse who sold their identity to Wonder Woman',106);
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (2080,'Clark Kent','Kansas raised man who becomes a reporter',110);
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (3470,'Jack Napier','Failed career as a comedian, several psychological traumas in life',101);
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (8834,'Oswald Cobblepot','Outcast and rejected by his wealthy family due to his odd appearance',109);
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (1375,'Pamela Isley','Victim of chemical experiment',101);
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (6967,'Victor Fries','Petty criminal who had an accident in a cryogenics lab',109);
INSERT INTO alteregos (alter_ego_id, name, background, location_id)
VALUES (5142,'John Corben','Former journalist who had a major accident and was saved by becoming a cyborg',NULL);

--Populate villains table
INSERT INTO villains (villain_id, name, strength, weakness, threat_level, alter_ego_id, nemesis_id, location_id)
VALUES (VILLAINS_SEQ.NEXTVAL,'Joker','Unpredictable','Pride',8,3470,1000,101);
INSERT INTO villains (villain_id, name, strength, weakness, threat_level, alter_ego_id, nemesis_id, location_id)
VALUES (VILLAINS_SEQ.NEXTVAL,'Penguin','Wealthy','Women',6,8834,1000,109);
INSERT INTO villains (villain_id, name, strength, weakness, threat_level, alter_ego_id, nemesis_id, location_id)
VALUES (VILLAINS_SEQ.NEXTVAL,'Poison Ivy','Botanical Control','Weed Killer',4,1375,1002,101);
INSERT INTO villains (villain_id, name, strength, weakness, threat_level, alter_ego_id, nemesis_id, location_id)
VALUES (VILLAINS_SEQ.NEXTVAL,'Mr. Freeze','Project Ice','Heat',6,6967,1000,109);
INSERT INTO villains (villain_id, name, strength, weakness, threat_level, alter_ego_id, nemesis_id, location_id)
VALUES (VILLAINS_SEQ.NEXTVAL,'Metallo','Physical Strength','Loss of Powersource',7,5142,1006,NULL);

--Populate citizens table
INSERT INTO citizens (citizen_id, name, occupation, relation, relations_id, location_id)
VALUES (93873,'Alfred Pennyworth','Butler','Butler',8704,100);
INSERT INTO citizens (citizen_id, name, occupation, relation, relations_id, location_id)
VALUES (96960,'Lucious Fox','Engineer','Friend',8704,105);
INSERT INTO citizens (citizen_id, name, occupation, relation, relations_id, location_id)
VALUES (83541,'James Gordon','Police Officer','Father',5147,104);
INSERT INTO citizens (citizen_id, name, occupation, relation, relations_id, location_id)
VALUES (24693,'Felicity Smoke','Computer Scientist','Friend',3469,112);
INSERT INTO citizens (citizen_id, name, occupation, relation, relations_id, location_id)
VALUES (41133,'Thia Queen',NULL,'Sister',3469,108);
INSERT INTO citizens (citizen_id, name, occupation, relation, relations_id, location_id)
VALUES (50858,'Lois Lane','Reporter','Friend',2080,110);

--Populate locations table
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Wayne Mansion','Gotham','NJ');
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Arkham Asylum','Gotham','NJ');
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Mars',NULL,NULL);
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Bat Cave','Gotham','NJ');
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Gordon Home','Gotham','NJ');
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Wayne Industries','Gotham','NJ');
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Amazon',NULL,NULL);
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Arrow Cave','Star City','CT');
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Queen Mansion','Star City','CT');
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Gotham Penitentiary','Gotham','NJ');
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'The Daily Planet','Metropolis','DE');
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Fortress of Solitude',NULL,NULL);
INSERT INTO locations (location_id, name, city, state)
VALUES (LOCATIONS_SEQ.NEXTVAL,'Queen Consolidated','Star City','CT');

--Populate gadgets table
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('3dx','Batbot','Gives Batman a large physical advantage when fighting large opponents',TO_DATE('2018-12-14 00:14:20', 'fxyyyy-mm-dd hh24:mi:ss'),1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('E5i','Umbrella','Can shoot a chloroform gas projectile out the end',TO_DATE('2019-08-12 23:36:27', 'fxyyyy-mm-dd hh24:mi:ss'),-1001);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('7Ta','Net Arrows','Expands into a net upon being fired from Green Arrow''s bow',TO_DATE('2017-03-24 14:03:55', 'fxyyyy-mm-dd hh24:mi:ss'),1004);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('YnJ','Batbinoculars','Increases surveilence ability by maximizing vision range as well as giving options such as infrared and ultraviolet views',TO_DATE('2019-08-24 22:04:12', 'fxyyyy-mm-dd hh24:mi:ss'),1002);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('4uh','Batcycle','Extremely quick transportation method for Batman',TO_DATE('2019-02-28 03:12:36', 'fxyyyy-mm-dd hh24:mi:ss'),1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('JcG','Batmobile','Robust mode of transportation for Batman',TO_DATE('2020-04-20 23:12:58', 'fxyyyy-mm-dd hh24:mi:ss'),1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('4IA','Lasso of Truth','Entraps victim and forces them to tell the truth',TO_DATE('2019-11-05 16:21:01', 'fxyyyy-mm-dd hh24:mi:ss'),1005);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('zZ7','Razor Sharp Playing Cards','Can cut into victims or other objects and can easily be hidden on Joker''s person',TO_DATE('2018-05-05 21:33:33', 'fxyyyy-mm-dd hh24:mi:ss'),-1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('Dqe','Extending Boxing Glove','Packs a powerful punch with the element of surprise',TO_DATE('2016-04-01 00:04:16', 'fxyyyy-mm-dd hh24:mi:ss'),-1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('0Ar','High-Frequency Emitter','Repels or disables animals that have sensitive hearing to high pitched sounds',TO_DATE('2019-09-01 22:46:19', 'fxyyyy-mm-dd hh24:mi:ss'),1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('381','Ice Pick','Causes victims or objects to shatter that have previously been frozen in ice',TO_DATE('2019-12-12 20:14:06', 'fxyyyy-mm-dd hh24:mi:ss'),-1003);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('di4','Batarang','Can cut into victims or other objects at a long range as well as return to the thrower',TO_DATE('2020-03-13 02:22:09', 'fxyyyy-mm-dd hh24:mi:ss'),1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('9nk','Invisible Plane','Wonder Woman''s mode of transportation',TO_DATE('2019-11-05 16:44:19', 'fxyyyy-mm-dd hh24:mi:ss'),1005);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('9M6','Radiation Batsuit','Batman''s special suit that can withstand temperatures upwards of 4000 degrees fahrenheit; useful when fighting firefly',TO_DATE('2015-06-12 23:30:14', 'fxyyyy-mm-dd hh24:mi:ss'),1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('yMc','Grapling Hook','Motorized device that allows Batman to climb buildings very quickly',TO_DATE('2020-05-07 21:48:44', 'fxyyyy-mm-dd hh24:mi:ss'),1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('D1B','The Bracelets of Submission','Indestructable bracelets',TO_DATE('2019-11-01 09:33:00', 'fxyyyy-mm-dd hh24:mi:ss'),1005);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('7U9','Smokescreen Arrows','Explodes to crate a quick smokescreen when fired from Green Arrow''s bow',TO_DATE('2017-03-24 14:31:12', 'fxyyyy-mm-dd hh24:mi:ss'),1004);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('LH0','Rubber Chicken Bomb','Essentially a grenade disguised as a rubber chicken',TO_DATE('2018-10-14 19:48:59', 'fxyyyy-mm-dd hh24:mi:ss'),-1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('9vu','Kali','Durable sticks used for fighting',TO_DATE('2019-08-02 22:24:55', 'fxyyyy-mm-dd hh24:mi:ss'),1001);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('S4O','Smokescreen Poker Chips','Explodes on impact to create a tear gas/smoke screen',TO_DATE('2020-01-09 23:08:38', 'fxyyyy-mm-dd hh24:mi:ss'),-1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('iwd','Cryogenic Accelerator','Multiplies Mr. Freezes ice projecting powers 100 fold',TO_DATE('2013-07-28 20:09:13', 'fxyyyy-mm-dd hh24:mi:ss'),-1003);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('yD5','Batwing','Batman''s very agile and fast mode of flight',TO_DATE('2019-09-01 02:33:12', 'fxyyyy-mm-dd hh24:mi:ss'),1000);
INSERT INTO gadgets (gadget_id, name, use, last_active, user_id)
VALUES ('S7C','Bow','Green Arrow''s most powerful weapon with many uses',TO_DATE('2017-03-24 14:31:12', 'fxyyyy-mm-dd hh24:mi:ss'),1004);


--Add foreign keys
ALTER TABLE superheroes ADD CONSTRAINT "SUPR_SID_FK" FOREIGN KEY ("SUPERIOR_ID")
	REFERENCES superheroes ("HERO_ID") ON DELETE SET NULL;
ALTER TABLE superheroes ADD CONSTRAINT "SUPR_AID_FK" FOREIGN KEY ("ALTER_EGO_ID")
	REFERENCES alteregos ("ALTER_EGO_ID") ON DELETE SET NULL;
ALTER TABLE superheroes ADD CONSTRAINT "SUPR_LID_FK" FOREIGN KEY ("LOCATION_ID")
	REFERENCES locations ("LOCATION_ID") ON DELETE SET NULL;
ALTER TABLE alteregos ADD CONSTRAINT "ALTE_LID_FK" FOREIGN KEY ("LOCATION_ID")
	REFERENCES locations ("LOCATION_ID") ON DELETE SET NULL;
ALTER TABLE villains ADD CONSTRAINT "VILL_AID_FK" FOREIGN KEY ("ALTER_EGO_ID")
	REFERENCES alteregos ("ALTER_EGO_ID") ON DELETE SET NULL;
ALTER TABLE villains ADD CONSTRAINT "VILL_NID_FK" FOREIGN KEY ("NEMESIS_ID")
	REFERENCES superheroes ("HERO_ID") ON DELETE SET NULL;
ALTER TABLE villains ADD CONSTRAINT "VILL_LID_FK" FOREIGN KEY ("LOCATION_ID")
	REFERENCES locations ("LOCATION_ID") ON DELETE SET NULL;
ALTER TABLE citizens ADD CONSTRAINT "CITZ_RID_FK" FOREIGN KEY ("RELATIONS_ID")
	REFERENCES alteregos ("ALTER_EGO_ID") ON DELETE SET NULL;
ALTER TABLE citizens ADD CONSTRAINT "CITZ_LID_FK" FOREIGN KEY ("LOCATION_ID")
	REFERENCES locations ("LOCATION_ID") ON DELETE SET NULL;
--Note that USER_ID in gadgets table is technically a foreign key to BOTH
--	HERO_ID in superheroes table AND VILLAIN_ID in villains table, but SQL does
--	not allow multiple foreign keys like this. However, constraints SUPR_HID_CK
--	and VILL_VID_CK ensure that a HERO_ID can never be equal to a VILLAIN_ID
--	and vice versa, so the USER_ID column can be used in joins effectively.



--Create a view that combines villains, heroes, and the gadgets they use
CREATE OR REPLACE VIEW gadget_users
AS SELECT v.name AS name, v.strength AS strength, v.weakness AS weakness, g.name AS gadget_name, g.use AS use, last_active
FROM villains v JOIN gadgets g
ON v.villain_id=g.user_id
UNION
SELECT s.name AS name, s.strength AS strength, s.weakness AS weakness, g.name AS gadget_name, g.use AS use, last_active
FROM superheroes s JOIN gadgets g
ON s.hero_id=g.user_id
WITH READ ONLY;

--Create a view that shows all superheroes/villains names and their alter egos
CREATE OR REPLACE VIEW secret_identities
AS SELECT s.name AS "Super Name", a.name AS "Alter Ego"
FROM superheroes s JOIN alteregos a
USING (alter_ego_id)
UNION
SELECT v.name AS "Super Name", a.name AS "Alter Ego"
FROM villains v JOIN alteregos a
USING (alter_ego_id)
WITH READ ONLY;


--End script