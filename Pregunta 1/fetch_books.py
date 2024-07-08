import requests
import csv

# Hacer una solicitud a la API
response = requests.get('https://api.example.com/books')
books = response.json()

# Calcular el número total de libros en la lista
total_books = len(books)
print(f'Número total de libros: {total_books}')

# Guardar los datos en un archivo CSV llamado books.csv
csv_file = 'books.csv'
csv_columns = books[0].keys()

try:
    with open(csv_file, 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=csv_columns)
        writer.writeheader()
        for book in books:
            writer.writerow(book)
    print(f'Datos guardados en {csv_file}')
except IOError:
    print("Error al escribir en el archivo CSV")
