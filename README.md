
Curso: CA-0204 Herramientas de Ciencia de Datos I — II Ciclo 2026 Profesor: Luis Alberto Juárez Potoy

1. Introducción y justificación

El café es uno de los productos agrícolas de mayor tradición e impacto económico en Costa Rica, pero su producción anual está sujeta a una fuerte variabilidad debido a factores climáticos, biológicos (bienalidad de la planta) y de mercado. La cosecha 2025-2026 registró de hecho un mínimo histórico no visto desde el periodo 1970-1971, atribuido a estrés hídrico .

Este proyecto busca construir un modelo cuantitativo, mediante regresión lineal en R, que estime el volumen de la cosecha nacional de café para el periodo 2026-2027, replicando a menor escala el tipo de ejercicio de proyección que realizan agencias internacionales como StoneX, Volcafe o el USDA para el mercado cafetalero mundial .

El tema fue seleccionado por interés personal del estudiante, originario de la región de Pérez Zeledón, una de las principales zonas cafetaleras del país.

2. Objetivos

2.1 Objetivo general

Desarrollar un modelo de regresión lineal en R que permita estimar el volumen de la cosecha nacional de café de Costa Rica para el periodo 2026-2027, a partir de variables climáticas, de mercado y del comportamiento histórico de la producción.

2.2 Objetivos específicos

Recopilar y depurar las series históricas de producción y precio de café publicadas por el ICAFE para el periodo 1994-1995 a 2024-2025.

Obtener datos climáticos históricos para la región de Pérez Zeledón mediante la API pública de NASA POWER.

Incorporar el Índice Oceánico El Niño (ONI) como variable explicativa de la variabilidad climática interanual.

Ajustar un modelo de regresión lineal múltiple y validarlo mediante comparación con cosechas históricas conocidas (backtesting).

Generar una estimación para la cosecha 2026-2027 y comunicar los resultados junto con sus limitaciones metodológicas.

3. Variable respuesta

Producción nacional de café, expresada en sacos de 60 kg (estándar internacional de referencia ). El ICAFE reporta sus cifras oficiales en sacos de 46 kg , por lo que se aplicará la conversión: 1 saco de 60 kg = 60/46 sacos de 46 kg.

4. Variables predictoras

Variable

Descripción

Fuente

Precio

Precio de liquidación al productor y/o precio de exportación por cosecha

ICAFE, Informe sobre la Actividad Cafetalera, anexo 2-3 

Clima

Precipitación y temperatura para la ventana abril–octubre (periodo de antesis floral y desarrollo del fruto)

NASA POWER, punto representativo en Pérez Zeledón 

Bienalidad

Producción del año cosecha anterior (variable rezagada)

Construida a partir de la serie histórica del ICAFE 

ENSO

Índice Oceánico El Niño (ONI), fase El Niño / La Niña / Neutral

NOAA, Climate Prediction Center 

La ventana climática abril-octubre se fundamenta en los propios informes del ICAFE, que identifican abril como el mes de antesis floral y el periodo abril-agosto como crítico para el desarrollo y llenado del fruto .

5. Justificación de las fuentes de datos

5.1 ICAFE

El Instituto del Café de Costa Rica (ICAFE) es la entidad reguladora oficial del sector cafetalero nacional, según la Ley N.º 2762 de 1961. Publica anualmente el "Informe sobre la Actividad Cafetalera de Costa Rica", cuyos anexos estadísticos incluyen series históricas de producción, comercialización y precios desde la cosecha 1994-1995 .

5.2 NASA POWER (en lugar del IMN)

Se evaluó al Instituto Meteorológico Nacional (IMN) como fuente climática, pero se descartó como fuente primaria: sus datos abiertos se limitan a un Atlas Climatológico estático (periodo 1961-1980) y a avisos meteorológicos de corto plazo; la obtención de series históricas específicas por estación requiere solicitud formal de servicios, lo cual representa un riesgo de tiempo para el cronograma del curso .

En su lugar se utilizará NASA POWER, una API pública que provee datos climáticos derivados de modelos de reanálisis satelital con cobertura global desde 1981, de acceso inmediato y sin necesidad de trámite .

5.3 Punto geográfico climático: Pérez Zeledón

Se seleccionó un único punto representativo en la región de Pérez Zeledón (aproximadamente 9.37° N, 83.70° O) por conocimiento directo del estudiante sobre el territorio. Se reconoce que esta región concentra aproximadamente el 13% de la producción cafetalera nacional , por lo que el clima medido constituye un proxy regional y no un promedio climático nacional; esta simplificación se declara explícitamente como límite del alcance del proyecto.

5.4 NOAA — Índice Oceánico El Niño (ONI)

El ONI es el indicador de referencia histórico utilizado por la NOAA para el seguimiento del fenómeno El Niño / Oscilación del Sur (ENSO), con serie mensual pública desde 1950 . Se utilizará esta serie para el periodo 1994-2024 requerido. Cabe señalar que, a partir de febrero de 2026, la NOAA adoptó el Índice Oceánico Relativo (RONI) como métrica oficial de monitoreo, aunque la serie histórica del ONI permanece disponible públicamente .

6. Limitaciones conocidas

La estimación de la cosecha 2026-2027 no puede validarse contra un valor real dentro del curso, ya que dicha cosecha aún no ha concluido; el modelo se valida mediante backtesting sobre cosechas históricas.

Tamaño de muestra reducido (aproximadamente 30 observaciones anuales) frente a 4 variables predictoras, lo cual incrementa el riesgo de sobreajuste.

Posible colinealidad entre las variables de clima y ENSO, dado que el fenómeno ENOS es uno de los mecanismos que genera las anomalías climáticas medidas.

El área cultivada de café a nivel nacional no se actualiza anualmente (mediciones especiales del ICAFE en 2001, 2012, 2017-2018 y 2025 ), por lo que se excluye como variable del modelo y se utiliza únicamente como referencia narrativa en el reporte ejecutivo.

No se identificó una serie pública anual de mano de obra cafetalera a nivel nacional; por esta razón no se incluye como variable predictora.

El clima medido en Pérez Zeledón es un proxy regional, no un promedio climático nacional.

7. Metodología y herramientas

Lenguaje y flujo de trabajo: R con Quarto (.qmd → .html).

Extracción de tablas en formato PDF: paquete pdftools.

Obtención de datos climáticos: consultas a la API REST de NASA POWER.

Modelo estadístico: regresión lineal múltiple (función lm() de R).

Validación: comparación de las predicciones del modelo contra cosechas históricas conocidas (backtesting).

Referencias

