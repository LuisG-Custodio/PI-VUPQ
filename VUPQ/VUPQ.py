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
            CC.execute("select id from Personas where matricula="+Vmatricula)
            idpersona=CC.fetchone()
            idpersona=str(idpersona[0])
            Vmatricula=str(Vmatricula)
            CC.execute("insert into Autos(matricula) values ('"+Vmatricula+"')")
            CC.execute("select id from Autos where matricula='"+Vmatricula+"'")
            idautos=CC.fetchone()
            idautos=str(idautos[0])
            CC.execute("insert into Pasajeros(id_persona) values ("+idpersona+")")
            CC.execute("insert into Conductores(id_auto,id_persona) values ("+idautos+","+idpersona+")")
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

        return render_template('pagina_principal.html',cond=conductor,pas=pasajeros,auto=auto)
    else:
        CC.execute("select Viajes_globales.id,Viajes_globales.id_ruta,Personas.nombre+' '+Personas.ap+' '+personas.am from Viajes_globales inner join Conductores on Conductores.id=Viajes_globales.id_conductor inner join Autos on Autos.id=Conductores.id_auto inner join Personas on Personas.id=Conductores.id_persona where Viajes_globales.estado=0 and Autos.lugares_disponibles!=0")
        viajes_disponibles=CC.fetchall()
        CC.execute('select id,nombre from Paradas')
        paradas=CC.fetchall()
        
        return render_template('pagina_principal.html',pvg=pvg,viajes_disponibles=viajes_disponibles,paradas=paradas,personaid=personaid)

#reservar viaje por parte del pasajero   
@app.route('/reservarviaje/<personaid>', methods=['POST'])
def reservarviaje(personaid):
    if request.method == 'POST':
        a=personaid
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
        return redirect(url_for('homepage',personaid=a))

#perfil del pasajero
@app.route('/homepage/pasajero/perfil/<personaid>')
def perfilpasajero(personaid):
    CC=connection.cursor()
    CC.execute('select nombre,matricula,ap,am,telefono,id_genero from Personas where id='+personaid)
    pasajero=CC.fetchone()
    return render_template('Perfil_pasajero.html',pasajero=pasajero,personaid=personaid)

#actualizar pasajero
@app.route('/actualizarpersona/<personaid>', methods=['POST'])
def actualizarpersona(personaid):
    if request.method == 'POST':
        a=personaid
        Vmatricula=request.form['txtMatricula']
        Vnombre=request.form['txtNombre']
        V_ap=request.form['txtAP']
        V_am=request.form['txtAM']
        Vtelefono=request.form['txtTelefono']
        Vgenero=request.form['txtGenero']
        CC=connection.cursor()
        CC.execute("update Personas set nombre='"+Vnombre+"'where id="+personaid)
        CC.execute("update Personas set matricula="+Vmatricula+"where id="+personaid)
        CC.execute("update Personas set ap='"+V_ap+"'where id="+personaid)
        CC.execute("update Personas set am='"+V_am+"'where id="+personaid)
        CC.execute("update Personas set telefono='"+Vtelefono+"'where id="+personaid)
        CC.execute("update Personas set id_genero="+Vgenero+"where id="+personaid)
        CC.commit()
        flash('Se actualizaron tus datos personales con éxito')
        return redirect(url_for('homepage',personaid=a))  
          
#menu principal de conductor
@app.route('/homepage/conductor/<personaid>')
def homepagec(personaid):
    CC=connection.cursor()
    CC.execute('select id from Conductores where id_persona= '+personaid)
    conductorid=CC.fetchone()
    conductorid=str(conductorid[0])
    print(conductorid)
    CC.execute('select id from Viajes_globales where estado=0 and id_conductor='+conductorid)
    pvg=CC.fetchone()
    pvg=str(pvg)
    print (pvg)
    if(pvg!="None"):
        CC.execute('select id from Viajes_globales where estado=0 and id_conductor='+conductorid)
        pvg=CC.fetchone()
        pvg=str(pvg[0])
        CC.execute('select Personas.nombre,Personas.matricula,Personas.ap,Personas.am, Conductores.id from Conductores inner join Personas on Personas.id=Conductores.id_persona where Conductores.id='+conductorid)
        conductor=CC.fetchone()
        CC.execute('select Autos.matricula, Autos.modelo,Autos.marca,Autos.color,Autos.poliza from Autos inner join Conductores on Conductores.id_auto=Autos.id where Conductores.id='+conductorid)
        auto=CC.fetchone()
        CC.execute('select Personas.nombre,Personas.matricula,Personas.ap,Personas.am from Viajes inner join Pasajeros on Pasajeros.id=Viajes.id_pasajero inner join Personas on Personas.id=Pasajeros.id_persona where Viajes.id_viaje_global='+pvg)
        pasajeros=CC.fetchall()
        return render_template('pagina_principal_conductor.html',cond=conductor,pas=pasajeros,auto=auto,personaid=personaid)
    else:
        CC.execute('select id, nombre from Rutas')
        rutas=CC.fetchall() 
        return render_template('pagina_principal_conductor.html',pvg=pvg,rutas=rutas,personaid=personaid)

