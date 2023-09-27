#importación del framework
from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_mysqldb import MySQL

#inicialización del APP
app= Flask(__name__)
#conexion
app.config['MYSQL_HOST']='localhost'
app.config['MYSQL_USER']='root'
app.config['MYSQL_PASSWORD']=''
app.config['MYSQL_DB']='carpool'
app.secret_key= 'mysecretkey'
mysql= MySQL(app)

@app.route('/')
def index():
    if not session.get("Matricula"):
            return redirect("/login")
    return redirect("/logout")

#iniciar sesion
@app.route("/login", methods=["POST", "GET"])
def login():
    CC=mysql.connection.cursor()
    if request.method == "POST":
        VMatricula=request.form['txtMatricula']
        VPassword=request.form['txtPassword']
        VTipo=request.form['txtTipo']
        CC.execute("select Matricula from vw_inscripciones where matricula='"+VMatricula+"' and clave_ingreso='"+VPassword+"';")
        Vid=CC.fetchone()
        Vnone=str(Vid)
        if Vnone=='None':
            flash('Usuario y/o contraseña equivocados, vuelva a intentarlo')
            return redirect("/login")
        else:
            session["Matricula"] = request.form.get("txtMatricula")
            #rol de conductor
            if VTipo=="1":
                session["Rol"]=1
                CC.execute("select id_conductor from conductor where matricula='"+session["Matricula"]+"';")
                Vid=CC.fetchone()
                Vnone=str(Vid)
                if Vnone=='None':
                    CC.execute("insert into conductor(matricula) values (%s);",(session["Matricula"],))
                    mysql.connection.commit()
                    CC.execute("select id_conductor from conductor where matricula='"+session["Matricula"]+"';")
                    Vid=CC.fetchone()
                    session["Conductor"]=Vid[0]
                else:
                    CC.execute("select id_conductor from conductor where matricula='"+session["Matricula"]+"';")
                    Vid=CC.fetchone()
                    session["Conductor"]=Vid[0]
                return redirect("/conductor")
            #rol de pasajero
            if VTipo=="2":
                CC.execute("select id_pasajero from pasajero where matricula='"+session["Matricula"]+"';")
                Vid=CC.fetchone()
                
                Vnone=str(Vid)
                if Vnone=='None':
                    CC.execute("insert into pasajero(matricula) values (%s);",(session["Matricula"],))
                    mysql.connection.commit()
                    CC.execute("select id_pasajero from pasajero where matricula='"+session["Matricula"]+"';")
                    Vid=CC.fetchone()
                    session["Pasajero"]=Vid[0]
                else:
                    CC.execute("select id_pasajero from pasajero where matricula='"+session["Matricula"]+"';")
                    Vid=CC.fetchone()
                    session["Conductor"]=Vid[0]
                return redirect("/pasajero")
            #rol de administrador
            if VTipo=="3":
                session["Rol"]=3
                return redirect("/admin")
    return render_template("login.html")

#cerrar sesion
@app.route("/logout")
def logout():
    session["Matricula"] = None
    session["Conductor"] = None
    session["Pasajero"] = None
    session["Admin"] = None
    session["Rol"] = None
    return redirect("/login")

#home de conductor
@app.route('/conductor')
def conductor():
    if not session.get("Matricula"):
            return redirect("/login")
    CC=mysql.connection.cursor()
    CC.execute("select * from conductor where id_conductor='"+str(session["Conductor"])+"';")
    Vid=CC.fetchone()
    if Vid[2]==0:
        return redirect("/conductor/perfil")
    else:
        CC.execute("select * from Ruta where id_conductor=%s",(session["Conductor"],))
        rutas=CC.fetchall()
        CC.execute("select id_ruta from Ruta where id_conductor=%s",(session["Conductor"],))
        Vnone=str(CC.fetchone())
        CC.execute("select punto_referencia,descripcion,hora,p.id_ruta from paradas as p inner join ruta as r on p.id_ruta=r.id_ruta where r.id_conductor=%s",(session["Conductor"],))
        paradas=CC.fetchall()
        return render_template('HomeConductor.html',rutas=rutas,Vnone=Vnone,paradas=paradas)

#perfil de conductor
@app.route('/conductor/perfil')
def perfilconductor():
    if not session.get("Matricula"):
            return redirect("/login")
    CC=mysql.connection.cursor()
    CC.execute("select matricula, nombre_completo, cuatrimestre, nombre_carrera, sexo, correo_electronico, fecha_nacimiento, nss from vw_inscripciones where matricula='"+session["Matricula"]+"';")
    datos_personales=CC.fetchone()
    temp=[]
    for i in datos_personales[1].split():
        temp.append(i)
    if len(temp)==3:
        nombre=temp[0]
        del temp[0]
    else:
        nombre=[]
        nombre.append(temp[0])
        del temp[0]
        nombre.append(temp[0])
        del temp[0]
    CC.execute("select placa,modelo,marca,color,lugares_disponibles from relacion_autos as ra inner join autos as a on ra.id_auto=a.id_auto where id_conductor=%s",(session["Conductor"],))
    autos=CC.fetchall()
    
    return render_template('Perfil2.html',datos=datos_personales,nombre=nombre,apellidos=temp,autos=autos)

