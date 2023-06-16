#' Générer des graphiques dynamiques
#'
#' @description
#' Génère un graphique plotly pour l'ensemble des données du package.
#'
#'
#' @param data Les données d'entrées
#' @param x une variable en abscisse (catégorielle)
#' @param y une variable en ordonnée (numérique ou catégorielle)
#' @param couleur une variable pour distinguer par couleur (catégorielle)
#' @param titre un titre
#' @param titre_x un titre pour l'axe des x
#' @param titre_y un titre pour l'axe des y
#'
#' @return Retourne un graphique plotly avec les paramètres demandés
#' @export
#'
#' @examples
#'
#' cartofriches_geofriches(code_insee = 59350) %>%
#'  graph(
#' x = site_statut, # un champ catégoriel
#' y = site_type,   # un champ catégoriel
#' couleur = site_statut,
#' titre = "Mon titre",
#' titre_x = "Mon axe des X",
#' titre_y = "Mon axe des y"
#' )
#'
#' cartofriches_geofriches(code_insee = 59350) %>%
#'  graph(
#' x = site_statut, # un champ catégoriel
#' y = unite_fonciere_surface, # un champ numérique
#' titre = "",
#' titre_x = "",
#' titre_y = ""
#' )
#'
#'
graph <- function(
    data,
    x,
    y,
    couleur=NULL,
    titre=NULL,
    titre_x=NULL,
    titre_y=NULL
){



  data_avant_agregation <-
    data %>%
    sf::st_drop_geometry()


  data_avant_agregation <-
    data_avant_agregation %>%
    dplyr::mutate(color = {{ couleur }}) %>%
    # on fait en 2 temps le mutate sinon ne veut pas
    dplyr::mutate(color = if (is.null(.$color)){"Blue"} else {.$color}) %>%
    dplyr::rename(
      x={{ x }},
      y={{ y }}
    )



  if (is.numeric(data_avant_agregation$y)) {

    data_agregee <-
      data_avant_agregation %>%
      dplyr::group_by(x,color) %>%
      dplyr::summarise(y=sum(y,na.rm = T))

  } else {

    data_agregee <-
      data_avant_agregation %>%
      dplyr::group_by(x,color) %>%
      dplyr::tally(name = 'y')
  }

  data_agregee %>%
    plotly::plot_ly(
      x=~x,
      y=~y,
      color=~color,
      type = "bar"
    ) %>%
    plotly::layout(
      title = paste0(titre),
      xaxis = list(title = titre_x),
      yaxis = list(title = titre_y),
      barmode = 'stack'
    ) %>%
    plotly::config(displaylogo = FALSE)
  # print()

}


#' Générer des cartes dynamiques
#'
#' @description
#' Génère une cartographie pour l'ensemble des données géographiques du package.
#'
#'
#' @param .data Les données d'entrées
#' @param couleur Variable catégorielle pour colorer la carte
#' @param ... AUtres variables de la fonction addPolygons()
#'
#' @return Une carte leaflet avec une analyse thématique
#' @export
#'
#' @examples
#' cartofriches_geofriches(code_insee = 59350) %>% carte(couleur = 'site_statut')

