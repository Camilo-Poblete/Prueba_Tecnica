# Usa la imagen base de Python
FROM python:3.12

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /usr/src/app

# Copia el archivo de requerimientos e instala las dependencias
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto de la aplicación al directorio de trabajo
COPY . .

# Comando por defecto para ejecutar la aplicación cuando el contenedor se inicia
CMD ["python", "jsonplaceholder.py"]
