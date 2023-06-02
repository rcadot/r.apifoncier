#' Consommation d'espace par commune
#'
#' @param code_insee Code INSEE de la commune
#' @param annee_max Année jusqu'à laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param annee_min Année à partir de laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs de consommation d'espace pour la période comprise entre annee_min et annee_max, bornes incluses, à l'échelle communale
#' @export
#'
#' @examples
#' ind_conso_espace_communes(59001)
ind_conso_espace_communes <- function(
    code_insee,
    annee_max=NULL,
    annee_min=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL
) {

  args <- list(
    coddep=code_insee,
    annee_max=annee_max,
    annee_min=annee_min,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='conso_espace'
  indicateur_2='communes'

  code_insee <- stringr::str_pad(code_insee,width = 5,pad = "0",side = "left")

  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,code_insee,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  jsonlite::fromJSON(rawToChar(res$content))$results

}
