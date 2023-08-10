# PARCELLES ----

#' Retourne les parcelles issues des Fichiers fonciers pour le périmètre demandé sous forme d’un dataframe
#'
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param in_bbox Emprise rectangulaire (via Longitude min,Latitude min,Longitude max,Latitude max). L'emprise demandée ne doit pas excéder un carré de 0.02 deg. x 0.02 deg.
#' @param lon_lat Coordonnée du point au sein de la ou des friches renvoyées c(longitude, latitude).
#' @param ctpdl Type de pdl (type de copropriété) - cf ctpdl
#' @param dcntarti_max Surface artificialisée maximale de la parcelle (m2) - cf dcntarti
#' @param dcntarti_min Surface artificialisée minimale de la parcelle (m2) - cf dcntarti
#' @param dcntnaf_max Surface NAF maximale de la parcelle (m2) - cf dcntnaf
#' @param dcntnaf_min Surface NAF minimale de la parcelle (m2) - cf dcntnaf
#' @param dcntpa_max Surface maximale de la parcelle (m2) - cf dcntpa
#' @param dcntpa_min Surface minimale de la parcelle (m2) - cf dcntpa
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param idcomtxt Chaine de caractères contenue dans le libellé de la commune - cf idcomtxt
#' @param jannatmin_max Année maximale de construction du local le plus ancien - cf jannatmin
#' @param jannatmin_min Année minimale de construction du local le plus ancien - cf jannatmin
#' @param nlocal_max Nombre de locaux maximal sur la parcelle - cf nlocal
#' @param nlocal_min Nombre de locaux minimal sur la parcelle - cf nlocal
#' @param nlogh_max Nombre de logements maximal sur la parcelle - cf nlogh
#' @param nlogh_min Nombre de logements minimal sur la parcelle - cf nlogh
#' @param slocal_max Surface maximale des parties d'évaluation (m2) - cf slocal
#' @param slocal_min Surface minimale des parties d'évaluation (m2) - cf slocal
#' @param sprincp_max Surface maximale des pièces principales professionnelles (m2) - cf sprincp
#' @param sprincp_min Surface minimale des pièces principales professionnelles (m2) - cf sprincp
#' @param stoth_max Surface maximale des pièces d'habitation (m2) - cf stoth
#' @param stoth_min Surface minimale des pièces d'habitation (m2) - cf stoth
#' @param catpro3 Chaîne(s) de caractères contenue dans le code de catégorie de propriétaire (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : catpro3=P,F2,A2c - cf catpro3
#' @param ... pour futurs developpements
#'
#' @return Retourne les parcelles issues des Fichiers fonciers pour le périmètre demandé sous forme d’un dataframe

#' @export
ff.parcelles <- function(
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    ...){


  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/ff/parcelles/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    params= list(...)
  )


  get_dataframe(
    self = resultat,
    no_param_code = FALSE
  )


}

#' Retourne les parcelles issues des Fichiers fonciers pour le périmètre demandé sous forme d’un geodataframe integrant les contours géométriques
#'
#' @inheritParams ff.parcelles
#'
#' @return Retourne les parcelles issues des Fichiers fonciers pour le périmètre demandé sous forme d’un geodataframe integrant les contours géométriques
#' @export
#'
ff.geoparcelles <- function(
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    ...){

  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/ff/geoparcelles/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    params=list(...)
  )


  get_geodataframe(
    resultat
  )


}


#' Renvoie la parcelle correspondant à l’identifiant idpar
#'
#' @param idpar identifiant de la parcelle
#' @param ... pour futurs developpements
#'
#' @return Renvoie la parcelle correspondant à l’identifiant idpar
#' @export
#'
ff.parcelle <- function(
    idpar=NULL,
    ...){

  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/ff/parcelles/{idpar}/"),
    lon_lat=NULL,
    in_bbox=NULL,
    code_insee=NULL,
    coddep=NULL,
    params= list(...)
  )


  res <- get_api_response(
    url = resultat$url,
    params = resultat$params,
    use_token = resultat$use_token,
    attempt = 1
  )
  res <- lapply(res, function(x) if (is.null(x)) NA_character_ else x)
  res <- purrr::list_flatten(res) %>% tibble::as_tibble()

  res

}


