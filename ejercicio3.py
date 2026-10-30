import pandas as pd

# Datos
x = [20, 25, 30, 35, 40]
y = [50, 58, 65, 75, 82]

df = pd.DataFrame({'x': x, 'y': y})

# Cálculo de parámetros
mx, my = df['x'].mean(), df['y'].mean()
spc = ((df['x'] - mx) * (df['y'] - my)).sum()
scx = ((df['x'] - mx) ** 2).sum()

b1 = spc / scx
b0 = my - (b1 * mx)

print("\n=== RESPUESTAS EJERCICIO 3 ===")
print(f"1. Ecuación de regresión: Ŷ = {b0:.2f} + {b1:.2f}X")

temp = 32
prediccion = b0 + (b1 * temp)
print(f"2. Para una temperatura de {temp}°C, el consumo estimado es: {prediccion:.2f} MWh\n")