carte <- function(.data,couleur,...){


  data <- .data
  # dplyr::mutate(
  #   dplyr::across(
  #      .cols = dplyr::where(is.character),
  #      .fns   = ~{stringr::str_wrap(., width = 20)}
  #   )
  # )


  factpal <- leaflet::colorFactor(topo.colors(5), data[[couleur]])


  leaflet::leaflet() %>%
    leaflet::addProviderTiles(leaflet::providers$CartoDB.Positron, group="Positron") %>%
    leaflet::addProviderTiles(leaflet::providers$Stamen.Toner, group = "Noir et blanc") %>%
    leaflet::addProviderTiles(leaflet::providers$OpenStreetMap.France, group = "OpenStreetMap",layerId = "OpenStreetMap" ) %>%
    leaflet::addWMSTiles(baseUrl = "https://wxs.ign.fr/essentiels/geoportail/r/wms",
                         layers = "LIMITES_ADMINISTRATIVES_EXPRESS.LATEST",
                         group="Limites administratives",
                         options = leaflet::WMSTileOptions(format = "image/png", transparent = TRUE,opacity=0.5),
                         attribution = "IGN") %>%
    leaflet::addWMSTiles(baseUrl = "https://wxs.ign.fr/essentiels/geoportail/r/wms",
                         layers = "CADASTRALPARCELS.PARCELLAIRE_EXPRESS",
                         group="Cadastre",
                         options = leaflet::WMSTileOptions(format = "image/png", transparent = TRUE),
                         attribution = "IGN") %>%
    leaflet::addWMSTiles(baseUrl = "https://wxs-gpu.mongeoportail.ign.fr/externe/vkd1evhid6jdj5h4hkhyzjto/wms/v",
                         layers = "zone_secteur",
                         options = leaflet::WMSTileOptions(format = "image/png", transparent = TRUE,opacity=0.3),
                         group = "Documents d'urbanisme") %>%
    leaflet::addWMSTiles(baseUrl = "https://wxs.ign.fr/essentiels/geoportail/r/wms",
                         layers = "ORTHOIMAGERY.ORTHOPHOTOS",
                         group="Photos aeriennes",
                         options = leaflet::WMSTileOptions(format = "image/png", transparent = TRUE),
                         attribution = "IGN") %>%
    leaflet::addWMSTiles(baseUrl = "https://wxs.ign.fr/essentiels/geoportail/r/wms",
                         layers = "GEOGRAPHICALGRIDSYSTEMS.PLANIGNV2",
                         group="Plan IGN",
                         options = leaflet::WMSTileOptions(format = "image/png", transparent = TRUE),
                         attribution = "IGN") %>%
    leaflet::addWMSTiles(baseUrl = "https://www.geo2france.fr/geoserver/geo2france/ows",
                         layers = "scan25",
                         group="Scan 25",
                         options = leaflet::WMSTileOptions(format = "image/png", transparent = TRUE),
                         attribution = "IGN") %>%
    leaflet::addLayersControl(
      baseGroups = c(
        "Positron","Photos aeriennes","Plan IGN","Scan 25",
        "OpenStreetMap",
        "Noir et blanc"),
      overlayGroups = c("Limites administratives","Cadastre","Donnees","Documents d'urbanisme"),
      options = leaflet::layersControlOptions(collapsed = T,
                                              autoZIndex = F)) %>%
    leaflet::hideGroup(c("Limites administratives","Cadastre","Documents d'urbanisme")) %>%
    leaflet::addMiniMap(toggleDisplay = T, minimized = TRUE)  %>%
    leaflet.extras::addFullscreenControl() %>%
    leaflet.extras::addResetMapButton() %>%
    # leaflet.extras::addSearchOSM(options = leaflet.extras::searchOptions(autoCollapse = TRUE, minLength = 2,
    #                                      textPlaceholder="Recherche via OpenStreetMap",position = "topright")) %>%
    leaflet::addMeasure(
      position = "topright",
      primaryLengthUnit = "meters",
      secondaryLengthUnit = "kilometers",
      primaryAreaUnit = "hectares",
      secondaryAreaUnit = "sqmeters",
      decPoint = ",",
      thousandsSep = " ",
      activeColor = "#3D535D",
      completedColor = "#7D4479",
      localization = "fr"
    ) %>%
    # barre d'échelle
    leaflet::addScaleBar('bottomleft') %>%
    leaflet::addPolygons(
      data=data,
      group='Donnees',
      ...,
      color = ~factpal(data[[couleur]]),
      popup = leafpop::popupTable(
        data %>% sf::st_drop_geometry(),
        feature.id = F,
        row.numbers = F
      )

    )

}