# TUPS ----


#' Retourne les tup issues des Fichiers fonciers pour le périmètre demandé sous forme d’un dataframe
#'
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param in_bbox Emprise rectangulaire (via Longitude min,Latitude min,Longitude max,Latitude max). L'emprise demandée ne doit pas excéder un carré de 0.02 deg. x 0.02 deg.
#' @param lon_lat Coordonnée du point au sein de la ou des friches renvoyées c(longitude, latitude).
#' @param typetup Type de l’entité : SIMPLE, PDLMP ou UF - cf typetup
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param catpro3 Chaîne(s) de caractères contenue dans le code de catégorie de propriétaire (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : catpro3=P,F2,A2c - cf catpro3
#' @param ... pour futurs developpements
#'
#' @return Retourne les tup issues des Fichiers fonciers pour le périmètre demandé sous forme d’un dataframe
#' @export
#'
ff.tups <- function(
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    ...){


  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/ff/tups/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    params= list(...)
  )


  get_dataframe(
    self = resultat,
    no_param_code = FALSE
  )


}

#' Retourne les tup issues des Fichiers fonciers pour le périmètre demandé sous forme d’un geodataframe integrant les contours géométriques
#'
#' @inheritParams ff.tups
#'
#'
#' @return Retourne les tup issues des Fichiers fonciers pour le périmètre demandé sous forme d’un geodataframe integrant les contours géométriques
#' @export
#'
ff.geotups <- function(
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    ...){

  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/ff/geotups/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    params=list(...)
  )


  get_geodataframe(
    resultat
  )


}

#' Renvoie la tup correspondante à l’identifiant idtup
#'
#' @param idtup identifiant de la TUP
#' @param ... pour futurs developpements
#'
#' @return Renvoie la tup correspondante à l’identifiant idtup
#' @export
#'
ff.tup <- function(
    idtup=NULL,
    ...){

  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/ff/parcelles/{idtup}/"),
    lon_lat=NULL,
    in_bbox=NULL,
    code_insee=NULL,
    coddep=NULL,
    params= list(...)
  )


  res <- get_api_response(
    url = resultat$url,
    params = resultat$params,
    use_token = resultat$use_token,
    attempt = 1
  )
  res <- lapply(res, function(x) if (is.null(x)) NA_character_ else x)
  res <- purrr::list_flatten(res) %>% tibble::as_tibble()

  res

}

# LOCAUX ----



#' Retourne les locaux des Fichiers fonciers pour le périmètre demandé sous forme d’un dataframe
#'
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param in_bbox Emprise rectangulaire (via Longitude min,Latitude min,Longitude max,Latitude max). L'emprise demandée ne doit pas excéder un carré de 0.02 deg. x 0.02 deg.
#' @param lon_lat Coordonnée du point au sein de la ou des friches renvoyées c(longitude, latitude).
#' @param dteloc Type(s) de local (il est possible de spécifier plusieurs types et de séparer par une virgule) - exemple : dteloc=1,2 - cf dteloc
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param idpar Identifiant de parcelle - cf idpar
#' @param idprocpte Identifiant de compte communal - cf idprocpte
#' @param idsec Identifiant de section cadastrale - cf idsec
#' @param locprop Localisation généralisée du propriétaire recevant la Taxe Foncière - cf locprop
#' @param loghlls Logement d’habitation de type logement social repéré par exonération - cf loghlls
#' @param ordering Champs à utiliser pour ordonner le résultat. Default NULL
#' @param proba_rprs Probabilité de résidence principale ou secondaire (il est possible de spécifier plusieurs types et de séparer par une virgule) - exemple : proba_rprs=AC,NO - cf proba_rprs
#' @param slocal_max Surface maximale des parties d'évaluation (m2) - cf slocal
#' @param slocal_min Surface minimale des parties d'évaluation (m2) - cf slocal
#' @param typeact Chaîne(s) de caractères contenue dans le classement du local selon le type d'activité (Code catégorie du local d’activité) (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : typeact=MAG,SPE3 - cf typeact
#' @param catpro3 Chaîne(s) de caractères contenue dans le code de catégorie de propriétaire (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : catpro3=P,F2,A2c - cf catpro3
#' @param ... pour futurs developpements
#'
#'
#' @return Retourne les locaux des Fichiers fonciers pour le périmètre demandé sous forme d’un dataframe
#' @export
#'
ff.locaux <- function(
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    ...){


  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/ff/locaux/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    params= list(...)
  )


  get_dataframe(
    self = resultat,
    no_param_code = FALSE
  )


}

