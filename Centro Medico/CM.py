from flask import Flask, render_template, redirect, request, session,url_for,flash
from flask_session import Session
import pyodbc
 
app = Flask(__name__)
try:
    connection=pyodbc.connect('DSN=Centro_Medico;UID=VUPQ_admin;PWD=12345')
    print("Conexion exitosa")
    cursor=connection.cursor()
    cursor.commit()
except Exception as e:
    print("Ocurrió un error al conectar a SQL Server")
app.secret_key='mysecretkey'
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)
 
#perfil de médico
@app.route("/")
def index():
    if not session.get("RFC"):
        return redirect("/login")
    CC=connection.cursor()
    CC.execute("select P.nombre,P.ap+' '+P.am,P.telefono,P.correo,M.RFC,M.cedula,D.nombre,M.consultorio from Medicos as M inner join Personas as P on P.id=M.id_persona inner join Departamentos as D on D.id=M.id_departamento where RFC='"+session["RFC"]+"'")
    data_medico=CC.fetchone()
    CC.execute("select Pa.id, P.nombre+' '+P.ap+' '+P.am from Pacientes as Pa inner join Medicos as M on M.id=Pa.id_medico inner join Personas as P on P.id=Pa.id_persona where M.RFC='"+session["RFC"]+"'")
    pacientes=CC.fetchall()
    CC.execute("select id_rol from Medicos where RFC='"+session["RFC"]+"'")
    rol=CC.fetchone()
    rol=str(rol)
    return render_template('perfil_medico.html',data_medico=data_medico,pacientes=pacientes,rol=rol)
    
 
#inicio de sesion
@app.route("/login", methods=["POST", "GET"])
def login():
    if request.method == "POST":
        VRFC=request.form['txtRFC']
        VPassword=request.form['txtPassword']
        CC=connection.cursor()
        CC.execute("select id from Medicos where RFC='"+VRFC+"' and contraseña=hashbytes('MD4','"+VPassword+"')")
        Vid=CC.fetchone()
        Vnone=str(Vid)
        if Vnone=='None':
            flash('Usuario y/o contraseña equivocados, vuelva a intentarlo')
            return redirect("/login")
        else:
            session["RFC"] = request.form.get("txtRFC")
            return redirect("/")
    return render_template("login.html")

#perfil de paciente
@app.route("/paciente/<id_paciente>")
def paciente(id_paciente):
    if not session.get("RFC"):
        return redirect("/login")
    CC=connection.cursor()
    CC.execute("select P.nombre,P.ap+' '+P.am from Medicos as M inner join Personas as P on P.id=M.id_persona inner join Departamentos as D on D.id=M.id_departamento where RFC='"+session["RFC"]+"'")
    data_medico=CC.fetchone()
    CC.execute("select P.nombre,P.ap+' '+P.am,Pa.nacimiento,P.correo,P.telefono,Sexo.nombre,Pa.enfermedades,Pa.alergias,Pa.antecedentes from Pacientes as Pa inner join Personas as P on P.id=Pa.id_persona inner join Sexo on Sexo.id=Pa.id_sexo where Pa.id="+id_paciente)
    paciente=CC.fetchone()
    CC.execute("select Pa.id, P.nombre+' '+P.ap+' '+P.am from Pacientes as Pa inner join Medicos as M on M.id=Pa.id_medico inner join Personas as P on P.id=Pa.id_persona where M.RFC='"+session["RFC"]+"'")
    pacientes=CC.fetchall()
    CC.execute("select P.ap,P.am from Pacientes as Pa inner join Personas as P on P.id=Pa.id_persona where Pa.id="+id_paciente)
    apellidos=CC.fetchone()
    CC.execute("select id_rol from Medicos where RFC='"+session["RFC"]+"'")
    rol=CC.fetchone()
    rol=str(rol)
    CC.execute("select * from Consultas where id_paciente="+id_paciente)
    consultas=CC.fetchone()
    Vnone=str(consultas)
    print("doasdnofindoifas")
    print(Vnone)
    if Vnone=='None':
        return render_template('perfil_paciente.html',data_medico=data_medico,paciente=paciente,apellidos=apellidos,Vnone=Vnone,id_paciente=id_paciente,rol=rol,pacientes=pacientes)
    else:
        CC.execute("select * from Consultas where id_paciente="+id_paciente+" order by fecha desc")
        print("ondoinfaoinfiodfnoifdnoifnoidfnoinoisdfnvoids")
        Vnone='1'
        consultas=CC.fetchall()
        return render_template('perfil_paciente.html',data_medico=data_medico,paciente=paciente,apellidos=apellidos,Vnone=Vnone,consultas=consultas,id_paciente=id_paciente,rol=rol,pacientes=pacientes)

