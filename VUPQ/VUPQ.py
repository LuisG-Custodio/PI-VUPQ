#paquteria de flask

from flask import Flask,render_template,request, redirect,url_for,flash, session
from flask_mysqldb import MySQL

import pyodbc

#la inicializacion del app 
app=Flask(__name__)
try:
    connection=pyodbc.connect('DSN=VUPQ;UID=VUPQ_admin;PWD=12345')
    print("Conexion exitosa")
    cursor=connection.cursor()
    cursor.execute("use V_UPQ")
    cursor.commit()
except Exception as e:
    # Atrapar error
    print("Ocurrió un error al conectar a SQL Server")
app.secret_key='mysecretkey'

#pagina_login
@app.route('/')
def index():
    return render_template('login.html')

#metodo para iniciar sesion
@app.route('/login', methods=['POST'])
def login():
    if request.method == 'POST':
        Vid=request.form['txtMatricula']
        Vpass=request.form['txtPassword']
        Vrol=request.form['txtTipo']
        CC=connection.cursor()
        CC.execute('select contraseña from Personas where matricula= '+Vid)
        contraseña=CC.fetchone()
        if (Vpass==contraseña[0]):
            CC.execute('select id from Personas where matricula= '+Vid)
            id=CC.fetchone()
            id=str(id[0])
            print (id)
            Vrol=str(Vrol)
            print(Vrol)
            if(Vrol=="1"):
                return redirect('homepage/conductor/'+id)
            if(Vrol=="2"):
                return redirect('homepage/pasajero/'+id)
        else:
            flash('Usuario y/o contraseña equivocados, vuelva a intentarlo')
            return redirect("/")

#metodo para registrarse
@app.route('/registro', methods=['POST'])
def registro():
    if request.method == 'POST':
        Vmatricula=request.form['txtMatricula']
        Vnombre=request.form['txtNombre']
        V_ap=request.form['txtAP']
        V_am=request.form['txtAM']
        Vtelefono=request.form['txtTelefono']
        Vgenero=request.form['txtGenero']
        Vpassword=request.form['txtPassword']
        Vcpassword=request.form['txtConfirmPassword']
        CC=connection.cursor()
        if (Vpassword==Vcpassword):
            Vpassword=str(Vpassword)
            CC.execute("insert into Personas(matricula,nombre,ap,am,telefono,id_genero,contraseña) values ('"+Vmatricula+"','"+Vnombre+"','"+V_ap+"','"+V_am+"',"+Vtelefono+","+Vgenero+",'"+Vpassword+"')")
            CC.commit()
            flash('Registro realizado correctamente')
            return redirect("/")

#menu principal de pasajero
@app.route('/homepage/pasajero/<personaid>')
def homepage(personaid):
    CC=connection.cursor()
    CC.execute('select id from Pasajeros where id_persona= '+personaid)
    pasajeroid=CC.fetchone()
    pasajeroid=str(pasajeroid[0])
    CC.execute('select Viajes.id, Viajes_globales.id from Viajes inner join Viajes_globales on Viajes_globales.id=Viajes.id_viaje_global where Viajes_globales.estado=0 and Viajes.id_pasajero='+pasajeroid)
    pvg=CC.fetchone()
    pvg=str(pvg)
    if(pvg!="None"):
        CC.execute('select Viajes.id, Viajes_globales.id from Viajes inner join Viajes_globales on Viajes_globales.id=Viajes.id_viaje_global where Viajes_globales.estado=0 and Viajes.id_pasajero='+pasajeroid)
        pvg=CC.fetchone()
        pvp=str(pvg[0])
        pvc=str(pvg[1])
        CC.execute('select Personas.nombre,Personas.matricula,Personas.ap,Personas.am, Conductores.id from Viajes_globales inner join Conductores on Conductores.id=Viajes_globales.id_conductor inner join Personas on Personas.id=Conductores.id_persona where Viajes_globales.id='+pvc)
        conductor=CC.fetchone()
        cid=str(conductor[4])
        CC.execute('select Autos.matricula, Autos.modelo,Autos.marca,Autos.color,Autos.poliza from Autos inner join Conductores on Conductores.id_auto=Autos.id where Conductores.id='+cid)
        auto=CC.fetchone()
        CC.execute('select Personas.nombre,Personas.matricula,Personas.ap,Personas.am from Viajes inner join Pasajeros on Pasajeros.id=Viajes.id_pasajero inner join Personas on Personas.id=Pasajeros.id_persona where Viajes.id_viaje_global='+pvc)
        pasajeros=CC.fetchall()
        print(pasajeros[0])
        print(pasajeros[1])
        
        return render_template('pagina_principal.html',cond=conductor,pas=pasajeros,auto=auto)
    else:
        CC.execute('select Viajes_globales.id,Viajes_globales.id_ruta from Viajes_globales inner join Conductores on Conductores.id=Viajes_globales.id_conductor inner join Autos on Autos.id=Conductores.id_auto where Viajes_globales.estado=0 and Autos.lugares_disponibles!=0')
        viajes_disponibles=CC.fetchall()
        CC.execute('select id,nombre from Paradas')
        paradas=CC.fetchall()
        
        return render_template('pagina_principal.html',pvg=pvg,viajes_disponibles=viajes_disponibles,paradas=paradas,personaid=personaid)
    
