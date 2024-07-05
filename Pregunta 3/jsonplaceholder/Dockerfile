# Dockerfile
FROM python:3.12

WORKDIR /jsonplaceholder

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "jsonplaceholder.py"]
