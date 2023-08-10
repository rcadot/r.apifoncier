

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
    ordering=NULL,
    fields=NULL,
    anneemut=NULL,
    anneemut_max=NULL,
    anneemut_min=NULL,
    codtypbien=NULL,
    codtypproa=NULL,
    codtypprov=NULL,
    filtre=NULL,
    idnatmut=NULL,
    sbati_max=NULL,
    sbati_min=NULL,
    segmtab=NULL,
    sterr_max=NULL,
    sterr_min=NULL,
    valeurfonc_max=NULL,
    valeurfonc_min=NULL,
    vefa=NULL,
    ...){


  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/dv3f/mutations/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    params= list(ordering=ordering,
                 fields=fields,
                 anneemut=anneemut,
                 anneemut_max=anneemut_max,
                 anneemut_min=anneemut_min,
                 codtypbien=codtypbien,
                 codtypproa=codtypproa,
                 codtypprov=codtypprov,
                 filtre=filtre,
                 idnatmut=idnatmut,
                 sbati_max=sbati_max,
                 sbati_min=sbati_min,
                 segmtab=segmtab,
                 sterr_max=sterr_max,
                 sterr_min=sterr_min,
                 valeurfonc_max=valeurfonc_max,
                 valeurfonc_min=valeurfonc_min,
                 vefa=vefa,
                 ...)
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
    ordering=NULL,
    fields=NULL,
    anneemut=NULL,
    anneemut_max=NULL,
    anneemut_min=NULL,
    codtypbien=NULL,
    codtypproa=NULL,
    codtypprov=NULL,
    filtre=NULL,
    idnatmut=NULL,
    sbati_max=NULL,
    sbati_min=NULL,
    segmtab=NULL,
    sterr_max=NULL,
    sterr_min=NULL,
    valeurfonc_max=NULL,
    valeurfonc_min=NULL,
    vefa=NULL,
    ...){

  resultat=list(
    use_token=TRUE,
    base_url=get_param("BASE_URL"),
    url=glue::glue("{get_param('BASE_URL')}/dv3f/geomutations/"),
    lon_lat=lon_lat,
    in_bbox=in_bbox,
    code_insee=code_insee,
    params=list(ordering=ordering,
                fields=fields,
                anneemut=anneemut,
                anneemut_max=anneemut_max,
                anneemut_min=anneemut_min,
                codtypbien=codtypbien,
                codtypproa=codtypproa,
                codtypprov=codtypprov,
                filtre=filtre,
                idnatmut=idnatmut,
                sbati_max=sbati_max,
                sbati_min=sbati_min,
                segmtab=segmtab,
                sterr_max=sterr_max,
                sterr_min=sterr_min,
                valeurfonc_max=valeurfonc_max,
                valeurfonc_min=valeurfonc_min,
                vefa=vefa,
                ...)
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
