#' Retourne les friches issues de Cartofriches pour la commune, le département ou l'emprise rectangulaire demandée
#'
#' @param coddep Code INSEE départemental
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (il est possible d'en demander plusieurs (10 maximum), séparés par des virgules, dans le même département)
#' @param contains_geom Renvoie les entités dont la géometrie contient celle précisée dans le filtre (en format GeoJSON, WKT, HEXEWKB, WKB). Exemple : /?contains_geom={'type':'Point', 'coordinates':\[2.17,46.75\]}
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param in_bbox Emprise rectangulaire (via Longitude min,Latitude min,Longitude max,Latitude max). L'emprise demandée ne doit pas excéder un carré de 1.0 deg. x 1.0 deg.
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#' @param surface_max Surface maximale de l'unité foncière
#' @param surface_min Surface minimale de l'unité foncière
#' @param urba_zone_type Type de zone d'urbanisme
#'
#' @return Retourne les friches issues de Cartofriches pour la commune, le département ou l'emprise rectangulaire demandée (paramètre code_insee, coddep ou in_bbox obligatoire)
#' @export
#'
#' @examples
#' cartofriches_friches(coddep = 59)
#' cartofriches_friches(code_insee = 59350)
#' cartofriches_friches(in_bbox = '2.827642,50.495958,3.32616,50.767734',page_size = 2)

cartofriches_friches <- function(
    coddep=NULL,
    code_insee=NULL,
    contains_geom=NULL,
    fields=NULL,
    in_bbox=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL,
    surface_max=NULL,
    surface_min=NULL,
    urba_zone_type=NULL
){

  args <- list(
    coddep=coddep,
    code_insee=code_insee,
    contains_geom=contains_geom,
    fields=fields,
    in_bbox=in_bbox,
    ordering=ordering,
    page=page,
    page_size=page_size,
    surface_max=surface_max,
    surface_min=surface_min,
    urba_zone_type=urba_zone_type
    )

  base_url='https://apidf-preprod.cerema.fr'
  donnees='cartofriches'
  indicateur_1='friches'


  url=glue::glue(
    base_url,donnees,indicateur_1,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  jsonlite::fromJSON(rawToChar(res$content))$results %>%
    tibble::as_tibble()

}
