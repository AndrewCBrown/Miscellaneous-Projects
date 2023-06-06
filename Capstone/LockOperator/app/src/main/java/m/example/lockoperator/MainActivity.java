package m.example.lockoperator;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void unlock_button_handler(View view) {
        //This function updates the info text view and sends the request to the website
            //Note: the request being sent to the website was unfinished
        EditText username = findViewById(R.id.username);
        String user = username.getText().toString();

        if (!user.equals("")) {

            Date curDate = new Date();

            SimpleDateFormat fmt = new SimpleDateFormat("yyyy, M, d, H, m, s");
            String time = fmt.format(curDate);

            String comment = "User:" + user + ";Request Time:" + time + ";Code:unlockDoor();";
            //This toast is the placeholder for the code that should post 'comment' to the website
            Toast.makeText(getApplicationContext(), comment, Toast.LENGTH_LONG).show();


            SimpleDateFormat print_fmt = new SimpleDateFormat("MMMM dd', 'yyyy 'at' H:mm:ss", Locale.US);
            String print_time = print_fmt.format(curDate);

            String description = user + " sent a request to unlock the door on " + print_time + ".";

            TextView info = findViewById(R.id.info);
            info.setText(description);
        }

        else{
            String description = "Please enter a username first!";

            TextView info = findViewById(R.id.info);
            info.setText(description);
        }
    }

    public void lock_button_handler(View view) {
        //This function updates the info text view and sends the request to the website
            //Note: the request being sent to the website was unfinished
        EditText username = findViewById(R.id.username);
        String user = username.getText().toString();

        if (!user.equals("")) {

            Date curDate = new Date();

            SimpleDateFormat fmt = new SimpleDateFormat("yyyy, M, d, H, m, s");
            String time = fmt.format(curDate);

            String comment = "User:" + user + ";Request Time:" + time + ";Code:lockDoor();";
            //This toast is the placeholder for the code that should post 'comment' to the webserver
            Toast.makeText(getApplicationContext(), comment, Toast.LENGTH_LONG).show();


            SimpleDateFormat print_fmt = new SimpleDateFormat("MMMM dd', 'yyyy 'at' H:mm:ss", Locale.US);
            String print_time = print_fmt.format(curDate);

            String description = user + " sent a request to lock the door on " + print_time + ".";

            TextView info = findViewById(R.id.info);
            info.setText(description);
        }

        else{
            String description = "Please enter a username first!";

            TextView info = findViewById(R.id.info);
            info.setText(description);
        }
    }

    public void log_button_handler(View view) {
        //This function sends the user to a second activity where they can view the logs sent from the server
        //Launch Log Reader Activity
        Intent intent = new Intent(this, LogReader.class);
        startActivity(intent);
    }
}