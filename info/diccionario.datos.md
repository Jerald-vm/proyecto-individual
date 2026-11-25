# Diccionario de datos

Variables que usa el proyecto *Predicción de la cosecha de café en Costa Rica 2026-2027*. Los nombres corresponden a los objetos del código (`cod/Individual_Valverde_HerramientasDatosI_2026.qmd`).

## Tabla de modelado (`tabla.modelo`)

Una fila por cosecha completa (1995-1996 a 2025-2026, es decir, hasta el año de inicio 2025). Cada cosecha se asocia a su año de inicio (la cosecha 2023-2024 corresponde a 2023).

| Variable | Descripción | Unidad | Fuente | Cómo se obtiene |
|---|---|---|---|---|
| `cosecha` | Identificador de la cosecha (por ejemplo, `2023-2024`) | texto | ICAFE | Columna de cosecha de la tabla del informe |
| `año` | Año de inicio de la cosecha | año | ICAFE | Primeros cuatro dígitos de `cosecha` |
| `produccion.sacos.60kg` | **Variable respuesta.** Producción nacional de café | sacos de 60 kg | ICAFE (2025-2026: prensa) | Café oro en sacos de 46 kg × 46/60 |
| `lluvia.promedio.mm.dia` | Precipitación media de abril a octubre | mm/día | NASA POWER (`PRECTOTCORR`) | Promedio de los meses abril a octubre del año de inicio |
| `temperatura.promedio.c` | Temperatura media del aire a 2 m, de abril a octubre | °C | NASA POWER (`T2M`) | Promedio de los meses abril a octubre del año de inicio |
| `roni` | Índice Oceánico Relativo (indicador del ENOS), de abril a octubre | índice | NOAA / CPC | Promedio de los trimestres móviles AMJ, MJJ, JJA, JAS y ASO |
| `produccion.anterior` | Producción de la cosecha anterior | sacos de 60 kg | ICAFE | Rezago de un año de `produccion.sacos.60kg` |
| `precio.anterior` | Precio de la cosecha anterior | USD por fanega | ICAFE | Rezago de un año de `precio.usd.fanega` |

La primera cosecha (1994-1995) se pierde porque no tiene valores anteriores. Por eso la tabla tiene una fila menos que la serie original.

## Otras variables derivadas

| Variable | Descripción | Unidad | Cómo se obtiene |
|---|---|---|---|
| `precio.usd.fanega` | Liquidación final al productor en dólares | USD por fanega | `liquidacion.crc.fanega / tipo.cambio.crc.usd` |
| `liquidacion.crc.fanega` | Liquidación final al productor | colones por fanega | Tabla de precios del ICAFE (columna 4) |
| `tipo.cambio.crc.usd` | Tipo de cambio de la cosecha | colones por dólar | Tabla de precios del ICAFE (columna 5) |
| `cafe.oro.sacos.46kg` | Café oro producido | sacos de 46 kg | Tabla de producción del ICAFE (columna 4) |

## Variables extraídas pero descartadas como predictores

Se extraen del informe, pero no se usan en los modelos porque se calculan a partir de la misma cosecha que se quiere estimar:

`produccion.fanegas`, `rendimiento.kg.fanega`, `exportacion.sacos.46kg`, `porcentaje.exportacion`, `consumo.nacional.sacos.46kg`, `porcentaje.consumo`.

## Cosecha 2026-2027 (`fila.proyeccion`)

La respuesta queda vacía. Los predictores son:

- **Lluvia, temperatura y RONI de 2026:** con los meses disponibles. En 2026 octubre aún no tiene datos, por lo que se promedia hasta septiembre.
- **`produccion.anterior` y `precio.anterior`:** producción y precio de la cosecha 2025-2026.

## Valores faltantes y supuestos

- **Datos faltantes de NASA POWER:** el código `-999` se convierte en `NA`.
- **Cosecha 2025-2026:** no está en el informe del ICAFE. La producción (1.17 millones de sacos de 60 kg) y la liquidación (₡118 627 por fanega) vienen de prensa y son cifras preliminares.
- **Tipo de cambio de 2025-2026:** se asumió ₡470 por dólar. Es un supuesto propio, no un dato del ICAFE.
