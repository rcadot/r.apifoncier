#' Graph
#'
#' @description
#' Génère un graphique plotly pour l'ensemble des données du package.
#'
#'
#' @param data Mes données d'entrées
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