#consulta específica de paciente    
@app.route("/paciente/<id_paciente>/<id2>")
def paciente_consulta(id_paciente,id2):
    if not session.get("RFC"):
        return redirect("/login")
    CC=connection.cursor()
    CC.execute("select P.nombre,P.ap+' '+P.am from Medicos as M inner join Personas as P on P.id=M.id_persona inner join Departamentos as D on D.id=M.id_departamento where RFC='"+session["RFC"]+"'")
    data_medico=CC.fetchone()
    CC.execute("select P.nombre,P.ap+' '+P.am,Pa.nacimiento,P.correo,P.telefono,Sexo.nombre,Pa.enfermedades,Pa.alergias,Pa.antecedentes from Pacientes as Pa inner join Personas as P on P.id=Pa.id_persona inner join Sexo on Sexo.id=Pa.id_sexo where Pa.id="+id_paciente)
    paciente=CC.fetchone()
    CC.execute("select Pa.id, P.nombre+' '+P.ap+' '+P.am from Pacientes as Pa inner join Medicos as M on M.id=Pa.id_medico inner join Personas as P on P.id=Pa.id_persona where M.RFC='"+session["RFC"]+"'")
    pacientes=CC.fetchall()
    CC.execute("select P.ap,P.am from Pacientes as Pa inner join Personas as P on P.id=Pa.id_persona where Pa.id="+id_paciente)
    apellidos=CC.fetchone()
    CC.execute("select id_rol from Medicos where RFC='"+session["RFC"]+"'")
    rol=CC.fetchone()
    rol=str(rol)
    CC.execute("select * from Consultas where id="+id2)
    consulta=CC.fetchone()
    CC.execute("select * from Consultas where id_paciente="+id_paciente+" order by fecha desc")
    consultas=CC.fetchall()
    return render_template('perfil_paciente_consulta.html',data_medico=data_medico,paciente=paciente,apellidos=apellidos,consulta=consulta,id_paciente=id_paciente,id2=id2,consultas=consultas,rol=rol,pacientes=pacientes)

#nueva connsulta
@app.route("/nueva_consulta/<id_paciente>", methods=["POST", "GET"])
def nueva_consulta(id_paciente):
    a=id_paciente
    CC=connection.cursor()
    CC.execute("select id_rol from Medicos where RFC='"+session["RFC"]+"'")
    rol=CC.fetchone()
    rol=str(rol)
    CC.execute("select Pa.id, P.nombre+' '+P.ap+' '+P.am from Pacientes as Pa inner join Medicos as M on M.id=Pa.id_medico inner join Personas as P on P.id=Pa.id_persona where M.RFC='"+session["RFC"]+"'")
    pacientes=CC.fetchall()
    if request.method == "POST":
        VPeso=request.form['txtPeso']
        VEstatura=request.form['txtEstatura']
        VTemperatura=request.form['txtTemperatura']
        VRitmo_Cardiaco=request.form['txtRitmo_Cardiaco']
        VPresion=request.form['txtPresion']
        VOxigeno=request.form['txtSaturacion_Oxigeno']
        VGlucosa=request.form['txtGlucosa']
        VSintomatologia=request.form['txtSintomatologia']
        VDiagnostico=request.form['txtDiagnostico']
        VReceta=request.form['txtReceta']
        VExamenes=request.form['txtExamenes']
        CC.execute("insert into Consultas(id_paciente,fecha,peso,altura,temperatura,ritmo_cardiaco,presion,saturacion_oxigeno,glucosa,sintomatologia,diagnostico,receta,examenes) values ("+id_paciente+",GETDATE(),"+VPeso+","+VEstatura+","+VTemperatura+","+VRitmo_Cardiaco+",'"+VPresion+"',"+VOxigeno+","+VGlucosa+",'"+VSintomatologia+"','"+VDiagnostico+"','"+VReceta+"','"+VExamenes+"')")
        CC.commit()
        flash('Se guardó la consulta con éxito')
        return redirect(url_for('paciente',id_paciente=a))
    if not session.get("RFC"):
        return redirect("/login")
    CC.execute("select P.nombre,P.ap+' '+P.am from Medicos as M inner join Personas as P on P.id=M.id_persona inner join Departamentos as D on D.id=M.id_departamento where RFC='"+session["RFC"]+"'")
    data_medico=CC.fetchone()
    CC.execute("select P.nombre,P.ap+' '+P.am,Pa.nacimiento,P.correo,P.telefono,Sexo.nombre,Pa.enfermedades,Pa.alergias,Pa.antecedentes from Pacientes as Pa inner join Personas as P on P.id=Pa.id_persona inner join Sexo on Sexo.id=Pa.id_sexo where Pa.id="+id_paciente)
    paciente=CC.fetchone()
    return render_template("nueva_consulta.html",data_medico=data_medico,paciente=paciente,id_paciente=id_paciente,rol=rol,pacientes=pacientes)

