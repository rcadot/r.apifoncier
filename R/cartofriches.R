#' Retourne, en GeoJSON, les friches issues de Cartofriches pour la commune, le département ou l'emprise rectangulaire demandée (paramètre code_insee, coddep ou in_bbox obligatoire)
#'
#' @param coddep Code INSEE départemental
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (il est possible d'en demander plusieurs (10 maximum), séparés par des virgules, dans le même département)
#' @param contains_geom Renvoie les entités dont la géometrie contient celle précisée dans le filtre (en format GeoJSON, WKT, HEXEWKB, WKB). Exemple : /?contains_geom={'type':'Point', 'coordinates':\[2.17,46.75\]}
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param in_bbox Emprise rectangulaire (via Longitude min,Latitude min,Longitude max,Latitude max). L'emprise demandée ne doit pas excéder un carré de 1.0 deg. x 1.0 deg.
#' @param surface_max Surface maximale de l'unité foncière
#' @param surface_min Surface minimale de l'unité foncière
#' @param urba_zone_type Type de zone d'urbanisme
#'
#' @return Retourne les friches issues de Cartofriches pour la commune, le département ou l'emprise rectangulaire demandée (paramètre code_insee, coddep ou in_bbox obligatoire)
#' @export
#'
#' @examples
#' cartofriches_geofriches(code_insee = 59350)
#' cartofriches_geofriches(in_bbox = '2.827642,50.495958,3.32616,50.767734')

cartofriches_geofriches <- function(
    coddep=NULL,
    code_insee=NULL,
    contains_geom=NULL,
    fields=NULL,
    in_bbox=NULL,
    # page=NULL,
    # page_size=NULL,
    surface_max=NULL,
    surface_min=NULL,
    urba_zone_type=NULL
){



  base_url='https://apidf-preprod.cerema.fr'
  donnees='cartofriches'
  indicateur_1='geofriches'


  url=glue::glue(
    base_url,donnees,indicateur_1,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()



  page <- 1
  all_data <- list()
  has_more_data <- TRUE

  while (has_more_data) {

    args <- list(
      coddep=coddep,
      code_insee=code_insee,
      contains_geom=contains_geom,
      fields=fields,
      in_bbox=in_bbox,
      page=page,
      page_size=500,
      surface_max=surface_max,
      surface_min=surface_min,
      urba_zone_type=urba_zone_type
    )

    statut <- httr::GET(url, query = purrr::compact(args))

    if (statut$status_code == 404){

      has_more_data <- FALSE
      # print('has_more_data=FALSE')

    } else {

      data <-
        sf::st_read(
          httr::GET(url, query = purrr::compact(args)),
          quiet=TRUE
          ) %>%
        sf::st_make_valid() %>%
        dplyr::group_by(id) %>%
        dplyr::mutate(proprio_type_lib=proprio_type_lib %>% paste0(collapse = ","))


      # print(page)

      all_data <- dplyr::bind_rows(all_data, data)

      page <- page + 1
      # print(page)
    }

    # all_data

  }

  all_data

}


#' Retourne les friches issues de Cartofriches pour la commune, le département ou l'emprise rectangulaire demandée
#'
#' @param coddep Code INSEE départemental
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (il est possible d'en demander plusieurs (10 maximum), séparés par des virgules, dans le même département)
#' @param contains_geom Renvoie les entités dont la géometrie contient celle précisée dans le filtre (en format GeoJSON, WKT, HEXEWKB, WKB). Exemple : /?contains_geom={'type':'Point', 'coordinates':\[2.17,46.75\]}
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param in_bbox Emprise rectangulaire (via Longitude min,Latitude min,Longitude max,Latitude max). L'emprise demandée ne doit pas excéder un carré de 1.0 deg. x 1.0 deg.
#' @param ordering Which field to use when ordering the results.
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
#' cartofriches_friches(in_bbox = '2.827642,50.495958,3.32616,50.767734')

cartofriches_friches <- function(
    coddep=NULL,
    code_insee=NULL,
    contains_geom=NULL,
    fields=NULL,
    in_bbox=NULL,
    ordering=NULL,
    # page=NULL,
    # page_size=NULL,
    surface_max=NULL,
    surface_min=NULL,
    urba_zone_type=NULL
){

  base_url='https://apidf-preprod.cerema.fr'
  donnees='cartofriches'
  indicateur_1='friches'

  url=glue::glue(
    base_url,donnees,indicateur_1,'/',
    .sep = "/"
  )

  page <- 1
  all_data <- list()
  has_more_data <- TRUE

  while (has_more_data) {

    args <- list(
      coddep=coddep,
      code_insee=code_insee,
      contains_geom=contains_geom,
      fields=fields,
      in_bbox=in_bbox,
      ordering=ordering,
      page=page,
      page_size=500,
      surface_max=surface_max,
      surface_min=surface_min,
      urba_zone_type=urba_zone_type
    )

    statut <- httr::GET(url, query = purrr::compact(args))

    if (statut$status_code == 404){

      has_more_data <- FALSE
      # print('has_more_data=FALSE')

    } else {


      # Chek for internet
      # check_internet()

      res <- httr::GET(url, query = purrr::compact(args))

      # Check the result
      # check_status(res)

      data <- jsonlite::fromJSON(rawToChar(res$content))$results %>%
        tibble::as_tibble()

      all_data <- dplyr::bind_rows(all_data, data)

      page <- page + 1

    }

  }

  all_data

}


#' Retourne la friche pour l'identifiant de site demandé
#'
#' @param site_id A unique value identifying this cartofriches.
#'
#' @return Retourne la friche pour l'identifiant de site demandé
#' @export
#'
#' @examples
#' cartofriches_friches_site(site_id = '59002_10038')

cartofriches_friches_site <- function(
    site_id=NULL
){



  base_url='https://apidf-preprod.cerema.fr'
  donnees='cartofriches'
  indicateur_1='friches'



  url=glue::glue(
    base_url,donnees,indicateur_1,site_id %>% as.character(),'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url)

  # Check the result
  # check_status(res)

  jsonlite::fromJSON(rawToChar(res$content)) %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(l_idpar=paste(l_idpar,collapse = ",")) %>%
    head(1)

}
