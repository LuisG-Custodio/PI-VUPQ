#paquteria de flas
from flask import Flask,render_template,request, redirect,url_for,flash
from flask_mysqldb import MySQL

#la inicializacion del app 
app=Flask(__name__)

app.config['MYSQL_HOST']='localhost'
app.config['MYSQL_USER']='root'
app.config['MYSQL_PASSWORD']=''
app.config['MYSQL_DB']='Vunity'
app.secret_key='mysecretkey'
MySQL=MySQL(app)
#declaracion o inicializacion de las rutas y le pertenece a http://localhost:5000
@app.route('/')
def inicio():
    return render_template('inicio.html')

@app.route('/index')
def index():
    return render_template('index.html')

@app.route('/autos')
def autos():
    return render_template('Autos.html')

@app.route('/personas')
def personas():
    return render_template('personas.html')

@app.route('/viajes')
def viajes():
    return render_template('Viajes.html')
    

#ejecucion del servidor y asignacion del puerto a trabajar
if __name__ == '__main__':
        app.run(port=5000 ,debug= True)

