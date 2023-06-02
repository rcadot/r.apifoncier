#' Indicateurs annuels DV3F à l'échelle de la commune
#'
#' @param code_insee Code INSEE de la commune
#' @param annee Année de mutation
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs annuels DV3F à l'échelle communale
#' @export
#'
#' @examples ind_dv3f_com_annuel('59350')
ind_dv3f_com_annuel <- function(
    code_insee,
    annee=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL
) {

  args <- list(
    code_insee =code_insee ,
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='communes'
  indicateur_3='annuel'

  code_insee  <- stringr::str_pad(code_insee ,width = 5,pad = "0",side = "left")

  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,code_insee,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  jsonlite::fromJSON(rawToChar(res$content))$results

}
