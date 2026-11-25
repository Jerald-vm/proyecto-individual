# ==============================================================================
# render.R - Genera el reporte en PDF del proyecto individual
# Uso (desde cualquier carpeta dentro del repositorio):
#   Rscript cod/render.R
# Resultado: res/Individual_Valverde_HerramientasDatosI_2026.pdf
# Requisitos: R, Quarto, una distribución de LaTeX y el paquete here.
# Archivo creado con la ayuda de claude.
# ==============================================================================

library(here)  # rutas relativas a la raíz del proyecto (archivo .here)

# Nombre del documento (sin extensión)
nombre <- "Individual_Valverde_HerramientasDatosI_2026"

qmd <- here("cod", paste0(nombre, ".qmd"))
pdf.generado <- here("cod", paste0(nombre, ".pdf"))
carpeta.res <- here("res")

# Control: el documento y Quarto deben existir
if (!file.exists(qmd)) {
  stop("No se encontró el documento: ", qmd, call. = FALSE)
}
if (Sys.which("quarto") == "") {
  stop("Quarto no está instalado o no está en el PATH.", call. = FALSE)
}

# Se renderiza a PDF; Quarto deja el archivo junto al .qmd (carpeta cod/)
estado <- system2("quarto", c("render", shQuote(qmd), "--to", "pdf"))
if (estado != 0 || !file.exists(pdf.generado)) {
  stop("El render falló; revise los mensajes de Quarto.", call. = FALSE)
}

# Se mueve el PDF a res/
dir.create(carpeta.res, showWarnings = FALSE)
file.copy(pdf.generado, file.path(carpeta.res, basename(pdf.generado)), overwrite = TRUE)
file.remove(pdf.generado)

message("Listo: ", file.path(carpeta.res, basename(pdf.generado)))