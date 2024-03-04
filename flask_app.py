import os
from flask import Flask, render_template

app = Flask(__name__)

# Configurar el entorno de Flask en desarrollo
app.config['DEBUG'] = True
os.environ['FLASK_ENV'] = 'development'

@app.route('/')
def index():
    return render_template('index.html')

# Resto de tu código Flask

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5050)
