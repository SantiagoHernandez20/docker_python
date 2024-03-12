#!/bin/bash

# Obtener la ruta del proyecto (directorio actual)
proyecto_dir="$PWD"

# Crear una carpeta temporal
temp_dir=$(mktemp -d)

# Copiar archivos y carpetas del proyecto al directorio temporal
cp -r "$proyecto_dir/static" "$temp_dir"
cp -r "$proyecto_dir/templates" "$temp_dir"
cp "$proyecto_dir/flask_app.py" "$temp_dir"

# Crear el Dockerfile
cat <<EOF > "$temp_dir/Dockerfile"
FROM python
RUN pip install flask
WORKDIR /home/myapp
COPY ./static /home/myapp/static
COPY ./templates /home/myapp/templates
COPY flask_app.py /home/myapp/
EXPOSE 5050
CMD python3 /home/myapp/flask_app.py
EOF

# Entrar al directorio temporal
cd "$temp_dir"

# Construir la imagen Docker
docker build -t flaskweb .

# Ejecutar el contenedor Docker
docker run -t -d -p 5050:5050 -v /home/santiago/web_flask:/home/myapp --name flask_contenedor flaskweb

# Mostrar información sobre el contenedor Docker
docker ps -a

# Limpiar la carpeta temporal
rm -rf "$temp_dir"
