

#' Retourne les mutations issues de DV3F pour le périmètre demandée sous forme d’un dataframe
#'
#' @inheritParams dvf.mutations
#'
#' @return Retourne les mutations issues de DV3F pour le périmètre demandée sous forme d’un dataframe
#' @export
#'
dv3f.mutations <- function(
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    ...){


  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/dv3f/mutations/"),
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

#' Retourne les mutations issues de DV3F pour le périmètre demandée sous forme d’un sf
#'
#' @inheritParams dvf.mutations
#'
#' @return Retourne les mutations issues de DV3F pour le périmètre demandée sous forme d’un sf
#' @export
#'
dv3f.geomutations <- function(
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    ...){

  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/dv3f/geomutations/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    params=list(...)
  )


  get_geodataframe(
    resultat
  )


}

#' Renvoie la mutation correspondant à l’identifiant idmutation
#'
#' @param idmutation identifiant de la mutation
#' @param ... pour futurs developpements
#'
#' @return Renvoie la mutation correspondant à l’identifiant idmutation
#' @export
#'
dv3f.mutation <- function(
    idmutation=NULL,
    ...){

  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/dv3f/mutations/{idmutation}/"),
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
