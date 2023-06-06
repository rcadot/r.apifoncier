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

#' Indicateurs triennaux DV3F à l'échelle AAV
#'
#' @param code_aav Code AAV de l'aire INSEE
#' @param annee Année de mutation centrale de la période triennale (par exemple, 2011 pour la période 2010-2012)
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs triennaux DV3F à l'échelle AAV
#' @export
#'
#' @examples ind_dv3f_aav_triennal('004')
ind_dv3f_aav_triennal <- function(
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
  indicateur_3='triennal'

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

#' Indicateurs triennaux DV3F à l'échelle de la commune
#'
#' @param code_insee Code INSEE de la commune
#' @param annee Année de mutation centrale de la période triennale (par exemple, 2011 pour la période 2010-2012)
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs triennaux DV3F à l'échelle communale
#' @export
#'
#' @examples ind_dv3f_com_triennal('59350')
ind_dv3f_com_triennal <- function(
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
  indicateur_3='triennal'

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

#' Indicateurs annuels DV3F à l'échelle du département
#'
#' @param coddep Code INSEE du département
#' @param annee Année de mutation
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs annuels DV3F à l'échelle du département
#' @export
#'
#' @examples ind_dv3f_dep_annuel('59')
ind_dv3f_dep_annuel <- function(
    coddep,
    annee=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL
) {

  args <- list(
    coddep =coddep ,
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='departements'
  indicateur_3='annuel'

  coddep  <- stringr::str_pad(coddep ,width = 2,pad = "0",side = "left")

  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,coddep,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  jsonlite::fromJSON(rawToChar(res$content))$results

}

#' Indicateurs triennaux DV3F à l'échelle du département
#'
#' @param coddep Code INSEE du département
#' @param annee Année de mutation centrale de la période triennale (par exemple, 2011 pour la période 2010-2012)
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs triennaux DV3F à l'échelle du département
#' @export
#'
#' @examples ind_dv3f_dep_triennal('59')
ind_dv3f_dep_triennal <- function(
    coddep,
    annee=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL
) {

  args <- list(
    coddep =coddep ,
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='departements'
  indicateur_3='triennal'

  coddep  <- stringr::str_pad(coddep ,width = 2,pad = "0",side = "left")

  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,coddep,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  jsonlite::fromJSON(rawToChar(res$content))$results

}

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


#' Indicateurs triennaux DV3F à l'échelle de l'epci
#'
#' @param code_epci Code INSEE de l'EPCI
#' @param annee Année de mutation centrale de la période triennale (par exemple, 2011 pour la période 2010-2012)
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs triennaux DV3F à l'échelle de l'epci
#' @export
#'
#' @examples ind_dv3f_epci_triennal('200093201')
ind_dv3f_epci_triennal <- function(
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
  indicateur_3='triennal'

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


#' Indicateurs annuels DV3F à l'échelle de la région
#'
#' @param codreg Code INSEE de la région
#' @param annee Année de mutation
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs annuels DV3F à l'échelle du département
#' @export
#'
#' @examples ind_dv3f_reg_annuel('59')
ind_dv3f_reg_annuel <- function(
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
  indicateur_3='annuel'

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




