#' Indicateurs annuels DV3F à l'échelle AAV
#'
#' @param code_aav Code AAV de l'aire INSEE
#' @param annee Année de mutation
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs annuels DV3F à l'échelle AAV
#' @export
#'
#' @examples ind_dv3f_aav_annuel('004')
ind_dv3f_aav_annuel <- function(
    code_aav ,
    annee=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL
) {

  args <- list(
    code_aav=code_aav,
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='aav'
  indicateur_3='annuel'

  code_aav <- stringr::str_pad(code_aav,width = 3,pad = "0",side = "left")

  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,code_aav,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  jsonlite::fromJSON(rawToChar(res$content))$results

}
