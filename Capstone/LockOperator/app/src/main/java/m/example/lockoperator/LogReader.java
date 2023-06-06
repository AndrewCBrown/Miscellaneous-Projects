package m.example.lockoperator;

import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class LogReader extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_log_reader);
    }

    @Override
    protected void onStart()
    {
        super.onStart();

        //The code to receive log.txt goes here
            //This portion of the code was unfinished because the log file could not be posted
            //to the website from the pi due to internet security issues, see the documentation
            //accompanying this project for full details. For the sake of testing the functionality
            //of reading the file, a pre-made log.txt file is inserted by the following code
        InputStream inputStream = getResources().openRawResource(
                R.raw.log);
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        int i;
        try {
            i = inputStream.read();
            while (i != -1) {
                byteArrayOutputStream.write(i);
                i = inputStream.read();
            }
            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        String the_log = byteArrayOutputStream.toString();

        //Display the text file on the application screen
        TextView log = findViewById(R.id.log);
        log.setText(the_log);
    }
}