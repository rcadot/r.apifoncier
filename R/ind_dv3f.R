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

  return_data <- NULL                # MAJ LISTE INSEE

  for (code_aav_i in code_aav) { # MAJ LISTE INSEE


    print(code_aav_i)              # MAJ LISTE INSEE

  args <- list(
    code_aav=code_aav_i,
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='aav'
  indicateur_3='annuel'
  # MAJ LISTE INSEE
  code_aav_i <- stringr::str_pad(code_aav_i,width = 3,pad = "0",side = "left")
  # MAJ LISTE INSEE
  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,code_aav_i,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  res <- jsonlite::fromJSON(rawToChar(res$content))$results

  return_data <- dplyr::bind_rows(res,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data                                              # MAJ LISTE INSEE

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
  return_data <- NULL                # MAJ LISTE INSEE

  for (code_aav_i in code_aav) { # MAJ LISTE INSEE


    print(code_aav_i)              # MAJ LISTE INSEE

    args <- list(
      code_aav=code_aav_i,
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='aav'
  indicateur_3='triennal'
  # MAJ LISTE INSEE
  code_aav_i <- stringr::str_pad(code_aav_i,width = 3,pad = "0",side = "left")
  # MAJ LISTE INSEE
  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,code_aav_i,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  res <- jsonlite::fromJSON(rawToChar(res$content))$results

  return_data <- dplyr::bind_rows(res,return_data)  # MAJ LISTE INSEE

}                                                        # MAJ LISTE INSEE

return_data                                             # MAJ LISTE INSEE

}

#' Indicateurs annuels DV3F à l'échelle de la commune
#'
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param annee Année de mutation
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs annuels DV3F à l'échelle communale
#' @export
#'
#' @examples ind_dv3f_com_annuel('59002')
ind_dv3f_com_annuel <- function(
    code_insee,
    annee=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL
) {

  return_data <- NULL                # MAJ LISTE INSEE

  for (code_insee_i in code_insee) { # MAJ LISTE INSEE


    print(code_insee_i)              # MAJ LISTE INSEE

    args <- list(
      code_insee=code_insee_i,   # MAJ LISTE INSEE
      annee=annee,
      ordering=ordering,
      page=page,
      page_size=page_size)

    base_url='https://apidf-preprod.cerema.fr'
    donnees='indicateurs'
    indicateur_1='dv3f'
    indicateur_2='communes'
    indicateur_3='annuel'
    # MAJ LISTE INSEE
    code_insee_i  <- stringr::str_pad(code_insee_i ,width = 5,pad = "0",side = "left")
    # MAJ LISTE INSEE
    url=glue::glue(
      base_url,donnees,indicateur_1,indicateur_2,indicateur_3,code_insee_i,'/',
      .sep = "/"
    )

    # Chek for internet
    # check_internet()

    res <- httr::GET(url, query = purrr::compact(args))

    # Check the result
    # check_status(res)

    res <- jsonlite::fromJSON(rawToChar(res$content))$results

    return_data <- dplyr::bind_rows(res,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data                                              # MAJ LISTE INSEE

}

#' Indicateurs triennaux DV3F à l'échelle de la commune
#'
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param annee Année de mutation centrale de la période triennale (par exemple, 2011 pour la période 2010-2012)
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#'
#' @return Renvoie les indicateurs triennaux DV3F à l'échelle communale
#' @export
#'
#' @examples ind_dv3f_com_triennal('59002')
ind_dv3f_com_triennal <- function(
    code_insee,
    annee=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL
) {

  return_data <- NULL                # MAJ LISTE INSEE

  for (code_insee_i in code_insee) { # MAJ LISTE INSEE


    print(code_insee_i)              # MAJ LISTE INSEE

  args <- list(
    code_insee=code_insee_i,   # MAJ LISTE INSEE
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='communes'
  indicateur_3='triennal'
  # MAJ LISTE INSEE
  code_insee_i  <- stringr::str_pad(code_insee_i ,width = 5,pad = "0",side = "left")
  # MAJ LISTE INSEE
  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,code_insee_i,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  res <- jsonlite::fromJSON(rawToChar(res$content))$results

  return_data <- dplyr::bind_rows(res,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data

}

#' Indicateurs annuels DV3F à l'échelle du département
#'
#' @param coddep Code INSEE du département (possibilité de passer un vecteur de code insee sans limite maximum)
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

  return_data <- NULL                # MAJ LISTE INSEE

  for (coddep_i in coddep) { # MAJ LISTE INSEE


    print(coddep_i)              # MAJ LISTE INSEE

  args <- list(
    coddep =coddep_i ,# MAJ LISTE INSEE
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='departements'
  indicateur_3='annuel'
  # MAJ LISTE INSEE
  coddep_i  <- stringr::str_pad(coddep_i ,width = 2,pad = "0",side = "left")
  # MAJ LISTE INSEE
  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,coddep_i,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  res <- jsonlite::fromJSON(rawToChar(res$content))$results

  return_data <- dplyr::bind_rows(res,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data

}

#' Indicateurs triennaux DV3F à l'échelle du département
#'
#' @param coddep Code INSEE du département (possibilité de passer un vecteur de code insee sans limite maximum)
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

  return_data <- NULL                # MAJ LISTE INSEE

  for (coddep_i in coddep) { # MAJ LISTE INSEE


    print(coddep_i)              # MAJ LISTE INSEE

  args <- list(
    coddep =coddep_i ,# MAJ LISTE INSEE
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='departements'
  indicateur_3='triennal'
  # MAJ LISTE INSEE
  coddep_i  <- stringr::str_pad(coddep_i ,width = 2,pad = "0",side = "left")
  # MAJ LISTE INSEE
  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,coddep_i,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  res <- jsonlite::fromJSON(rawToChar(res$content))$results

  return_data <- dplyr::bind_rows(res,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data

}

#' Indicateurs annuels DV3F à l'échelle de l'epci
#'
#' @param code_epci Code INSEE de l'EPCI (possibilité de passer un vecteur de code insee sans limite maximum)
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

  return_data <- NULL                # MAJ LISTE INSEE

  for (code_epci_i in code_epci) { # MAJ LISTE INSEE


    print(code_epci_i)              # MAJ LISTE INSEE

  args <- list(
    code_epci  =code_epci_i  ,  # MAJ LISTE INSEE
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='epci'
  indicateur_3='annuel'
  # MAJ LISTE INSEE
  code_epci_i   <- stringr::str_pad(code_epci_i ,width = 9,pad = "0",side = "left")
  # MAJ LISTE INSEE
  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,code_epci_i ,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  res <- jsonlite::fromJSON(rawToChar(res$content))$results

  return_data <- dplyr::bind_rows(res,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data

}


#' Indicateurs triennaux DV3F à l'échelle de l'epci
#'
#' @param code_epci Code INSEE de l'EPCI (possibilité de passer un vecteur de code insee sans limite maximum)
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

  return_data <- NULL                # MAJ LISTE INSEE

  for (code_epci_i in code_epci) { # MAJ LISTE INSEE


    print(code_epci_i)              # MAJ LISTE INSEE

  args <- list(
    code_epci  =code_epci_i  ,  # MAJ LISTE INSEE    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='epci'
  indicateur_3='triennal'
  # MAJ LISTE INSEE
  code_epci_i   <- stringr::str_pad(code_epci_i ,width = 9,pad = "0",side = "left")
  # MAJ LISTE INSEE
  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,code_epci_i ,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  res <- jsonlite::fromJSON(rawToChar(res$content))$results

  return_data <- dplyr::bind_rows(res,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data

}


#' Indicateurs annuels DV3F à l'échelle de la région
#'
#' @param codreg Code INSEE de la région (possibilité de passer un vecteur de code insee sans limite maximum)
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

  return_data <- NULL                # MAJ LISTE INSEE

  for (codreg_i in codreg) { # MAJ LISTE INSEE


    print(codreg_i)              # MAJ LISTE INSEE


  args <- list(
    codreg =codreg_i ,# MAJ LISTE INSEE
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='regions'
  indicateur_3='annuel'
  # MAJ LISTE INSEE
  codreg_i  <- stringr::str_pad(codreg_i ,width = 2,pad = "0",side = "left")
  # MAJ LISTE INSEE
  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,codreg_i,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  res <- jsonlite::fromJSON(rawToChar(res$content))$results

  return_data <- dplyr::bind_rows(res,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data

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
  return_data <- NULL                # MAJ LISTE INSEE

  for (codreg_i in codreg) { # MAJ LISTE INSEE


    print(codreg_i)              # MAJ LISTE INSEE


    args <- list(
      codreg =codreg_i ,# MAJ LISTE INSEE
    annee=annee,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='dv3f'
  indicateur_2='regions'
  indicateur_3='triennal'
  # MAJ LISTE INSEE
  codreg_i  <- stringr::str_pad(codreg_i ,width = 2,pad = "0",side = "left")
  # MAJ LISTE INSEE
  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,indicateur_3,codreg_i,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  res <- jsonlite::fromJSON(rawToChar(res$content))$results

  return_data <- dplyr::bind_rows(res,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data

}




