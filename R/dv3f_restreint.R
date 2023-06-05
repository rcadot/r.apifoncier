#' Géomutations
#'
#'
#' @param token token
#' @param anneemut Annee de la mutation (>= 2010) - cf anneemut
#' @param anneemut_max Annee de la mutation maximale - cf anneemut
#' @param anneemut_min Annee de la mutation minimale - cf anneemut
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (il est possible d'en demander plusieurs (10 maximum), séparés par des virgules, dans le même département)
#' @param codtypbien Code(s) de la typologie de bien à sélectionner (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : codtypbien=11,121 - cf codtypbien
#' @param codtypproa Code(s) de la typologie de l'acheteur (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : codtypproa=P,F7 - cf codtypproa
#' @param codtypprov Code(s) de la typologie du vendeur (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : codtypprov=P,F7 - cf codtypprov
#' @param contains_geom Renvoie les entités dont la géometrie contient celle précisée dans le filtre (en format GeoJSON, WKT, HEXEWKB, WKB). Exemple : /?contains_geom={'type':'Point', 'coordinates':\[2.17,46.75\]}
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param filtre Code alphanumerique permettant d'exclure des transactions particulières - cf filtre
#' @param idnatmut Code(s) de nature de mutation (il est possible d'en demander plusieurs en séparant par une virgule - exemple : idnatmut=1,2 - cf idnatmut
#' @param in_bbox Emprise rectangulaire (via Longitude min,Latitude min,Longitude max,Latitude max). L'emprise demandée ne doit pas excéder un carré de 0.02 deg. x 0.02 deg.
#' @param sbati_max Surface maximale bâtie vendue - cf sbati
#' @param sbati_min Surface minimale bâtie vendue - cf sbati
#' @param segmtab Note de segment du terrain à bâtir - cf segmtab
#' @param sterr_max Surface maximale de terrain vendue - cf sterr
#' @param sterr_min Surface minimale de terrain vendue - cf sterr
#' @param valeurfonc_max Valeur foncière maximale (€) - cf valeurfonc
#' @param valeurfonc_min Valeur foncière minimale (€) - cf valeurfonc
#' @param vefa Vente en l'état futur d'achèvement - cf vefa
#'
#' @return Retourne, en GeoJSON, les mutations pour la commune ou l'emprise rectangulaire demandée (paramètre code_insee ou in_bbox obligatoire)
#' @export
#'
#' @examples
#' \dontrun{
#' dv3f_geomutations(code_insee=59001,token=token)
#' }
dv3f_geomutations <- function(
    token=NULL,
    anneemut=NULL,
    anneemut_max=NULL,
    anneemut_min=NULL,
    code_insee=NULL,
    codtypbien=NULL,
    codtypproa=NULL,
    codtypprov=NULL,
    contains_geom=NULL,
    fields=NULL,
    filtre=NULL,
    idnatmut=NULL,
    in_bbox=NULL,
    sbati_max=NULL,
    sbati_min=NULL,
    segmtab=NULL,
    sterr_max=NULL,
    sterr_min=NULL,
    valeurfonc_max=NULL,
    valeurfonc_min=NULL,
    vefa=NULL
){

  base_url='https://apidf-preprod.cerema.fr'
  donnees='dv3f'
  indicateur_1='geomutations'


  url=glue::glue(
    base_url,donnees,indicateur_1,'/',
    .sep = "/"
  )

  headers <- c('Authorization' = paste("Bearer", token))

  page <- 1
  all_data <- list()
  has_more_data <- TRUE

  while (has_more_data) {

    args <- list(
      anneemut=anneemut,
      anneemut_max=anneemut_max,
      anneemut_min=anneemut_min,
      code_insee=code_insee,
      codtypbien=codtypbien,
      codtypproa=codtypproa,
      codtypprov=codtypprov,
      contains_geom=contains_geom,
      fields=fields,
      filtre=filtre,
      idnatmut=idnatmut,
      in_bbox=in_bbox,
      sbati_max=sbati_max,
      sbati_min=sbati_min,
      segmtab=segmtab,
      sterr_max=sterr_max,
      sterr_min=sterr_min,
      valeurfonc_max=valeurfonc_max,
      valeurfonc_min=valeurfonc_min,
      vefa=vefa,
      page=page,
      page_size=5000
    )

    statut <-
      httr::GET(
        url,
        query = purrr::compact(args),
        httr::add_headers(headers)
      )

    if (statut$status_code == 404){

      has_more_data <- FALSE
      # print('has_more_data=FALSE')

    } else {

      pour_total <- jsonlite::fromJSON(rawToChar(statut$content))
      total <- pour_total$count

      data <-
        sf::st_read(
          httr::GET(
            url,
            query = purrr::compact(args),
            httr::add_headers(headers)
          )
        ) %>%
        sf::st_make_valid() #%>%
      # dplyr::group_by(id) %>%
      # dplyr::mutate(proprio_type_lib=proprio_type_lib %>% paste0(collapse = ","))


      # print(page)

      all_data <- dplyr::bind_rows(all_data, data)

      page <- page + 1

      print(paste(nrow(all_data),"/",total))
      # print(page)
    }

    # all_data

  }

  all_data

}

#' Mutations
#'
#' @inheritParams dv3f_geomutations
#'
#' @return Retourne, en GeoJSON, les tup issues des Fichiers Fonciers pour la commune ou l'emprise demandée (paramètre code_insee ou in_bbox obligatoire)
#' @export
#'
#' @examples
#' \dontrun{
#' dv3f_mutations(code_insee=59001,token=token)
#' }
dv3f_mutations <- function(
    token=NULL,
    anneemut=NULL,
    anneemut_max=NULL,
    anneemut_min=NULL,
    code_insee=NULL,
    codtypbien=NULL,
    codtypproa=NULL,
    codtypprov=NULL,
    contains_geom=NULL,
    fields=NULL,
    filtre=NULL,
    idnatmut=NULL,
    in_bbox=NULL,
    sbati_max=NULL,
    sbati_min=NULL,
    segmtab=NULL,
    sterr_max=NULL,
    sterr_min=NULL,
    valeurfonc_max=NULL,
    valeurfonc_min=NULL,
    vefa=NULL
){


  base_url='https://apidf-preprod.cerema.fr'
  donnees='dv3f'
  indicateur_1='mutations'


  url=glue::glue(
    base_url,donnees,indicateur_1,'/',
    .sep = "/"
  )

  headers <- c('Authorization' = paste("Bearer", token))

  page <- 1
  all_data <- list()
  has_more_data <- TRUE

  while (has_more_data) {

    args <- list(
      anneemut=anneemut,
      anneemut_max=anneemut_max,
      anneemut_min=anneemut_min,
      code_insee=code_insee,
      codtypbien=codtypbien,
      codtypproa=codtypproa,
      codtypprov=codtypprov,
      contains_geom=contains_geom,
      fields=fields,
      filtre=filtre,
      idnatmut=idnatmut,
      in_bbox=in_bbox,
      sbati_max=sbati_max,
      sbati_min=sbati_min,
      segmtab=segmtab,
      sterr_max=sterr_max,
      sterr_min=sterr_min,
      valeurfonc_max=valeurfonc_max,
      valeurfonc_min=valeurfonc_min,
      vefa=vefa,
      page=page,
      page_size=5000
    )


    statut <-
      httr::GET(
        url,
        query = purrr::compact(args),
        httr::add_headers(headers)
      )

    if (statut$status_code == 404){

      has_more_data <- FALSE
      # print('has_more_data=FALSE')

    } else {

      pour_total <- jsonlite::fromJSON(rawToChar(statut$content))
      total <- pour_total$count

      res <-
        httr::GET(
          url,
          query = purrr::compact(args),
          httr::add_headers(headers)
        )

      data <- jsonlite::fromJSON(rawToChar(res$content))
      data <- data$results

      # print(page)

      all_data <- dplyr::bind_rows(all_data, data)

      page <- page + 1

      print(paste(nrow(all_data),"/",total))
    }

    # all_data

  }

  all_data


}

#' Mutation issue de DV3F pour l'identifiant de mutation demandé
#'
#' @param token token
#' @param idmutation A unique value identifying this tup
#'
#' @return Retourne la mutation issue de DV3F pour l'identifiant de mutation demandé
#' @export
#'
#' @examples
#' \dontrun{
#' dv3f_mutations_idmutation(idmutation="9033720",token=token)
#' }
dv3f_mutations_idmutation <- function(
    token,
    idmutation
){

  base_url='https://apidf-preprod.cerema.fr'
  donnees='dv3f'
  indicateur_1='mutations'


  url=glue::glue(
    base_url,donnees,indicateur_1,idmutation ,'/',
    .sep = "/"
  )

  headers <- c('Authorization' = paste("Bearer", token))


  res <-
    httr::GET(
      url,
      # query = purrr::compact(args),
      httr::add_headers(headers)
    )

  # res
  data <- jsonlite::fromJSON(rawToChar(res$content))

  # data <-
    # data %>%
    # as.data.frame() %>%
    # tidyr::nest()
    # jsonlite::flatten()
    # tidyr::nest() %>%
    # purrr::flatten() %>%
    # dplyr::as_tibble()
    # purrr::flatten() %>%
    # dplyr::bind_rows()

  #   # dplyr::mutate(dplyr::across(dplyr::everything(),ifelse(is.null(.),NA,.))) %>%
  #   # dplyr::as_tibble() %>%
  #   dplyr::mutate(
  #     dplyr::across(
  #       dplyr::everything(),
  #       # c(l_idlocmut,fftypact,periodecst,batiment,l_idcstloc,idpar_l,l_dcnt,l_ffdcnt,l_idpar),
  #       paste(.,collapse = ",")
  #     )
  #   )
    # dplyr::mutate(idpar_l=paste(idpar_l,collapse = ",")) %>%
    # dplyr::mutate(l_dcnt=paste(l_dcnt,collapse = ",")) %>%

  #   head(1)

  data

}

