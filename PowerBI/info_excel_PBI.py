import pandas as pd
import numpy as np
import os

# 1. Configuración
directorio_actual = os.path.dirname(os.path.abspath(__file__))
ruta_csv = os.path.join(directorio_actual, 'presupuesto.csv')

# 2. Generar Fechas (Solo el día 1 de cada mes)
fechas = pd.date_range(start='2023-01-01', end='2024-12-01', freq='MS') # MS = Month Start
paises = ['USA', 'Argentina', 'Spain']

data = []
for fecha in fechas:
    for pais in paises:
        # Lógica de presupuesto: Base + variación aleatoria
        base = 150000 if pais == 'USA' else (120000 if pais == 'Spain' else 100000)
        variacion = np.random.randint(-10000, 20000)
        
        row = {
            'Fecha_Presupuesto': fecha,
            'Country': pais,
            'Budget_Amount': base + variacion
        }
        data.append(row)

df = pd.DataFrame(data)
df.to_csv(ruta_csv, index=False)
print(f"✅ 'presupuesto.csv' generado. Granularidad: Mensual por País.")