# PRACTICA: REGRESION LINEAL MULTIPLE
# Caso Jenny Wilson Realty
# No requiere instalar paquetes adicionales.

# 1. CREAR LOS DATOS DE LAS 14 CASAS

precio <- c(
  95000, 119000, 124800, 135000, 142800, 145000, 159000,
  165000, 182000, 183000, 200000, 211000, 215000, 219000
)

pies_cuadrados <- c(
  1926, 2069, 1720, 1396, 1706, 1847, 1950,
  2323, 2285, 3752, 2300, 2525, 3800, 1740
)

antiguedad <- c(
  30, 40, 30, 15, 32, 38, 27,
  30, 26, 35, 18, 17, 40, 12
)

condicion <- c(
  "Buena", "Excelente", "Excelente", "Buena",
  "Nueva", "Nueva", "Nueva", "Excelente",
  "Nueva", "Buena", "Buena", "Buena",
  "Excelente", "Nueva"
)

# 2. CREAR EL MARCO DE DATOS

datos_casas <- data.frame(
  precio,
  pies_cuadrados,
  antiguedad,
  condicion,
  stringsAsFactors = FALSE
)

cat("\nDATOS DE LAS CASAS\n")
print(datos_casas)

# 3. AJUSTAR EL MODELO DE REGRESION MULTIPLE
# Variable dependiente: precio.
# Variables independientes: pies cuadrados y antiguedad.
# La condicion se guarda para uso posterior; no entra en el modelo.

modelo_multi <- lm(
  precio ~ pies_cuadrados + antiguedad,
  data = datos_casas
)

cat("\nMODELO DE REGRESION MULTIPLE\n")
print(modelo_multi)

# 4. MOSTRAR LOS COEFICIENTES Y LA ECUACION

cat("\nCOEFICIENTES DEL MODELO\n")
print(round(coef(modelo_multi), 4))

b <- coef(modelo_multi)

cat(sprintf(
  paste0(
    "\nPrecio estimado = %.5f",
    " + %.5f * pies_cuadrados",
    " - %.5f * antiguedad\n"
  ),
  b[1], b[2], abs(b[3])
))

# Ecuacion aproximada:
# Precio = 146630.89356 + 43.81937 * pies_cuadrados - 2898.68625 * antiguedad

# 5. OBTENER EL RESUMEN ESTADISTICO

cat("\nRESUMEN ESTADISTICO\n")

resumen <- summary(modelo_multi)
print(resumen)

cat(sprintf(
  "\nR cuadrado: %.4f\n",
  resumen$r.squared
))

cat(sprintf(
  "R cuadrado ajustado: %.4f\n",
  resumen$adj.r.squared
))

cat(sprintf(
  "Variacion de precios explicada en la muestra: %.2f%%\n",
  100 * resumen$r.squared
))

# 6. REALIZAR LA PRUEBA F GLOBAL
# H0: los coeficientes de pies cuadrados y antiguedad son cero.
# H1: al menos uno de esos coeficientes es distinto de cero.
# Nivel de significancia: 0.05.

cat("\nPRUEBA F GLOBAL\n")

modelo_nulo <- lm(
  precio ~ 1,
  data = datos_casas
)

print(anova(modelo_nulo, modelo_multi))

estadistico_f <- resumen$fstatistic

valor_p <- pf(
  estadistico_f[1],
  estadistico_f[2],
  estadistico_f[3],
  lower.tail = FALSE
)

cat(sprintf(
  "\nEstadistico F: %.4f\n",
  estadistico_f[1]
))

cat(sprintf(
  "Valor p global: %.6f\n",
  valor_p
))

if (valor_p < 0.05) {
  cat("Se rechaza H0 al nivel de significancia de 0.05.\n")
  cat("El modelo es globalmente significativo.\n")
} else {
  cat("No se rechaza H0 al nivel de significancia de 0.05.\n")
}

# 7. PRONOSTICAR EL PRECIO DE UNA CASA
# Casa de 2000 pies cuadrados y 10 anos de antiguedad.

nueva_casa <- data.frame(
  pies_cuadrados = 2000,
  antiguedad = 10
)

precio_estimado <- predict(
  modelo_multi,
  newdata = nueva_casa
)

cat("\nDATOS DE LA CASA A PRONOSTICAR\n")
print(nueva_casa)

cat(sprintf(
  "\nPrecio estimado: %.2f dolares\n",
  precio_estimado[1]
))

# 8. CONCLUSION

cat("\nCONCLUSION\n")
cat("El modelo ajustado con las 14 casas es globalmente significativo.\n")
cat("El precio estimado aumenta con la superficie y disminuye con\n")
cat("la antiguedad, manteniendo fija la otra variable.\n")
cat("El modelo explica aproximadamente el 67.19% de la variacion\n")
cat("observada en los precios de la muestra.\n")
cat("Para una casa de 2000 pies cuadrados y 10 anos, el precio\n")
cat("estimado es de 205282.76 dolares.\n")
