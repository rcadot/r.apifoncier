#' Retourne les mutations issues de DVF+ opendata pour le périmètre demandée sous forme d’un dataframe
#'
#' @param code_insee Codes INSEE communaux ou des arrondissements municipaux.
#' @param coddep Codes INSEE des départements.
#' @param in_bbox Emprise rectangulaire sous la forme d’un vecteur c(longitude_min, latitude_min, longitude_min, latitude_max)
#' @param lon_lat Coordonnée du point au sein de la ou des friches renvoyées c(longitude, latitude)
#' @param ordering Champs à utiliser pour ordonner le résultat. Default NULL
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param anneemut Annee de la mutation (>= 2010) - cf anneemut
#' @param anneemut_max Annee de la mutation maximale - cf anneemut
#' @param anneemut_min Annee de la mutation minimale - cf anneemut
#' @param codtypbien Code(s) de la typologie de bien à sélectionner (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : codtypbien=11,121 - cf codtypbien
#' @param codtypproa Code(s) de la typologie de l'acheteur (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : codtypproa=P,F7 - cf codtypproa
#' @param codtypprov Code(s) de la typologie du vendeur (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : codtypprov=P,F7 - cf codtypprov
#' @param filtre Code alphanumerique permettant d'exclure des transactions particulières - cf filtre
#' @param idnatmut Code(s) de nature de mutation (il est possible d'en demander plusieurs en séparant par une virgule - exemple : idnatmut=1,2 - cf idnatmut
#' @param sbati_max Surface maximale bâtie vendue - cf sbati
#' @param sbati_min Surface minimale bâtie vendue - cf sbati
#' @param segmtab Note de segment du terrain à bâtir - cf segmtab
#' @param sterr_max Surface maximale de terrain vendue - cf sterr
#' @param sterr_min Surface minimale de terrain vendue - cf sterr
#' @param valeurfonc_max Valeur foncière maximale (€) - cf valeurfonc
#' @param valeurfonc_min Valeur foncière minimale (€) - cf valeurfonc
#' @param vefa Vente en l'état futur d'achèvement - cf vefa
#' @param ... pour futurs developpements
#'
#' @return Retourne les mutations issues de DVF+ opendata pour le périmètre demandée sous forme d’un dataframe
#' @export
#'
#' @examples
#' dvf.mutations(code_insee="59001")
#' dvf.mutations(in_bbox=c(3, 50, 3.01, 50.01), fields="all")
#' dvf.mutations(code_insee=c("59350", "59646"), valeurfonc_min=1000000)
dvf.mutations <- function(
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    ...){

  process_geo_params(code_insee=code_insee,
                     lon_lat=lon_lat,
                     in_bbox=in_bbox)

  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/dvf_opendata/mutations/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    params= list(...)
  )


  get_dataframe(
    self = resultat,
    no_param_code = FALSE,
    conversion_tibble = TRUE
  )


}

#' Retourne les mutations issues de DVF+ opendata pour le périmètre demandée sous forme d’un sf
#'
#' @inheritParams dvf.mutations
#'
#' @return Retourne les mutations issues de DVF+ opendata pour le périmètre demandée sous forme d’un sf
#' @export
#'
#' @examples
#' dvf.geomutations(code_insee="59001")
#' dvf.geomutations(in_bbox=c(3, 50, 3.01, 50.01), fields="all")
#' dvf.geomutations(code_insee=c("59350", "59646"), valeurfonc_min=1000000)
dvf.geomutations <- function(
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    ...){

  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/dvf_opendata/geomutations/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    params=list(...)
  )


  get_geodataframe(
    resultat
  )


}

#' Renvoi la mutation correspondant à l’identifiant idmutation
#'
#' @param idmutation identifiant de la mutation
#' @param ... pour futurs developpements
#'
#' @return Renvoi la mutation correspondant à l’identifiant idmutation
#' @export
#'

dvf.mutation <- function(
    idmutation=NULL,
    ...){

  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/dvf_opendata/mutations/{idmutation}/"),
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