#crear viaje por parte del condcuctor
@app.route('/crearviaje/<personaid>', methods=['POST'])
def crearviaje(personaid):
    if request.method == 'POST':
        a=personaid
        print("ndvjansindoivnsoian")
        rutaid=request.form['txtRuta']
        CC=connection.cursor()
        CC.execute('select id from Conductores where id_persona= '+personaid)
        conductorid=CC.fetchone()
        rutaid=str(rutaid)
        conductorid=str(conductorid[0])
        CC.execute("exec sp_crear_viaje "+conductorid+","+rutaid)
        flash('Se reservó tu viaje con éxito')
        return redirect(url_for('homepagec',personaid=a))
    
#perfil del conductor
@app.route('/homepage/conductor/perfil/<personaid>')
def perfilconductor(personaid):
    CC=connection.cursor()
    CC.execute('select nombre,matricula,ap,am,telefono,id_genero from Personas where id='+personaid)
    conductor=CC.fetchone()
    CC.execute('select Autos.id, matricula, modelo, marca, color, poliza, id_tipo_auto from Autos inner join Conductores on Conductores.id_auto=Autos.id where Conductores.id_persona='+personaid)
    automovil=CC.fetchone()
    return render_template('Perfil_conductor.html',conductor=conductor,automovil=automovil,personaid=personaid)


#actualizar conductor
@app.route('/actualizarpersonaC/<personaid>', methods=['POST'])
def actualizarpersonac(personaid):
    if request.method == 'POST':
        a=personaid
        Vmatricula=request.form['txtMatricula']
        Vnombre=request.form['txtNombre']
        V_ap=request.form['txtAP']
        V_am=request.form['txtAM']
        Vtelefono=request.form['txtTelefono']
        Vgenero=request.form['txtGenero']
        CC=connection.cursor()
        CC.execute("update Personas set nombre='"+Vnombre+"'where id="+personaid)
        CC.execute("update Personas set matricula="+Vmatricula+"where id="+personaid)
        CC.execute("update Personas set ap='"+V_ap+"'where id="+personaid)
        CC.execute("update Personas set am='"+V_am+"'where id="+personaid)
        CC.execute("update Personas set telefono='"+Vtelefono+"'where id="+personaid)
        CC.execute("update Personas set id_genero="+Vgenero+"where id="+personaid)
        CC.commit()
        flash('Se actualizaron tus datos personales con éxito')
        return redirect(url_for('homepagec',personaid=a))    

#actualizar auto
@app.route('/actualizarauto/<personaid>', methods=['POST'])
def actualizarauto(personaid):
    if request.method == 'POST':
        a=personaid
        VPlacas=request.form['txtPlacas']
        VModelo=request.form['txtModelo']
        VMarca=request.form['txtMarca']
        VColor=request.form['txtColor']
        VPoliza=request.form['txtPoliza']
        VTipo=request.form['txtTipo']
        CC=connection.cursor()
        CC.execute("select id_auto from Conductores where id_persona="+personaid)
        auto=CC.fetchone()
        auto=str(auto[0])
        print(auto)
        CC.execute("update Autos set matricula='"+VPlacas+"'where id="+auto)
        CC.execute("update Autos set modelo='"+VModelo+"'where id="+auto)
        CC.execute("update Autos set marca='"+VMarca+"'where id="+auto)
        CC.execute("update Autos set color='"+VColor+"'where id="+auto)
        CC.execute("update Autos set poliza='"+VPoliza+"'where id="+auto)
        CC.execute("update Autos set id_tipo_auto="+VTipo+" where id="+auto)
        CC.commit()
        CC.execute('exec sp_restablecer_lugares '+auto)
        flash('Se actualizaron los datos de tu vehiculo con éxito')
        return redirect(url_for('homepagec',personaid=a)) 

