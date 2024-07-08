# Usar una imagen base de Python
FROM python:3.12-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Instalar las dependencias del sistema necesarias para psycopg2
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Copiar el archivo de requisitos
COPY requirements.txt .

# Instalar las dependencias de Python especificadas en requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del código de la aplicación
COPY . .

# Especificar el comando por defecto para ejecutar el script Python
CMD ["python", "jsonplaceholder.py"]
