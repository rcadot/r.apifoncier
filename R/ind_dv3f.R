

#' Retourne les indicateurs annuels ou triennaux de prix à l’aire d’attraction de la ville
#'
#' @param code_insee Code AAV de l'aire INSEE
#' @param periode  Prend la valeur « annuel » ou « triennal ». Defaults to annuel.
#' @param annee Année de mutation
#' @param ordering Champs à utiliser pour ordonner le résultat. Default NULL
#' @param ... pour futurs developpements
#'
#' @return dataframe: données sur les marchés immobiliers
#' @export
#'
#' @examples
#' prix.aav(code_insee="001")
#' prix.aav(code_insee=c("001", "002"), annee="2020")
#' prix.aav(code_insee=c("001", "002"), periode="triennal")
#'

prix.aav <- function(code_insee,
                     periode='annuel',
                     annee=NULL,
                     ordering=NULL,
                     ...){

  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/indicateurs/dv3f/aav/{periode}/"),
    lon_lat=NULL,
    in_bbox=NULL,
    code_insee=code_insee,
    coddep=NULL,
    params= list(annee=annee,
                 ordering=ordering,
                 ...)
  )


  if (!(periode %in% c("annuel", "triennal"))) {
    stop("Le parametre periode doit valoir 'annuel' ou 'triennal'.", call. = FALSE)
  }

  get_dataframe(
    self = resultat,
    no_param_code = TRUE
    # PROXY = PROXY,
    # TOKEN = NULL
  )

}

#' Retourne les indicateurs annuels ou triennaux de prix à la commune
#'
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param periode  Prend la valeur « annuel » ou « triennal ». Defaults to annuel.
#' @param annee Année de mutation
#' @param ordering Champs à utiliser pour ordonner le résultat. Default NULL
#' @param ... pour futurs developpements
#'
#' @return dataframe: données sur les marchés immobiliers
#' @export
#'
#' @examples
#' prix.communes(code_insee="59350")
#' prix.communes(code_insee=c("59350", "59646"), annee="2020")
#' prix.communes(code_insee=c("59350", "59646"), periode="triennal")

prix.communes <- function(code_insee,
                          periode='annuel',
                          annee=NULL,
                          ordering=NULL,
                          ...){

  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/indicateurs/dv3f/communes/{periode}/"),
    lon_lat=NULL,
    in_bbox=NULL,
    code_insee=code_insee,
    coddep=NULL,
    params= list(annee=annee,
                 ordering=ordering,
                 ...)
    # token=NULL
  )


  if (!(periode %in% c("annuel", "triennal"))) {
    stop("Le parametre periode doit valoir 'annuel' ou 'triennal'.", call. = FALSE)
  }

  get_dataframe(
    self = resultat,
    no_param_code = TRUE
    # PROXY = PROXY,
    # TOKEN = NULL
  )

}


#' Retourne les indicateurs annuels ou triennaux de prix au département
#'
#' @param coddep  Codes des départements
#' @param periode  Prend la valeur « annuel » ou « triennal ». Defaults to annuel.
#' @param annee Année de mutation
#' @param ordering Champs à utiliser pour ordonner le résultat. Default NULL
#' @param ... pour futurs developpements
#'
#' @return dataframe: données sur les marchés immobiliers
#' @export
#'
#' @examples
#' prix.departements(coddep="59")
#' prix.departements(coddep=c("59", "62"), annee="2020")
#' prix.departements(coddep=c("59", "62"), periode="triennal")

prix.departements <- function(coddep,
                              periode='annuel',
                              annee=NULL,
                              ordering=NULL,
                              ...){

  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/indicateurs/dv3f/departements/{periode}/"),
    lon_lat=NULL,
    in_bbox=NULL,
    # code_insee=code_insee,
    coddep=coddep,
    params= list(annee=annee,
                 ordering=ordering,
                 ...)
    # token=NULL
  )


  if (!(periode %in% c("annuel", "triennal"))) {
    stop("Le parametre periode doit valoir 'annuel' ou 'triennal'.", call. = FALSE)
  }

  get_dataframe(
    self = resultat,
    no_param_code = TRUE
    # PROXY = PROXY,
    # TOKEN = NULL
  )

}


#' Retourne les indicateurs annuels ou triennaux de prix à l'EPCI
#'
#' @param code_insee  Codes des EPCI
#' @param periode  Prend la valeur « annuel » ou « triennal ». Defaults to annuel.
#' @param annee Année de mutation
#' @param ordering Champs à utiliser pour ordonner le résultat. Default NULL
#' @param ... pour futurs developpements
#'
#' @return dataframe: données sur les marchés immobiliers
#' @export
#'
#' @examples
#' prix.epci(code_insee="200093201")
#' prix.epci(code_insee="200093201", periode="triennal")
#'
prix.epci <- function(code_insee,
                      periode='annuel',
                      annee=NULL,
                      ordering=NULL,
                      ...){

  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/indicateurs/dv3f/epci/{periode}/"),
    lon_lat=NULL,
    in_bbox=NULL,
    code_insee=code_insee,
    coddep=NULL,
    params= list(annee=annee,
                 ordering=ordering,
                 ...)
  )


  if (!(periode %in% c("annuel", "triennal"))) {
    stop("Le parametre periode doit valoir 'annuel' ou 'triennal'.", call. = FALSE)
  }

  get_dataframe(
    self = resultat,
    no_param_code = TRUE
  )

}



#' Retourne les indicateurs annuels ou triennaux de prix à la région
#'
#' @param code_insee  Codes des régions
#' @param periode  Prend la valeur « annuel » ou « triennal ». Defaults to annuel.
#' @param annee Année de mutation
#' @param ordering Champs à utiliser pour ordonner le résultat. Default NULL
#' @param ... pour futurs developpements
#'
#' @return dataframe: données sur les marchés immobiliers
#' @export
#'
#' @examples
#' prix.regions(code_insee="32")
#' prix.regions(code_insee=c("32", "11"), annee="2020")
#' prix.regions(code_insee=c("32", "11"), periode="triennal")
prix.regions <- function(code_insee,
                         periode='annuel',
                         annee=NULL,
                         ordering=NULL,
                         ...){

  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/indicateurs/dv3f/regions/{periode}/"),
    lon_lat=NULL,
    in_bbox=NULL,
    code_insee=code_insee,
    coddep=NULL,
    params= list(annee=annee,
                 ordering=ordering,
                 ...)
  )


  if (!(periode %in% c("annuel", "triennal"))) {
    stop("Le parametre periode doit valoir 'annuel' ou 'triennal'.", call. = FALSE)
  }

  get_dataframe(
    self = resultat,
    no_param_code = TRUE
  )

}