@app.route('/actualizarpassword/<personaid>', methods=['POST'])
def actualizarpassword(personaid):
    if request.method == 'POST':
        a=personaid
        Vpassword=request.form['txtPassword']
        Vcpassword=request.form['txtConfirmPassword']
        if (Vpassword==Vcpassword):
            CC=connection.cursor()
            Vpassword=str(Vpassword)
            CC.execute("update Personas set contraseña='"+Vpassword+"' where id="+personaid)
            CC.commit()
            flash('Se actualizaron tu contraseña con éxito')
            return redirect(url_for('homepage',personaid=a))  
        else:
            flash('No se actualizó tu contraseña')
            return redirect(url_for('homepage',personaid=a))  
        
@app.route('/actualizarpasswordc/<personaid>', methods=['POST'])
def actualizarpasswordc(personaid):
    if request.method == 'POST':
        a=personaid
        Vpassword=request.form['txtPassword']
        Vcpassword=request.form['txtConfirmPassword']
        if (Vpassword==Vcpassword):
            CC=connection.cursor()
            Vpassword=str(Vpassword)
            CC.execute("update Personas set contraseña='"+Vpassword+"' where id="+personaid)
            CC.commit()
            flash('Se actualizaron tu contraseña con éxito')
            return redirect(url_for('homepagec',personaid=a))  
        else:
            flash('No se actualizó tu contraseña')
            return redirect(url_for('homepagec',personaid=a))  
        
@app.route('/finalizarviaje/<personaid>', methods=['POST'])
def finalizarviaje(personaid):
    if request.method == 'POST':
        a=personaid
        CC=connection.cursor()
        CC.execute('select id from Conductores where id_persona='+personaid)
        conductor=CC.fetchone()
        conductor=str(conductor[0])
        CC.execute('select id from Viajes_globales where id_conductor='+conductor+'and estado=0')
        vg=CC.fetchone()
        vg=str(vg[0])
        CC.execute('update Viajes_globales set estado=1 where id='+vg)
        CC.commit()
        CC.execute("select id_auto from Conductores where id_persona="+personaid)
        auto=CC.fetchone()
        auto=str(auto[0])
        CC.execute('exec sp_restablecer_lugares '+auto)
        flash('Viaje finalizado')
        return redirect(url_for('homepagec',personaid=a)) 
    

#pagos pendientes de pasajero
@app.route('/homepage/pasajero/pagos/<personaid>')
def pagospasajero(personaid):
    CC=connection.cursor()
    CC.execute('select Pagos.id_viaje,Pagos.fecha,Pagos.id_tipo_pago,Rutas.nombre,Paradas.nombre, Pagos.monto from Pagos inner join Viajes on Viajes.id=Pagos.id_viaje inner join Pasajeros on Pasajeros.id=Viajes.id_pasajero inner join Paradas on Paradas.id=Viajes.id_parada inner join Viajes_globales on Viajes_globales.id=Viajes.id_viaje_global inner join Rutas on Rutas.id=Viajes_globales.id_ruta where Pasajeros.id_persona='+personaid)
    datospago=CC.fetchall()
    return render_template('pagos.html',datos=datospago,personaid=personaid)

#pagos pendientes de pasajero
@app.route('/homepage/conductor/pagos/<personaid>')
def pagosconductor(personaid):
    CC=connection.cursor()
    CC.execute('select Pagos.id_viaje,Pagos.fecha,Pagos.id_tipo_pago,Rutas.nombre,Paradas.nombre,Pagos.monto from Pagos inner join Viajes on Viajes.id=Pagos.id_viaje inner join Paradas on Paradas.id=Viajes.id_parada inner join Viajes_globales on Viajes_globales.id=Viajes.id_viaje_global inner join Rutas on Rutas.id=Viajes_globales.id_ruta inner join Conductores on Conductores.id=Viajes_globales.id_conductor where Conductores.id_persona='+personaid)
    datospago=CC.fetchall()
    return render_template('pagos.html',datos=datospago,personaid=personaid)

#ejecucion del servidor y asignacion del puerto a trabajar
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)