#editar datos paciente
@app.route("/editar_paciente/<id_paciente>", methods=["POST"])
def editar_paciente(id_paciente):
    a=id_paciente
    CC=connection.cursor()
    CC.execute("select id_persona from Pacientes where id="+id_paciente)
    id_persona=CC.fetchone()
    id_persona=str(id_persona[0])
    if request.method == "POST":
        Vnombre=request.form['txtNombre']
        VAP=request.form['txtAP']
        VAM=request.form['txtAM']
        VTelefono=request.form['txtTelefono']
        VCorreo=request.form['txtCorreo']
        VNacimiento=request.form['txtNacimiento']
        VSexo=request.form['txtSexo']
        VEnfermedades=request.form['txtEnfermedades']
        VAlergias=request.form['txtAlergias']
        VAntecedentes=request.form['txtAntecedentes']
        CC.execute("exec sp_editar_paciente "+id_persona+",'"+Vnombre+"','"+VAP+"','"+VAM+"','"+VTelefono+"','"+VCorreo+"','"+VNacimiento+"',"+VSexo+",'"+VEnfermedades+"','"+VAlergias+"','"+VAntecedentes+"'")
        CC.commit()
        flash('Se cambiaron los datos correctamente')
        return redirect(url_for('paciente',id_paciente=a))
    
#ingresar datos paciente
@app.route("/ingresar_paciente", methods=["POST"])
def ingresar_paciente():
    CC=connection.cursor()
    CC.execute("select id from Medicos where RFC='"+session["RFC"]+"'")
    id_medico=CC.fetchone()
    id_medico=str(id_medico[0])
    if request.method == "POST":
        Vnombre=request.form['txtNombre']
        VAP=request.form['txtAP']
        VAM=request.form['txtAM']
        VTelefono=request.form['txtTelefono']
        VCorreo=request.form['txtCorreo']
        VNacimiento=request.form['txtNacimiento']
        VSexo=request.form['txtSexo']
        VEnfermedades=request.form['txtEnfermedades']
        VAlergias=request.form['txtAlergias']
        VAntecedentes=request.form['txtAntecedentes']
        CC.execute("exec sp_insertar_paciente '"+Vnombre+"','"+VAP+"','"+VAM+"','"+VTelefono+"','"+VCorreo+"',"+id_medico+",'"+VNacimiento+"',"+VSexo+",'"+VEnfermedades+"','"+VAlergias+"','"+VAntecedentes+"'")
        CC.commit()
        flash('Se agregó el paciente correctamente')
        return redirect(url_for('index'))
    
#cambiar contraseña
@app.route("/cambiar_contraseña", methods=["POST"])
def cambiar_contraseña():
    CC=connection.cursor()
    CC.execute("select id from Medicos where RFC='"+session["RFC"]+"'")
    id_medico=CC.fetchone()
    id_medico=str(id_medico[0])
    if request.method == "POST":
        VPass=request.form['txtPassword']
        VCPass=request.form['txtConfirmPassword']
        if VPass==VCPass:
            CC.execute("update Medicos set contraseña = hashbytes('MD4','"+VPass+"') where id="+id_medico)
            CC.commit()
            flash('Se cambio la contraseña correctamente')
            return redirect(url_for('index'))
        else:
            flash('Las contraseñas no coinciden')
            return redirect(url_for('index'))
        
