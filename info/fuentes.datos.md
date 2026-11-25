# Fuentes de datos

## Producción y precio (ICAFE)

- **Documento:** Instituto del Café de Costa Rica. (2025). *Informe de la actividad cafetalera de Costa Rica 2025*.
- **Enlace:** https://www.icafe.cr/wp-content/uploads/informacion_mercado/informes_actividad/actual/Informe%20Actividad%20Cafetalera.pdf
- **Archivo en el repositorio:** `data/Informe Actividad Cafetalera.pdf`
- **Qué se usa:**
  - Página 88: producción por cosecha (fanegas, café oro en sacos de 46 kg, exportación y consumo nacional).
  - Página 89: liquidación final al productor (colones por fanega) y tipo de cambio.
- **Cobertura:** cosechas 1994-1995 a 2024-2025.
- **Tratamiento:** las tablas se leen con `pdftools` y se separan las columnas con expresiones regulares (sección 4 y 5 del código).

## Cosecha 2025-2026 (prensa)

- **Documento:** Brenes, L. (12 de agosto, 2025). *Cosecha 2025/26: Menos café, a mejor precio, pero menos rentabilidad por tipo de cambio y aranceles*. La República.
- **Enlace:** https://www.larepublica.net/noticia/cosecha-2025-26-menos-cafe-a-mejor-precio-pero-menos-rentabilidad-por-tipo-de-cambio-y-aranceles
- **Qué se usa:** producción de 1.17 millones de sacos de 60 kg y liquidación de ₡118 627 por fanega.
- **Advertencia:** son cifras de prensa y preliminares, no del informe oficial del ICAFE. El tipo de cambio de ₡470 por dólar es un supuesto propio.

## Clima (NASA POWER)

- **Documento:** National Aeronautics and Space Administration, Langley Research Center. (s. f.). *Monthly and annual API documentation*. NASA POWER.
- **Enlace:** https://power.larc.nasa.gov/docs/services/api/temporal/monthly/
- **Consulta:** 10 de noviembre de 2026.
- **Archivo en el repositorio:** `config/datosNasa.xlsx`
- **Parámetros:** `PRECTOTCORR` (precipitación, mm/día) y `T2M` (temperatura del aire a 2 m, °C).
- **Punto:** Pérez Zeledón, 9.37° N, 83.70° O. Es una aproximación regional, no un promedio nacional.
- **Periodo:** 1994 a 2026, datos mensuales. El código `-999` indica dato faltante.
- **Tratamiento:** promedio de abril a octubre de cada año (en 2026, con los meses disponibles).

## Indicador del ENOS (NOAA)

- **Documento:** National Oceanic and Atmospheric Administration, Climate Prediction Center. (s. f.). *Relative Oceanic Niño Index (RONI)*.
- **Enlace:** https://www.cpc.ncep.noaa.gov/products/analysis_monitoring/enso/roni/
- **Consulta:** 10 de noviembre de 2026.
- **Archivo en el repositorio:** `data/` (PDF de la tabla del RONI).
- **Tratamiento:** cada fila trae el año y 12 trimestres móviles (DJF a NDJ). Se promedian los trimestres AMJ, MJJ, JJA, JAS y ASO (posiciones 5 a 9), que cubren de abril a octubre.

## Referencias metodológicas

- Hyndman, R. J., y Athanasopoulos, G. (2021). *Forecasting: Principles and practice* (3.ª ed.). OTexts. https://otexts.com/fpp3/
- James, G., Witten, D., Hastie, T., y Tibshirani, R. (2021). *An Introduction to Statistical Learning: with Applications in R* (2.ª ed.). Springer.
- IBM. (16 de agosto, 2026). *¿Qué es la regresión Ridge?* https://www.ibm.com/mx-es/think/topics/ridge-regression
