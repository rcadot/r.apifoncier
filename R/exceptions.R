ApiDFError <- function(status_code, detail) {
  # obj <- list(
  #   status_code = status_code,
  #   message = paste("Erreur", status_code, ":", detail)
  # )
  # class(obj) <- "ApiDFError"
  obj <- cli::cli_bullets(
    # list(
    # message =
    c("x"= "{(status_code)} : {(detail)}"),
    id=""
  )
  return(obj)
}

TokenNotConfigured <- function() {
  obj <- cli::cli_bullets(
    # list(
    # message =
   c("x"= "Le token n'a pas été configuré. Utiliser configure(TOKEN=\"jeton\")"),
  id=""
   )
  # class(obj) <- "TokenNotConfigured"
  return(obj)
}