@app.route('/reservarviaje/<personaid>', methods=['POST'])
def reservarviaje(personaid):
    if request.method == 'POST':
        rutaid=request.form['txtRuta']
        paradaid=request.form['txtParada']
        CC=connection.cursor()
        CC.execute('select id from Pasajeros where id_persona= '+personaid)
        pasajeroid=CC.fetchone()
        rutaid=str(rutaid)
        pasajeroid=str(pasajeroid[0])
        paradaid=str(paradaid)
        CC.execute("exec sp_reserva_viaje "+rutaid+","+pasajeroid+","+paradaid)
        flash('Se reservó tu viaje con éxito')
        return redirect('homepage/pasajero/'+personaid)
        
#menu principal de conductor
@app.route('/homepage/conductor/<personaid>')
def homepagec(personaid):
    CC=connection.cursor()
    CC.execute('select id from Conductores where id_persona= '+personaid)
    conductorid=CC.fetchone()
    conductorid=str(conductorid[0])
    CC.execute('select id from Viajes_globales where estado=0 and id_conductor='+conductorid)
    pvg=CC.fetchone()
    pvg=str(pvg)
    if(pvg!="None"):
        CC.execute('select Viajes.id, Viajes_globales.id from Viajes inner join Viajes_globales on Viajes_globales.id=Viajes.id_viaje_global where Viajes_globales.estado=0 and Viajes.id_pasajero='+pasajeroid)
        pvg=CC.fetchone()
        pvp=str(pvg[0])
        pvc=str(pvg[1])
        CC.execute('select Personas.nombre,Personas.matricula,Personas.ap,Personas.am, Conductores.id from Viajes_globales inner join Conductores on Conductores.id=Viajes_globales.id_conductor inner join Personas on Personas.id=Conductores.id_persona where Viajes_globales.id='+pvc)
        conductor=CC.fetchone()
        cid=str(conductor[4])
        CC.execute('select Autos.matricula, Autos.modelo,Autos.marca,Autos.color,Autos.poliza from Autos inner join Conductores on Conductores.id_auto=Autos.id where Conductores.id='+cid)
        auto=CC.fetchone()
        CC.execute('select Personas.nombre,Personas.matricula,Personas.ap,Personas.am from Viajes inner join Pasajeros on Pasajeros.id=Viajes.id_pasajero inner join Personas on Personas.id=Pasajeros.id_persona where Viajes.id_viaje_global='+pvc)
        pasajeros=CC.fetchall()
        print(pasajeros[0])
        print(pasajeros[1])

        return render_template('pagina_principal_conductor.html',cond=conductor,pas=pasajeros,auto=auto)
    else:
        CC.execute('select id, nombre from Rutas')
        rutas=CC.fetchall()
        
        return render_template('pagina_principal_conductor.html',pvg=pvg,rutas=rutas,personaid=personaid)


#ejecucion del servidor y asignacion del puerto a trabajar
if __name__ == '__main__':
        app.run(port=5000 ,debug= True)