#administracion
@app.route("/administracion")
def administracion():
    if not session.get("RFC"):
        return redirect("/login")
    CC=connection.cursor()
    CC.execute("select id_rol from Medicos where RFC='"+session["RFC"]+"'")
    rol=CC.fetchone()
    rol=str(rol)
    CC.execute("select Pa.id, P.nombre+' '+P.ap+' '+P.am from Pacientes as Pa inner join Medicos as M on M.id=Pa.id_medico inner join Personas as P on P.id=Pa.id_persona where M.RFC='"+session["RFC"]+"'")
    pacientes=CC.fetchall()
    CC.execute("select P.id,P.nombre+' '+P.ap+' '+P.am,M.RFC,M.cedula,R.nombre,D.nombre,M.consultorio from Medicos as M inner join Personas as P on P.id=M.id_persona inner join Roles as R on R.id=M.id_rol inner join Departamentos as D on D.id=M.id_departamento where M.visibilidad=1")
    medicos=CC.fetchall()
    CC.execute("select * from Departamentos")
    departamentos=CC.fetchall()
    return render_template('administrador.html',medicos=medicos,departamentos=departamentos,rol=rol,pacientes=pacientes)

#insertar nuevo medico
@app.route("/ingresar_medico", methods=["POST"])
def ingresar_medico():
    CC=connection.cursor()
    if request.method == "POST":
        Vnombre=request.form['txtNombre']
        VAP=request.form['txtAP']
        VAM=request.form['txtAM']
        VTelefono=request.form['txtTelefono']
        VCorreo=request.form['txtCorreo']
        VRFC=request.form['txtRFC']
        VCedula=request.form['txtCedula']
        VRol=request.form['txtRol']
        VDepartamento=request.form['txtDepartamento']
        VConsultorio=request.form['txtConsultorio']
        VPassword=request.form['txtPassword']
        VCPassword=request.form['txtConfirmPassword']
        if VPassword==VCPassword:
            CC.execute("exec sp_insertar_medicos '"+Vnombre+"','"+VAP+"','"+VAM+"','"+VTelefono+"','"+VCorreo+"','"+VRFC+"','"+VCedula+"','"+VPassword+"',"+VRol+","+VDepartamento+",'"+VConsultorio+"'")
            CC.commit()
            flash('Se agregó el médico correctamente')
            return redirect(url_for('administracion'))
        else:
            flash('Las contraseñas no coinciden, no se registró al médico')
            return redirect(url_for('administracion'))
        
#editar medico
@app.route("/editar_medico/<id_persona>", methods=["POST", "GET"])
def editar_medico(id_persona):
    CC=connection.cursor()
    CC.execute("select * from Departamentos")
    departamentos=CC.fetchall()
    CC.execute("select P.nombre,P.ap,P.am,P.telefono,P.correo,M.RFC,M.cedula,R.nombre,D.nombre,M.consultorio from Medicos as M inner join Personas as P on P.id=M.id_persona inner join Roles as R on R.id=M.id_rol inner join Departamentos as D on D.id=M.id_departamento where P.id="+id_persona)
    medicos=CC.fetchone()
    CC.execute("select id_rol from Medicos where RFC='"+session["RFC"]+"'")
    rol=CC.fetchone()
    rol=str(rol)
    CC.execute("select Pa.id, P.nombre+' '+P.ap+' '+P.am from Pacientes as Pa inner join Medicos as M on M.id=Pa.id_medico inner join Personas as P on P.id=Pa.id_persona where M.RFC='"+session["RFC"]+"'")
    pacientes=CC.fetchall()
    if request.method == "POST":
        Vnombre=request.form['txtNombre']
        VAP=request.form['txtAP']
        VAM=request.form['txtAM']
        VTelefono=request.form['txtTelefono']
        VCorreo=request.form['txtCorreo']
        VRFC=request.form['txtRFC']
        VCedula=request.form['txtCedula']
        VRol=request.form['txtRol']
        VDepartamento=request.form['txtDepartamento']
        VConsultorio=request.form['txtConsultorio']
        CC.execute("exec sp_editar_medico "+id_persona+",'"+Vnombre+"','"+VAP+"','"+VAM+"','"+VTelefono+"','"+VCorreo+"','"+VRFC+"','"+VCedula+"',"+VRol+","+VDepartamento+",'"+VConsultorio+"'")
        CC.commit()
        flash('Se editó el médico correctamente')
        return redirect(url_for('administracion'))
    return render_template('editar_medico.html',departamentos=departamentos,medicos=medicos,id_persona=id_persona,rol=rol,pacientes=pacientes)

