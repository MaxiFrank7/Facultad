import pandas as pd
import numpy as np
import random
import os
from datetime import datetime, timedelta

# 1. Configuración de ruta (igual que antes)
directorio_actual = os.path.dirname(os.path.abspath(__file__))
ruta_csv = os.path.join(directorio_actual, 'ventas_dax.csv')

# 2. Generadores de Datos
def generate_dates(start_date, end_date, n):
    start = datetime.strptime(start_date, "%Y-%m-%d")
    end = datetime.strptime(end_date, "%Y-%m-%d")
    delta = end - start
    return [start + timedelta(days=random.randint(0, delta.days)) for _ in range(n)]

num_rows = 5000
productos = {
    'Laptop': {'price': 1200, 'cost': 800},
    'Mouse': {'price': 50, 'cost': 20},
    'Monitor': {'price': 300, 'cost': 200},
    'Headset': {'price': 100, 'cost': 60},
    'Keyboard': {'price': 80, 'cost': 40}
}
tiendas = ['Store_A', 'Store_B', 'Store_C']
paises = ['USA', 'Argentina', 'Spain']

# 3. Creación del DataFrame
data = []
for _ in range(num_rows):
    prod = random.choice(list(productos.keys()))
    row = {
        'Date': None, # Se llena luego
        'Product': prod,
        'Country': random.choice(paises),
        'Store': random.choice(tiendas),
        'Quantity': random.randint(1, 10),
        'Unit_Price': productos[prod]['price'], # Precio venta
        'Unit_Cost': productos[prod]['cost']    # Costo (para calcular ganancia)
    }
    data.append(row)

df = pd.DataFrame(data)
df['Date'] = generate_dates("2023-01-01", "2024-12-31", num_rows)
df = df.sort_values(by='Date')

# 4. Guardar
df.to_csv(ruta_csv, index=False)
print(f"✅ 'ventas_dax.csv' generado con {num_rows} filas en: {ruta_csv}")