#' Renvoie le local correspondant à l’identifiant idlocal
#'
#' @param idlocal identifiant du local
#' @param ... pour futurs developpements
#'
#' @return Renvoie le local correspondant à l’identifiant idlocal
#' @export
#'
ff.local <- function(
    idlocal=NULL,
    ...){

  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/ff/locaux/{idlocal}/"),
    lon_lat=NULL,
    in_bbox=NULL,
    code_insee=NULL,
    coddep=NULL,
    params= list(...)
  )


  res <- get_api_response(
    url = resultat$url,
    params = resultat$params,
    use_token = resultat$use_token,
    attempt = 1
  )
  res <- lapply(res, function(x) if (is.null(x)) NA_character_ else x)
  res <- purrr::list_flatten(res) %>% tibble::as_tibble()

  res

}

# Propriétaires ----


#' Retourne les droits de propriétés des Fichiers fonciers pour le périmètre demandé sous forme d’un dataframe
#'
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param in_bbox Emprise rectangulaire (via Longitude min,Latitude min,Longitude max,Latitude max). L'emprise demandée ne doit pas excéder un carré de 0.02 deg. x 0.02 deg.
#' @param lon_lat Coordonnée du point au sein de la ou des friches renvoyées c(longitude, latitude).
#' @param ccodro Code(s) du droit réel ou particulier (il est possible de spécifier plusieurs valeurs et de séparer par une virgule) - exemple : ccodro=A,B - cf ccodro
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param gtoper Indicateur de personne physique ou morale - cf gtoper
#' @param idprocpte Identifiant de compte communal - cf idprocpte
#' @param locprop Localisation généralisée du propriétaire recevant la Taxe Foncière - cf locprop
#' @param ordering Champs à utiliser pour ordonner le résultat. Default NULL
#' @param typedroit Type de droit : propriétaire ou gestionnaire - cf typedroit
#' @param catpro3 Chaîne(s) de caractères contenue dans le code de catégorie de propriétaire (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : catpro3=P,F2,A2c - cf catpro3
#' @param ... pour futurs developpements
#'
#'
#' @return Retourne les droits de propriétés des Fichiers fonciers pour le périmètre demandé sous forme d’un dataframe
#' @export
#'
ff.proprios <- function(
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    # PROXY = NULL,
    # TOKEN = NULL,
    ...){


  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/ff/proprios/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    params= list(...)
  )


  get_dataframe(
    self = resultat,
    no_param_code = FALSE
    # PROXY = PROXY,
    # TOKEN = TOKEN
  )


}

#' Renvoie le droit de propriété correspondant à l’identifiant idprodroit
#'
#' @param idprodroit identifiant du proprietaire
#' @param ... pour futurs developpements
#'
#' @return Renvoie le droit de propriété correspondant à l’identifiant idprodroit
#' @export
#'
ff.proprio <- function(
    idprodroit=NULL,
    ...
    # PROXY=NULL,
    # TOKEN=NULL
){

  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/ff/proprios/{idprodroit}/"),
    lon_lat=NULL,
    in_bbox=NULL,
    code_insee=NULL,
    coddep=NULL,
    params= list(...)
  )


  res <- get_api_response(
    url = resultat$url,
    params = resultat$params,
    use_token = resultat$use_token,
    attempt = 1
    # PROXY = PROXY,
    # TOKEN = TOKEN
  )
  res <- lapply(res, function(x) if (is.null(x)) NA_character_ else x)
  res <- purrr::list_flatten(res) %>% tibble::as_tibble()

  res

}