#eliminar medico
@app.route("/eliminar_medico/<id_persona>", methods=["POST", "GET"])
def eliminar_medico(id_persona):
    CC=connection.cursor()
    CC.execute("select * from Departamentos")
    departamentos=CC.fetchall()
    CC.execute("select P.nombre,P.ap,P.am,P.telefono,P.correo,M.RFC,M.cedula,R.nombre,D.nombre,M.consultorio from Medicos as M inner join Personas as P on P.id=M.id_persona inner join Roles as R on R.id=M.id_rol inner join Departamentos as D on D.id=M.id_departamento where P.id="+id_persona)
    medicos=CC.fetchone()
    CC.execute("select id_rol from Medicos where RFC='"+session["RFC"]+"'")
    rol=CC.fetchone()
    rol=str(rol)
    CC.execute("select Pa.id, P.nombre+' '+P.ap+' '+P.am from Pacientes as Pa inner join Medicos as M on M.id=Pa.id_medico inner join Personas as P on P.id=Pa.id_persona where M.RFC='"+session["RFC"]+"'")
    pacientes=CC.fetchall()
    if request.method == "POST":
        CC.execute("update Medicos set visibilidad=0 where id_persona="+id_persona)
        CC.commit()
        flash('Se eliminó el médico correctamente')
        return redirect(url_for('administracion'))
    return render_template('eliminar_medico.html',departamentos=departamentos,medicos=medicos,id_persona=id_persona,rol=rol,pacientes=pacientes)

#generar pdf
@app.route("/receta/<id_paciente>/<id2>")
def receta(id_paciente,id2):
    if not session.get("RFC"):
        return redirect("/login")
    CC=connection.cursor()
    CC.execute("select P.nombre,P.ap+' '+P.am from Medicos as M inner join Personas as P on P.id=M.id_persona inner join Departamentos as D on D.id=M.id_departamento where RFC='"+session["RFC"]+"'")
    data_medico=CC.fetchone()
    CC.execute("select Pa.id, P.nombre+' '+P.ap+' '+P.am from Pacientes as Pa inner join Medicos as M on M.id=Pa.id_medico inner join Personas as P on P.id=Pa.id_persona where M.RFC='"+session["RFC"]+"'")
    pacientes=CC.fetchall()
    CC.execute("select P.nombre,P.ap+' '+P.am,Pa.nacimiento,P.correo,P.telefono,Sexo.nombre,Pa.enfermedades,Pa.alergias,Pa.antecedentes from Pacientes as Pa inner join Personas as P on P.id=Pa.id_persona inner join Sexo on Sexo.id=Pa.id_sexo where Pa.id="+id_paciente)
    paciente=CC.fetchone()
    CC.execute("select P.ap,P.am from Pacientes as Pa inner join Personas as P on P.id=Pa.id_persona where Pa.id="+id_paciente)
    apellidos=CC.fetchone()
    CC.execute("select id_rol from Medicos where RFC='"+session["RFC"]+"'")
    rol=CC.fetchone()
    rol=str(rol)
    CC.execute("select * from Consultas where id="+id2)
    consulta=CC.fetchone()
    CC.execute("select * from Consultas where id_paciente="+id_paciente+" order by fecha desc")
    consultas=CC.fetchall()
    return render_template('receta.html',data_medico=data_medico,paciente=paciente,apellidos=apellidos,consulta=consulta,id_paciente=id_paciente,id2=id2,consultas=consultas,rol=rol,pacientes=pacientes)
 
@app.route("/logout")
def logout():
    session["RFC"] = None
    return redirect("/")
 
 
if __name__ == "__main__":
    app.run(debug=True)