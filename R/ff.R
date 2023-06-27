#' Parcelles
#'
#' @param token token
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param contains_geom Renvoie les entités dont la géometrie contient celle précisée dans le filtre (en format GeoJSON, WKT, HEXEWKB, WKB). Exemple : /?contains_geom={'type':'Point', 'coordinates':\[2.17,46.75\]}
#' @param ctpdl Type de pdl (type de copropriété) - cf ctpdl
#' @param dcntarti_max Surface artificialisée maximale de la parcelle (m2) - cf dcntarti
#' @param dcntarti_min Surface artificialisée minimale de la parcelle (m2) - cf dcntarti
#' @param dcntnaf_max Surface NAF maximale de la parcelle (m2) - cf dcntnaf
#' @param dcntnaf_min Surface NAF minimale de la parcelle (m2) - cf dcntnaf
#' @param dcntpa_max Surface maximale de la parcelle (m2) - cf dcntpa
#' @param dcntpa_min Surface minimale de la parcelle (m2) - cf dcntpa
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param idcomtxt Chaine de caractères contenue dans le libellé de la commune - cf idcomtxt
#' @param in_bbox Emprise rectangulaire (via Longitude min,Latitude min,Longitude max,Latitude max). L'emprise demandée ne doit pas excéder un carré de 0.02 deg. x 0.02 deg.
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
#'
#' @return Retourne, en GeoJSON, les parcelles issues des Fichiers Fonciers pour la commune ou l'emprise rectangulaire demandée (paramètre in_bbox ou code_insee obligatoire)
#' @export
#'
#' @examples
#' \dontrun{
#' ff_geoparcelles(code_insee=59001,token=token)
#' }
ff_geoparcelles <- function(
    token,
    code_insee=NULL,
    contains_geom=NULL,
    ctpdl=NULL,
    dcntarti_max=NULL,
    dcntarti_min=NULL,
    dcntnaf_max=NULL,
    dcntnaf_min=NULL,
    dcntpa_max=NULL,
    dcntpa_min=NULL,
    fields=NULL,
    idcomtxt=NULL,
    in_bbox=NULL,
    jannatmin_max=NULL,
    jannatmin_min=NULL,
    nlocal_max=NULL,
    nlocal_min=NULL,
    nlogh_max=NULL,
    nlogh_min=NULL,
    slocal_max=NULL,
    slocal_min=NULL,
    sprincp_max=NULL,
    sprincp_min=NULL,
    stoth_max=NULL,
    stoth_min=NULL,
    catpro3=NULL
){


  base_url='https://apidf-preprod.cerema.fr'
  donnees='ff'
  indicateur_1='geoparcelles'


  url=glue::glue(
    base_url,donnees,indicateur_1,'/',
    .sep = "/"
  )

  headers <- c('Authorization' = paste("Bearer", token))


  return_data <- NULL                # MAJ LISTE INSEE

  for (code_insee_i in code_insee) { # MAJ LISTE INSEE


    print(code_insee_i)              # MAJ LISTE INSEE


  page <- 1
  all_data <- list()
  has_more_data <- TRUE

  while (has_more_data) {

    args <- list(
      code_insee=code_insee_i,   # MAJ LISTE INSEE
      contains_geom=contains_geom,
      ctpdl=ctpdl,
      dcntarti_max=dcntarti_max,
      dcntarti_min=dcntarti_min,
      dcntnaf_max=dcntnaf_max,
      dcntnaf_min=dcntnaf_min,
      dcntpa_max=dcntpa_max,
      dcntpa_min=dcntpa_min,
      fields=fields,
      idcomtxt=idcomtxt,
      in_bbox=in_bbox,
      jannatmin_max=jannatmin_max,
      jannatmin_min=jannatmin_min,
      nlocal_max=nlocal_max,
      nlocal_min=nlocal_min,
      nlogh_max=nlogh_max,
      nlogh_min=nlogh_min,
      page=page,
      page_size=5000,
      slocal_max=slocal_max,
      slocal_min=slocal_min,
      sprincp_max=sprincp_max,
      sprincp_min=sprincp_min,
      stoth_max=stoth_max,
      stoth_min=stoth_min,
      catpro3=catpro3
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
          ),quiet=TRUE
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

  return_data <- dplyr::bind_rows(all_data,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data                                              # MAJ LISTE INSEE


}






#' GeoTUP
#'
#' @param token token
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param contains_geom Renvoie les entités dont la géometrie contient celle précisée dans le filtre (en format GeoJSON, WKT, HEXEWKB, WKB). Exemple : /?contains_geom={'type':'Point', 'coordinates':\[2.17,46.75\]}
#' @param typetup Type de l’entité : SIMPLE, PDLMP ou UF - cf typetup
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param in_bbox Emprise rectangulaire (via Longitude min,Latitude min,Longitude max,Latitude max). L'emprise demandée ne doit pas excéder un carré de 0.02 deg. x 0.02 deg.
#' @param catpro3 Chaîne(s) de caractères contenue dans le code de catégorie de propriétaire (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : catpro3=P,F2,A2c - cf catpro3
#'
#' @return Retourne, en GeoJSON, les tup issues des Fichiers Fonciers pour la commune ou l'emprise demandée (paramètre code_insee ou in_bbox obligatoire)
#' @export
#'
#' @examples
#' \dontrun{
#' ff_geotups(code_insee=59001,token=token)
#' }
ff_geotups <- function(
    token,
    code_insee=NULL,
    contains_geom=NULL,
    typetup=NULL,
    fields=NULL,
    in_bbox=NULL,
    catpro3=NULL
){
  base_url='https://apidf-preprod.cerema.fr'
  donnees='ff'
  indicateur_1='geotups'


  url=glue::glue(
    base_url,donnees,indicateur_1,'/',
    .sep = "/"
  )

  headers <- c('Authorization' = paste("Bearer", token))

  return_data <- NULL                # MAJ LISTE INSEE

  for (code_insee_i in code_insee) { # MAJ LISTE INSEE


    print(code_insee_i)              # MAJ LISTE INSEE

    page <- 1
    all_data <- list()
    has_more_data <- TRUE



    while (has_more_data) {

      args <- list(
        code_insee=code_insee_i,
        contains_geom=contains_geom,
        typetup=typetup,
        fields=fields,
        in_bbox=in_bbox,
        catpro3=catpro3,
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

        data <-
          sf::st_read(
            httr::GET(
              url,
              query = purrr::compact(args),
              httr::add_headers(headers)
            ),quiet=TRUE
          ) %>%
          sf::st_make_valid()

        # print(page)
        pour_total <- jsonlite::fromJSON(rawToChar(statut$content))
        total <- pour_total$count

        all_data <- dplyr::bind_rows(all_data, data)

        page <- page + 1
        # print(page)
        print(paste(nrow(all_data),"/",total))
      }

      # all_data

    }

    return_data <- dplyr::bind_rows(all_data,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data                                              # MAJ LISTE INSEE


}



#' Locaux
#'
#' @param token token
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param dteloc Type(s) de local (il est possible de spécifier plusieurs types et de séparer par une virgule) - exemple : dteloc=1,2 - cf dteloc
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param idpar Identifiant de parcelle - cf idpar
#' @param idprocpte Identifiant de compte communal - cf idprocpte
#' @param idsec Identifiant de section cadastrale - cf idsec
#' @param locprop Localisation généralisée du propriétaire recevant la Taxe Foncière - cf locprop
#' @param loghlls Logement d’habitation de type logement social repéré par exonération - cf loghlls
#' @param ordering Which field to use when ordering the results.
#' @param proba_rprs Probabilité de résidence principale ou secondaire (il est possible de spécifier plusieurs types et de séparer par une virgule) - exemple : proba_rprs=AC,NO - cf proba_rprs
#' @param slocal_max Surface maximale des parties d'évaluation (m2) - cf slocal
#' @param slocal_min Surface minimale des parties d'évaluation (m2) - cf slocal
#' @param typeact Chaîne(s) de caractères contenue dans le classement du local selon le type d'activité (Code catégorie du local d’activité) (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : typeact=MAG,SPE3 - cf typeact
#' @param catpro3 Chaîne(s) de caractères contenue dans le code de catégorie de propriétaire (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : catpro3=P,F2,A2c - cf catpro3
#'
#' @return Retourne les locaux issus des Fichiers Fonciers pour la commune demandée (paramètre code_insee obligatoire)
#' @export
#'
#' @examples
#' \dontrun{
#' ff_locaux(code_insee='59001',token=token)
#' }
ff_locaux <- function(
    token,
    code_insee=NULL,
    dteloc=NULL,
    fields=NULL,
    idpar=NULL,
    idprocpte=NULL,
    idsec=NULL,
    locprop=NULL,
    loghlls=NULL,
    ordering=NULL,
    proba_rprs=NULL,
    slocal_max=NULL,
    slocal_min=NULL,
    typeact=NULL,
    catpro3=NULL
){


  base_url='https://apidf-preprod.cerema.fr'
  donnees='ff'
  indicateur_1='locaux'


  url=glue::glue(
    base_url,donnees,indicateur_1,'/',
    .sep = "/"
  )

  headers <- c('Authorization' = paste("Bearer", token))

  return_data <- NULL                # MAJ LISTE INSEE

  for (code_insee_i in code_insee) { # MAJ LISTE INSEE


    print(code_insee_i)              # MAJ LISTE INSEE

  page <- 1
  all_data <- list()
  has_more_data <- TRUE

  while (has_more_data) {

    args <- list(
      code_insee=code_insee_i,   # MAJ LISTE INSEE
      dteloc=dteloc,
      fields=fields,
      idpar=idpar,
      idprocpte=idprocpte,
      idsec=idsec,
      locprop=locprop,
      loghlls=loghlls,
      ordering=ordering,
      proba_rprs=proba_rprs,
      slocal_max=slocal_max,
      slocal_min=slocal_min,
      typeact=typeact,
      catpro3=catpro3,
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

      res <-
        httr::GET(
          url,
          query = purrr::compact(args),
          httr::add_headers(headers)
        )

      data <- jsonlite::fromJSON(rawToChar(res$content))

      total <- data$count
      data <- data$results

      all_data <- dplyr::bind_rows(all_data, data)

      page <- page + 1
      print(paste(nrow(all_data),"/",total))
    }

    # all_data

  }

  return_data <- dplyr::bind_rows(all_data,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data                                              # MAJ LISTE INSEE


}

#' Locaux pour un identifiant local du local demandé
#'
#' @param token token
#' @param idlocal A unique value identifying this local.
#'
#' @return Retourne le local des Fichiers fonciers pour l'identifiant fiscal du local demandé
#' @export
#'
#' @examples
#' \dontrun{
#' ff_locaux_idlocal(idlocal="***",token=token)
#' }
ff_locaux_idlocal <- function(
    token,
    idlocal
){

  base_url='https://apidf-preprod.cerema.fr'
  donnees='ff'
  indicateur_1='locaux'


  url=glue::glue(
    base_url,donnees,indicateur_1,idlocal,'/',
    .sep = "/"
  )

  headers <- c('Authorization' = paste("Bearer", token))


  # args <- list(
  #   idpk=idpk
  # )

  res <-
    httr::GET(
      url,
      # query = purrr::compact(args),
      httr::add_headers(headers)
    )

  data <- jsonlite::fromJSON(rawToChar(res$content))

  data <- data$results

  data


}


#' Parcelles
#'
#' @inheritParams ff_geoparcelles
#'
#' @return Retourne les parcelles issues des Fichiers Fonciers pour la commune ou l'emprise rectangulaire demandée (paramètre in_bbox ou code_insee obligatoire)
#' @export
#'
#' @examples
#' \dontrun{
#' ff_parcelles(code_insee=59001,token=token)
#' }
ff_parcelles <- function(
    token,
    code_insee=NULL,
    contains_geom=NULL,
    ctpdl=NULL,
    dcntarti_max=NULL,
    dcntarti_min=NULL,
    dcntnaf_max=NULL,
    dcntnaf_min=NULL,
    dcntpa_max=NULL,
    dcntpa_min=NULL,
    fields=NULL,
    idcomtxt=NULL,
    in_bbox=NULL,
    jannatmin_max=NULL,
    jannatmin_min=NULL,
    nlocal_max=NULL,
    nlocal_min=NULL,
    nlogh_max=NULL,
    nlogh_min=NULL,
    slocal_max=NULL,
    slocal_min=NULL,
    sprincp_max=NULL,
    sprincp_min=NULL,
    stoth_max=NULL,
    stoth_min=NULL,
    catpro3=NULL
){


  base_url='https://apidf-preprod.cerema.fr'
  donnees='ff'
  indicateur_1='parcelles'


  url=glue::glue(
    base_url,donnees,indicateur_1,'/',
    .sep = "/"
  )

  headers <- c('Authorization' = paste("Bearer", token))

  return_data <- NULL                # MAJ LISTE INSEE

  for (code_insee_i in code_insee) { # MAJ LISTE INSEE


    print(code_insee_i)              # MAJ LISTE INSEE

  page <- 1
  all_data <- list()
  has_more_data <- TRUE

  while (has_more_data) {

    args <- list(
      code_insee=code_insee_i,   # MAJ LISTE INSEE
      contains_geom=contains_geom,
      ctpdl=ctpdl,
      dcntarti_max=dcntarti_max,
      dcntarti_min=dcntarti_min,
      dcntnaf_max=dcntnaf_max,
      dcntnaf_min=dcntnaf_min,
      dcntpa_max=dcntpa_max,
      dcntpa_min=dcntpa_min,
      fields=fields,
      idcomtxt=idcomtxt,
      in_bbox=in_bbox,
      jannatmin_max=jannatmin_max,
      jannatmin_min=jannatmin_min,
      nlocal_max=nlocal_max,
      nlocal_min=nlocal_min,
      nlogh_max=nlogh_max,
      nlogh_min=nlogh_min,
      page=page,
      page_size=5000,
      slocal_max=slocal_max,
      slocal_min=slocal_min,
      sprincp_max=sprincp_max,
      sprincp_min=sprincp_min,
      stoth_max=stoth_max,
      stoth_min=stoth_min,
      catpro3=catpro3
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
      # print(page)
    }

    # all_data

  }

  return_data <- dplyr::bind_rows(all_data,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data                                              # MAJ LISTE INSEE


}

#' Locaux pour un identifiant fiscal du local demandé
#'
#' @param token token
#' @param idpar A unique value identifying this parcelle.
#'
#' @return Retourne la parcelle issue des Fichiers fonciers pour l'identifiant de parcelle (référence cadastrale) demandé
#' @export
#'
#' @examples
#' \dontrun{
#' ff_parcelles_idpar(idpar="02722000BW0072",token=token)
#' }
ff_parcelles_idpar <- function(
    token,
    idpar
){

  base_url='https://apidf-preprod.cerema.fr'
  donnees='ff'
  indicateur_1='parcelles'


  url=glue::glue(
    base_url,donnees,indicateur_1,idpar,'/',
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

  data <-
    data %>%
    dplyr::bind_rows()

  data

}

#' Propriétaires
#'
#' @param token token
#' @param ccodro Code(s) du droit réel ou particulier (il est possible de spécifier plusieurs valeurs et de séparer par une virgule) - exemple : ccodro=A,B - cf ccodro
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param fields Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.
#' @param gtoper Indicateur de personne physique ou morale - cf gtoper
#' @param idprocpte Identifiant de compte communal - cf idprocpte
#' @param locprop Localisation généralisée du propriétaire recevant la Taxe Foncière - cf locprop
#' @param ordering Which field to use when ordering the results.
#' @param typedroit Type de droit : propriétaire ou gestionnaire - cf typedroit
#' @param catpro3 Chaîne(s) de caractères contenue dans le code de catégorie de propriétaire (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : catpro3=P,F2,A2c - cf catpro3
#'
#' @return Retourne les droits de propriété issus des Fichiers Fonciers pour la commune demandée (paramètre code_insee obligatoire)
#' @export
#'
#' @examples
#' \dontrun{
#' ff_proprios(code_insee="59001",token=token)
#' }
ff_proprios <- function(
    token,
    ccodro=NULL,
    code_insee=NULL,
    fields=NULL,
    gtoper=NULL,
    idprocpte=NULL,
    locprop=NULL,
    ordering=NULL,
    typedroit=NULL,
    catpro3=NULL
){

  base_url='https://apidf-preprod.cerema.fr'
  donnees='ff'
  indicateur_1='proprios'


  url=glue::glue(
    base_url,donnees,indicateur_1,'/',
    .sep = "/"
  )

  headers <- c('Authorization' = paste("Bearer", token))

  return_data <- NULL                # MAJ LISTE INSEE

  for (code_insee_i in code_insee) { # MAJ LISTE INSEE


    print(code_insee_i)              # MAJ LISTE INSEE

  page <- 1
  all_data <- list()
  has_more_data <- TRUE

  while (has_more_data) {

    args <- list(
      ccodro=ccodro,
      code_insee=code_insee_i,   # MAJ LISTE INSEE
      fields=fields,
      gtoper=gtoper,
      idprocpte=idprocpte,
      locprop=locprop,
      ordering=ordering,
      typedroit=typedroit,
      catpro3=catpro3,
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
      # print(page)
    }

    # all_data

  }

  return_data <- dplyr::bind_rows(all_data,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data                                              # MAJ LISTE INSEE


}


#' Droit de propriété des Fichiers fonciers pour l'identifiant idprodroit demandé
#'
#' @param token token
#' @param idprodroit  A unique value identifying this proprio
#'
#' @return Retourne le droit de propriété des Fichiers fonciers pour l'identifiant idprodroit demandé
#' @export
#'
#' @examples
#' \dontrun{
#' ff_parcelles_idprodroit(idprodroit="59001+0000101",token=token)
#' }
ff_parcelles_idprodroit <- function(
    token,
    idprodroit
){

  base_url='https://apidf-preprod.cerema.fr'
  donnees='ff'
  indicateur_1='parcelles'


  url=glue::glue(
    base_url,donnees,indicateur_1,idprodroit,'/',
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

  data <-
    data %>%
    dplyr::bind_rows()

  data

}

#' TUP
#'
#' @inheritParams ff_geotups
#'
#' @return Retourne, en GeoJSON, les tup issues des Fichiers Fonciers pour la commune ou l'emprise demandée (paramètre code_insee ou in_bbox obligatoire)
#' @export
#'
#' @examples
#' \dontrun{
#' ff_tups(code_insee=59001,token=token)
#' }
ff_tups <- function(
    token,
    code_insee=NULL,
    contains_geom=NULL,
    typetup=NULL,
    fields=NULL,
    in_bbox=NULL,
    catpro3=NULL
){


  base_url='https://apidf-preprod.cerema.fr'
  donnees='ff'
  indicateur_1='tups'


  url=glue::glue(
    base_url,donnees,indicateur_1,'/',
    .sep = "/"
  )

  headers <- c('Authorization' = paste("Bearer", token))

  return_data <- NULL                # MAJ LISTE INSEE

  for (code_insee_i in code_insee) { # MAJ LISTE INSEE


    print(code_insee_i)              # MAJ LISTE INSEE

  page <- 1
  all_data <- list()
  has_more_data <- TRUE

  while (has_more_data) {

    args <- list(
      code_insee=code_insee_i,   # MAJ LISTE INSEE
      contains_geom=contains_geom,
      typetup=typetup,
      fields=fields,
      in_bbox=in_bbox,
      catpro3=catpro3,
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

  return_data <- dplyr::bind_rows(all_data,return_data)  # MAJ LISTE INSEE

  }                                                        # MAJ LISTE INSEE

  return_data                                              # MAJ LISTE INSEE


}


#' TUP des Fichiers fonciers pour l'identifiant idtup demandé
#'
#' @param token token
#' @param idtup  A unique value identifying this tup
#'
#' @return Retourne la tup des Fichiers fonciers pour l'identifiant idtup demandé
#' @export
#'
#' @examples
#' \dontrun{
#' ff_tups_idetup(idtup="uf027220129581",token=token)
#' }
ff_tups_idetup <- function(
    token,
    idtup
){

  base_url='https://apidf-preprod.cerema.fr'
  donnees='ff'
  indicateur_1='tups'


  url=glue::glue(
    base_url,donnees,indicateur_1,idtup,'/',
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

  data <-
    data %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(idpar_l=paste(idpar_l,collapse = ",")) %>%
    head(1)

  data

}
