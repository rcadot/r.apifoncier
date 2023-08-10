#' Retourne les friches issues de Cartofriches pour le périmètre demandé sous forme d’un dataframe
#'
#' @param code_insee Codes INSEE communaux ou des arrondissements municipaux.
#' @param coddep Codes INSEE des départements.
#' @param in_bbox Emprise rectangulaire sous la forme d’un vecteur c(longitude_min, latitude_min, longitude_min, latitude_max)
#' @param lon_lat Coordonnée du point au sein de la ou des friches renvoyées c(longitude, latitude)
#' @param ordering Champs à utiliser pour ordonner le résultat. Default NULL
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param surface_max Surface maximale de l'unité foncière
#' @param surface_min Surface minimale de l'unité foncière
#' @param urba_zone_type Type de zone d'urbanisme
#' @param ... pour futurs developpements
#'
#' @return Retourne les friches issues de Cartofriches pour le périmètre demandé sous forme d’un dataframe
#' @export
#'
#' @examples
#' cartofriches.friches(code_insee="59350")
#' cartofriches.friches(coddep="59")
#' cartofriches.friches(in_bbox=c(3, 50, 4, 51))
cartofriches.friches <- function(
    coddep=NULL,
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    ordering=NULL,
    fields=NULL,
    surface_max=NULL,
    surface_min=NULL,
    urba_zone_type=NULL,
    ...){

  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/cartofriches/friches/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    coddep=coddep,
    params= list(ordering=ordering,
                 fields=fields,
                 surface_max=surface_max,
                 surface_min=surface_min,
                 urba_zone_type=urba_zone_type,
                 ...)
  )


  get_dataframe(
    self = resultat,
    no_param_code = FALSE
  )

}


#' Renvoi la friche correpondant au site_id
#'
#' @param id_site identifiant du site
#' @param ... pour futurs developpements
#'
#' @return Renvoi la friche correpondant au site_id
#' @export
#'
cartofriches.friche <- function(
    id_site=NULL,
    ...){

  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/cartofriches/friches/{id_site}/"),
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
  res <- res %>%
    dplyr::mutate(
      dplyr::across(
        dplyr::where(
          is.integer
        ),
        ~{as.numeric(.)}
      )
    )
  res

}

#' Retourne les friches issues de Cartofriches pour le périmètre demandé sous forme d’un geodataframe
#'
#' @inheritParams cartofriches.friches
#'
#' @return Retourne les friches issues de Cartofriches pour le périmètre demandé sous forme d’un geodataframe
#' @export
#'
#' @examples
#' cartofriches.geofriches(code_insee="59350")
#' cartofriches.geofriches(coddep="59")
#' cartofriches.geofriches(in_bbox=c(3, 50, 4, 51))
cartofriches.geofriches <- function(
    coddep=NULL,
    code_insee=NULL,
    lon_lat=NULL,
    in_bbox=NULL,
    ordering=NULL,
    fields=NULL,
    surface_max=NULL,
    surface_min=NULL,
    urba_zone_type=NULL,
    ...){

  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/cartofriches/geofriches/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    coddep=coddep,
    code_insee=code_insee,
    params=list(ordering=ordering,
                fields=fields,
                surface_max=surface_max,
                surface_min=surface_min,
                urba_zone_type=urba_zone_type,
                ...)
  )

  get_geodataframe(
    resultat
  )

}
