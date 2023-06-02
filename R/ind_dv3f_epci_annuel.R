#' Indicateurs annuels DV3F à l'échelle de l'epci
#'
#' @param code_epci Code INSEE de l'EPCI
#' @param annee Année de mutation
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs annuels DV3F à l'échelle de l'epci
#' @export
#'
#' @examples ind_dv3f_epci_annuel('200093201')
ind_dv3f_epci_annuel <- function(
    code_epci ,
    annee=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL
) {

  args <- list(
    code_epci  =code_epci  ,
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='epci'
  indicateur_3='annuel'

  code_epci   <- stringr::str_pad(code_epci ,width = 9,pad = "0",side = "left")

  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,code_epci ,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  jsonlite::fromJSON(rawToChar(res$content))$results

}
