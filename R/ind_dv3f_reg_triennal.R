#' Indicateurs triennaux DV3F à l'échelle de la région
#'
#' @param codreg Code INSEE de la région
#' @param annee Année de mutation centrale de la période triennale (par exemple, 2011 pour la période 2010-2012)
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs triennaux DV3F à l'échelle de la région
#' @export
#'
#' @examples ind_dv3f_reg_triennal('32')
ind_dv3f_reg_triennal <- function(
    codreg,
    annee=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL
) {

  args <- list(
    codreg =codreg ,
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='regions'
  indicateur_3='triennal'

  codreg  <- stringr::str_pad(codreg ,width = 2,pad = "0",side = "left")

  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,codreg,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  jsonlite::fromJSON(rawToChar(res$content))$results

}
