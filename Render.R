# render.R
# Renderiza el informe en PDF y lo deja en la carpeta res/.
#
# Uso (funciona desde cualquier carpeta):
#   Rscript ruta/al/proyecto/render.R
#
# Requisitos: Quarto y una distribucion de LaTeX (por ejemplo TinyTeX:
# quarto install tinytex).

# Nombre del informe, relativo a la raiz del proyecto
qmd <- file.path("cod", "CodigoR.qmd")
salida <- "res"

# La raiz del proyecto es la carpeta donde esta este script, sin importar
# desde donde se ejecute
argumentos <- commandArgs(trailingOnly = FALSE)
este_script <- sub("^--file=", "", grep("^--file=", argumentos, value = TRUE))
if (length(este_script) > 0) {
  setwd(dirname(normalizePath(este_script)))
}

if (Sys.which("quarto") == "") {
  stop("No se encontro Quarto. Instalelo desde https://quarto.org")
}

if (!file.exists(qmd)) {
  encontrados <- list.files(pattern = "\\.qmd$", recursive = TRUE)
  stop("No encuentro ", qmd, " en ", getwd(), ".\n",
       "Archivos .qmd encontrados: ",
       if (length(encontrados) > 0) paste(encontrados, collapse = ", ") else "ninguno",
       "\nCorrija la variable 'qmd' al inicio de este script.")
}

# Renderiza. El PDF queda junto al .qmd
estado <- system2("quarto", c("render", shQuote(qmd), "--to", "pdf"))
if (estado != 0) {
  stop("Fallo el render del qmd. Revise los mensajes de arriba.")
}

# Mueve el PDF a res/
pdf <- sub("\\.qmd$", ".pdf", qmd)
if (!file.exists(pdf)) {
  stop("El render termino, pero no se genero ", pdf)
}

dir.create(salida, showWarnings = FALSE)
if (file.copy(pdf, salida, overwrite = TRUE)) {
  file.remove(pdf)
  message("Listo: ", file.path(getwd(), salida, basename(pdf)))
} else {
  stop("No se pudo copiar el PDF a ", salida, ". Cierre el PDF si lo tiene abierto.")
}