x = [3,4,6,4,2,5]
y = [6,8,9,5,4.5,9.5]

#x= [5,3,7,2,8]
#y= [11,6,10,6,12]

#x = [2,3,4,5,6,7,8,9,10,11]
#y = [60,65,70,75,80,85,90,95,100,105]

#f0
def media(x):
    return sum(x) / len(x)

#f1
def diferencia_cuadrado(x):
    la_media = media(x)
    la_diferencia = 0
    for i in x:
        la_diferencia = la_diferencia + (i - la_media) * (i - la_media)
    return la_diferencia

#f2
def diferencia_xy(x, y):
    mediax = media(x)
    mediay = media(y)
    lista_xy = [(a - mediax) * (b - mediay) for a, b in zip(x, y)]
    sumatoria = sum(lista_xy)
    return sumatoria
    
def obtener_b1(x, y):
    diferencia = diferencia_xy(x, y)
    diferencia_cuadrados = diferencia_cuadrado(x)
    return diferencia / diferencia_cuadrados

def obtener_b0(x, y):
    mediay = media(y)
    mediax = media(x)
    b1 = obtener_b1(x, y)
    return mediay - (b1 * mediax)


# --- Datos de prueba ---
x = [3, 4, 6, 4, 2, 5]
y = [6, 8, 9, 5, 4.5, 9.5]


# --- Cálculo de b1 y b0 manteniendo tus variables ---
spc = diferencia_xy(x, y)
scx = diferencia_cuadrado(x)
my = media(y)
mx = media(x)

b1 = spc / scx
b0 = my - (b1 * mx)

print(f"Pendiente (b1): {b1}")
print(f"Intersección (b0): {b0}")
print(f"Ecuación: Ŷ = {b0} + {b1}X")


# --- Nueva función para predecir pidiendo el valor de x ---
def predecir_y():
    # Pedir el valor de x al usuario por consola
    x_ingresado = float(input("\nIngresa el valor de x para predecir y: "))
    
    # Calcular y = b0 + b1*x
    y_resultado = b0 + (b1 * x_ingresado)
    
    print(f"Para X = {x_ingresado}, el valor predicho de Y es: {y_resultado}")

# Ejecutar la función de predicción
predecir_y()
