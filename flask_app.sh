#!/bin/bash

temp_dir=$(mktemp -d)
cd $temp_dir
# Crear una estructura de carpetas para el proyecto
mkdir myflaskapp
cd myflaskapp

mkdir static
mkdir templates

# Copiar archivos al proyecto
proyecto_dir="$PWD"
echo "la ruta del proyecto es $proyecto_dir"

cp -r "$proyecto_dir/static" .
cp -r "$proyecto_dir/templates" .
cp "$proyecto_dir/flask_app.py" .

#cp ../flask_app.py .
#cp -r ../templates/* templates/.
#cp -r ../static/* static/.

# Crear el Dockerfile
echo "FROM python" > Dockerfile
echo "RUN pip install flask" >> Dockerfile
echo "WORKDIR /home/myapp" >> Dockerfile

echo "COPY ./static /home/myapp/static" >> Dockerfile
echo "COPY ./templates /home/myapp/templates" >> Dockerfile
echo "COPY flask_app.py /home/myapp/" >> Dockerfile

echo "EXPOSE 5050" >> Dockerfile
echo "CMD python3 /home/myapp/flask_app.py" >> Dockerfile

# Construir la imagen y ejecutar el contenedor
docker build -t flaskweb .
docker run -t -d -p 5050:5050 -v /home/santiago/web_flask:/home/myapp --name flask_contenedor flaskweb


docker ps -a

rm -rf $temp_dir