#insertar auto
@app.route('/ingresar_auto', methods=['POST'])
def ingresar_auto():
    if request.method == 'POST':
        VMarca=request.form['txtMarca']
        VModelo=request.form['txtModelo']
        VColor=request.form['txtColor']
        VCapacidad=request.form['txtCapacidad']
        VPlaca=request.form['txtPlaca']
        
        """ VTarjeta=request.files['imgTarjeta']
        VCredencial=request.files['imgCredencial']
        VINE=request.files['imgINE']
        VPoliza=request.files['imgPoliza'] """
        
        CC= mysql.connection.cursor()
        CC.execute("insert into autos(placa,modelo,marca,color,lugares_disponibles) values (%s,%s,%s,%s,%s);",(VPlaca,VModelo,VMarca,VColor,VCapacidad))
        
        """ CC.execute("update conductor set INE="+VINE+" where matricula='%s';",str(session["Matricula"]))
        CC.execute("update conductor set CredencialUPQ="+VCredencial+" where matricula=%s;",str(session["Matricula"])) """ 
        CC.execute("select id_auto FROM autos WHERE placa=%s",(str(VPlaca),))
        autoid=CC.fetchone()
        CC.execute("insert into relacion_autos(id_conductor,id_auto) values(%s,%s);",(session["Conductor"],autoid[0],))
        CC.execute("update conductor set primer_ingreso_flag=1")
        mysql.connection.commit()
    return redirect('/conductor/perfil')

#cambio de contraseña conductor
@app.route('/cambiar_contraseña', methods=['POST'])
def cambiar_contraseña():
    if request.method == 'POST':
        Vpassword=request.form['txtPassword']
        Vpasscon=request.form['txtConfirmPassword']
        if Vpassword==Vpasscon:
            CC= mysql.connection.cursor()
            CC.execute("update vw_inscripciones set clave_ingreso=%s where matricula=%s;",(str(Vpassword),str(session["Matricula"])))
            mysql.connection.commit()
    return redirect('/conductor/perfil')

#registrar ruta
@app.route('/registrar_ruta', methods=['POST'])
def registro_ruta():
    if request.method == 'POST':
        Vruta=request.form['txtRuta']
        Vturno=request.form['txtTurno']
        CC= mysql.connection.cursor()
        CC.execute("insert into Ruta(nombre_ruta,id_conductor,tipo_ruta) values (%s,%s,%s)",(Vruta,session["Conductor"],Vturno))
        CC.execute("select id_ruta from Ruta where nombre_ruta=%s and id_conductor=%s",(Vruta,session["Conductor"],))
        id_ruta=CC.fetchone()
        id=id_ruta[0]
        mysql.connection.commit()
    return redirect(url_for('registrar_parada',id=id))

#registrar paradas
@app.route('/conductor/ruta/<id>')
def registrar_parada(id):
    if not session.get("Matricula"):
        return redirect("/login")
    CC= mysql.connection.cursor()
    CC.execute("select nombre_ruta, descripcion_completa from Ruta where id_ruta=%s",(id,))
    desc=CC.fetchone()
    id2=id
    CC.execute("select punto_referencia, descripcion, hora from Paradas where id_ruta=%s",(id,))
    paradas=CC.fetchall()
    return render_template('RegistroRuta.html',desc=desc,id=id2,paradas=paradas)

#añadir paradas
@app.route('/cargarparada/<id>', methods=['POST'])
def cargarparada(id):
    VReferencia=request.form['txtreferencia']
    VDescripcion=request.form['txtdescripcion']
    VHora=request.form['txthora']
    VDesGral=request.form['txtdesgral']
    CC= mysql.connection.cursor()
    CC.execute("insert into paradas(punto_referencia,descripcion,hora,id_ruta) values (%s,%s,%s,%s)",(VReferencia,VDescripcion,VHora,id,))
    CC.execute("update Ruta set descripcion_completa=%s where id_ruta=%s",(VDesGral,id,))
    mysql.connection.commit()
    id2=id
    return redirect(url_for('registrar_parada',id=id2))

#pagina principal pasajero 
@app.route('/pasajero')
def pasajero():
    CC=mysql.connection.cursor()
    CC.execute("select * from pasajero where id_pasajero='"+str(session["Pasajero"])+"';")
    Vid=CC.fetchone()
    
    Vnone=str(Vid)
    print(Vnone)
    if Vnone=='None':
        return redirect("/pasajero/ruta")
    else:
        CC.execute("select * from Ruta where id_conductor=%s",(session["Conductor"],))
        rutas=CC.fetchall()
        CC.execute("select id_ruta from Ruta where id_conductor=%s",(session["Conductor"],))
        Vnone=str(CC.fetchone())
        CC.execute("select punto_referencia,descripcion,hora,p.id_ruta from paradas as p inner join ruta as r on p.id_ruta=r.id_ruta where r.id_conductor=%s",(session["Conductor"],))
        paradas=CC.fetchall()
        return render_template('HomePasajero.html',rutas=rutas,Vnone=Vnone,paradas=paradas)
    
@app.route('/pasajero/ruta')
def reservar_ruta():
    if not session.get("Matricula"):
        return redirect("/login")
    CC= mysql.connection.cursor()
    CC.execute("select nombre_ruta, descripcion_completa from Ruta where id_ruta=%s",(id,))
    desc=CC.fetchone()
    id2=id
    CC.execute("select punto_referencia, descripcion, hora from Paradas where id_ruta=%s",(id,))
    paradas=CC.fetchall()
    return render_template('Rutas.html',desc=desc,id=id2,paradas=paradas)

@app.route('/admin')
def admin():
    if not session.get("Matricula"):
            return redirect("/login")
    return render_template('Administrador.html')

#ejecución del servidor en el puerto 5000
if __name__ == '__main__':
    app.run(port=5000, debug=True)