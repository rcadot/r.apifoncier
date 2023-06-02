#' Consommation d'espace par département
#'
#' @param coddep Code INSEE du département
#' @param annee_max Année jusqu'à laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param annee_min Année à partir de laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs de consommation d'espace pour la période comprise entre annee_min et annee_max, bornes incluses, à l'échelle départementale
#' @export
#'
#' @examples
#' ind_conso_espace_dep(01)
ind_conso_espace_dep <- function(
    coddep,
    annee_max=NULL,
    annee_min=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL
) {

  # if (!is.numeric(code_insee)) {stop("x should be numeric")}

  args <- list(
    coddep=coddep,
    annee_max=annee_max,
    annee_min=annee_min,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='conso_espace'
  indicateur_2='departements'

  coddep <- stringr::str_pad(coddep,width = 2,pad = "0",side = "left")

  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,coddep,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  jsonlite::fromJSON(rawToChar(res$content))$results

}
