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
    return render_template('pagos.html')



#ejecucion del servidor y asignacion del puerto a trabajar
if __name__ == '__main__':
        app.run(port=5000 ,debug= True)

