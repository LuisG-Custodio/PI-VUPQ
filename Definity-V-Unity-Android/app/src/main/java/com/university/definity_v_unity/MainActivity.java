package com.university.definity_v_unity;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    Button mButtonSoyconductor;
    Button mButtonSoyestudiante;

    SharedPreferences mPref;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mPref = getApplicationContext().getSharedPreferences("typeUser",MODE_PRIVATE);
        SharedPreferences.Editor editor = mPref.edit();


        mButtonSoyconductor=findViewById(R.id.btnSoyconductor);
        mButtonSoyestudiante=findViewById(R.id.btnSoyestudiante);

        mButtonSoyconductor.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                editor.putString("user","driver");
                editor.apply();
                goToSelectAuth();

            }
        });
        mButtonSoyestudiante.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                editor.putString("user","student");
                editor.apply();
                goToSelectAuth();

            }
        });
    }

    private void goToSelectAuth() {
        Intent intent= new Intent(MainActivity.this,SelectOptionAuntActivity.class);
        startActivities(new Intent[]{intent});
    }
}