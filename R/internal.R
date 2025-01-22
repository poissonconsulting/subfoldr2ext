file_name <- function(main, class, sub, x_name, ext) {
  dir <- file_path(main, class, sub)
  dir_create(dir)
  file <- file_path(dir, x_name)
  ext <- sub("[.]$", "", ext)
  if (!identical(ext, tools::file_ext(x_name))) {
    file <- paste0(file, ".", ext)
  }
  
  file
}

file_path <- function(..., collapse = FALSE) {
  args <- list(...)
  if (!length(args)) {
    return(character(0))
  }
  args <- lapply(args, as.character)
  args <- args[vapply(args, function(x) length(x) > 0L, TRUE)]
  if (collapse) {
    args <- lapply(args, chk::p0, collapse = "/")
  }
  do.call("file.path", args)
}

dir_create <- function(dir) {
  if (!dir.exists(dir)) {
    dir.create(dir, recursive = TRUE)
  }
  dir
}
