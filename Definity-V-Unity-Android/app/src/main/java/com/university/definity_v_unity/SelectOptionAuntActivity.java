package com.university.definity_v_unity;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class SelectOptionAuntActivity extends AppCompatActivity {

    Toolbar mToolbar;
    Button mButtonGoToLogin;
    Button mButtonGoToRegister;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_select_option_aunt);
        mToolbar=findViewById(R.id.toolbar_1);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("Seleccionar opcion");
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        mButtonGoToLogin=findViewById(R.id.btnGoToLogin);
        mButtonGoToLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                goToLogin();
            }
        });

        mButtonGoToRegister=findViewById(R.id.btnGoToRegister);
        mButtonGoToRegister.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                goToRegister();
            }
        });
    }

    public void goToLogin(){
        Intent intent = new Intent(SelectOptionAuntActivity.this, LoginActivity.class);
        startActivity(intent);


    }

    public void goToRegister(){
        Intent intent = new Intent(SelectOptionAuntActivity.this, RegistroActivityi.class);
        startActivity(intent);
    }


}
