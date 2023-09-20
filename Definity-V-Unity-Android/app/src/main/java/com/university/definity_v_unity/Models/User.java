package com.university.definity_v_unity.Models;

public class User {
    String id;
    String name;
    String email;
    String matricula;

    public User(){

    }

    public User(String id, String name, String email, String matricula) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.matricula = matricula;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName(String name) {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail(String email) {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMatricula(String matricula) {
        return this.matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
}
