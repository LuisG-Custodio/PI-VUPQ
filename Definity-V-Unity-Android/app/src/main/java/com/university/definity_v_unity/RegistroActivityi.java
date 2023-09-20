package com.university.definity_v_unity;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.android.material.textfield.TextInputEditText;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthRegistrar;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.university.definity_v_unity.Models.User;

public class RegistroActivityi extends AppCompatActivity {
    Toolbar mToolbar;

    SharedPreferences mPref;

    FirebaseAuth mAuth;
    DatabaseReference mDatabase;

    //views
    Button mButtonRegister;
    TextInputEditText mTextInputEmail;
    TextInputEditText mTextInputPassword;
    TextInputEditText mTextInputName;
    TextInputEditText mTextInputMatricula;




    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registro_activityi);

        mButtonRegister = findViewById(R.id.btnRegister);
        mTextInputEmail = findViewById(R.id.textInputEmail);
        mTextInputMatricula = findViewById(R.id.textInputMatricula);
        mTextInputPassword = findViewById(R.id.textInputPassword);
        mTextInputName = findViewById(R.id.textInputName);

        mToolbar=findViewById(R.id.toolbar_1);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("Register");
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        mAuth = FirebaseAuth.getInstance();
        /* mDatabase hace referencia a nuestra base de datos de la paguina Firebase */
        mDatabase = FirebaseDatabase.getInstance().getReference();

        mPref = getApplicationContext().getSharedPreferences("typeUser",MODE_PRIVATE);

        //Toast.makeText(this,"El valor que seleciono fue "+ selectedUser, Toast.LENGTH_SHORT).show();

        mButtonRegister.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                registerUser();
            }
        });
    }


    void registerUser(){
        final String name = mTextInputName.getText().toString();
        final String email = mTextInputEmail.getText().toString();
        final String password = mTextInputPassword.getText().toString();
        final String matricula = mTextInputMatricula.getText().toString();


        if(!name.isEmpty() && !email.isEmpty() && !password.isEmpty() && !matricula.isEmpty()){
            if(password.length()>=6){
                mAuth.createUserWithEmailAndPassword(email, password).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        if (task.isSuccessful()){
                            saveUser(name, email, matricula);
                        }
                        else{
                            Toast.makeText(RegistroActivityi.this, "No se pudo registrar el usuario", Toast.LENGTH_SHORT).show();
                        }
                    }
                });
            }

            else {
                Toast.makeText(this, "La contraseña almenos debe tener 6 caracteres", Toast.LENGTH_SHORT).show();
            }

        }

        else{
            Toast.makeText(this, "Ingresa todos los campos", Toast.LENGTH_SHORT).show();
        }

    }

    void saveUser(String name, String email, String matricula){

        String selectedUser = mPref.getString("user","");
        User user = new User();
        user.getEmail(email);
        user.getName(name);
        user.getMatricula(matricula);

        if(selectedUser.equals("driver")){

            mDatabase.child("Users").child("Drivers").push().setValue(user).addOnCompleteListener(new OnCompleteListener<Void>() {
                @Override
                public void onComplete(@NonNull Task<Void> task) {
                    if (task.isSuccessful()){
                        Toast.makeText(RegistroActivityi.this, "Registro exitoso", Toast.LENGTH_SHORT).show();
                    }
                    else{
                        Toast.makeText(RegistroActivityi.this, "Fallo el registro", Toast.LENGTH_SHORT).show();
                    }
                }
            });
        } else if (selectedUser.equals("student")) {
            mDatabase.child("Users").child("Students").push().setValue(user).addOnCompleteListener(new OnCompleteListener<Void>() {
                @Override
                public void onComplete(@NonNull Task<Void> task) {
                    if (task.isSuccessful()){
                        Toast.makeText(RegistroActivityi.this, "Registro exitoso", Toast.LENGTH_SHORT).show();
                    }
                    else{
                        Toast.makeText(RegistroActivityi.this, "Fallo el registro", Toast.LENGTH_SHORT).show();
                    }
                }
            });
        }
    }
}