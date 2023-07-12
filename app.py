#paquteria de flas
from flask import Flask,render_template,request, redirect,url_for,flash
from flask_mysqldb import MySQL

#la inicializacion del app 
app=Flask(__name__)

app.config['MYSQL_HOST']='localhost'
app.config['MYSQL_USER']='root'
app.config['MYSQL_PASSWORD']=''
app.config['MYSQL_DB']='vunity'
app.secret_key='mysecretkey'
mysql=MySQL(app)


@app.route('/')
def inicio():
    return render_template('inicio.html')

@app.route('/login', methods=['POST'])
def guardar():
    if request.method == 'POST':
        CC= mysql.connection.cursor()
        CC.execute()
        mysql.connection.commit()           
    flash()
    return redirect(url_for('index'))

@app.route('/index')
def index():
    return render_template('index.html')

@app.route('/autos')
def autos():
    return render_template('Autos.html')

@app.route('/guardarautos', methods=['POST'])
def guardarautos():
    if request.method == 'POST':
        Vmatricula=request.form['txtMatricula']
        Vmarca=request.form['txtMarca']
        Vcolor=request.form['txtColor']
        Vpoliza=request.form['txtPoliza']
        Vcapacidad=request.form['txtCapacidad']
        Vtipo=request.form['txtTipo']
        CS= mysql.connection.cursor()
        CS.execute('insert into tb_autos(matricula,marca,color,poliza,capacidad,tipo,fecha_ingreso,estatus) values(%s,%s,%s,%s,%s,%s,now(),1)',(Vmatricula,Vmarca,Vcolor,Vpoliza,Vcapacidad,Vtipo))
        mysql.connection.commit()           
    flash('Los datos del auto fueron agregados correctamente')
    return redirect(url_for('index'))

@app.route('/personas')
def personas():
    return render_template('personas.html')

@app.route('/guardarpersonas', methods=['POST'])
def guardarpersonas():
    if request.method == 'POST':
        Vuser=request.form['txtUser']
        Vpassword=request.form['txtPassword']
        Vnombre=request.form['txtNombre']
        Vap=request.form['txtAP']
        Vam=request.form['txtAM']
        Vmatricula=request.form['txtMatricula']
        Vtelefono=request.form['txtTelefono']
        Vrol=request.form['txtRol']
        CS= mysql.connection.cursor()
        CS.execute('insert into tb_personas(nombre,ap,am,matricula,telefono,rol) values(%s,%s,%s,%s,%s,%s)',(Vnombre,Vap,Vam,Vmatricula,Vtelefono,Vrol))
        CS.execute('insert into users(user,password) values(%s,%s)',(Vuser,Vpassword))
        mysql.connection.commit()           
    flash('El registro se realizó con éxito')
    return redirect(url_for('inicio'))

@app.route('/viajes')
def viajes():
    return render_template('Viajes.html')

@app.route('/crearviaje', methods=['POST'])
def crearviaje():
    if request.method == 'POST':
        Vruta=request.form['txtRuta']
        Vparada=request.form['txtParada']
        CS= mysql.connection.cursor()
        CS.execute('insert into tb_viajes(ruta,parada) values(%s,%s)',(Vruta,Vparada))
        mysql.connection.commit()           
    flash('El viaje fue reservado')
    return redirect(url_for('index'))
    

#ejecucion del servidor y asignacion del puerto a trabajar
if __name__ == '__main__':
        app.run(port=5000 ,debug= True)

