# le fichier s'appelle aaa.R car c'est la méthode conseillée officiellement :
# https://r-pkgs.org/data.html#sec-data-state
# Define it before you use it. If other top-level calls refer to the environment, the definition must come first when the package code is being executed at build time. This is why R/aaa.R is a common and safe choice.

the <- new.env(parent = emptyenv())

CONFIG_INIT <- list(
  BASE_URL = "https://apidf-preprod.cerema.fr",
  TOKEN = NULL,
  PROXY = NULL,
  PROGRESS_BAR = TRUE,
  MAX_ATTEMPTS = 3
)

the$CONFIG <- CONFIG_INIT


#' configure
#'
#' @param ... element a configurer TOKEN et PROXY
#'
#' @return configure les token et proxy pour les acces speciaux
#' @export
#'
#' @examples
#'configure(TOKEN="my_token")
configure <- function(...) {
  arg_names <- deparse(substitute(list(...)))
  cli::cli_alert_success(c("i"="La modification de {(arg_names)} a ete effectue"))
  try(
    the$CONFIG <<- utils::modifyList(the$CONFIG, list(...)),
    silent = T
  )
}


get_param <- function(value) {
  return(the$CONFIG[[value]])
}

#' reset
#'
#' @return renvoi le parametre souhaite
#' @export
#'
#' @examples
#' reset()
reset <- function() {
  cli::cli_alert_success(c("i"="La configuration intiale a ete restauree."))
  try(
    the$CONFIG <<- CONFIG_INIT,
    silent = T
  )
}


options(cli.progress_show_after = 0)
