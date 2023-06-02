#' Consommation d'espace par commune (Graphique)
#'
#' @param code_insee Code INSEE de la commune
#' @param annee_max Année jusqu'à laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param annee_min Année à partir de laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#' @param legende Afficahge de la légende True/False
#' @param affichage 'total' ou par 'type'
#' @param hectare valeur de la consommation en hectares
#'
#' @return Renvoie un graphique au format plotly des indicateurs de consommation d'espace pour la période comprise entre annee_min et annee_max, bornes incluses, à l'échelle communale
#' @export
#'
#' @examples
#' ind_conso_espace_communes_g(59350)
#' ind_conso_espace_communes_g(59001,hectare = FALSE,affichage = 'total',legende = FALSE)
ind_conso_espace_communes_g <- function(
    code_insee,
    annee_max=NULL,
    annee_min=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL,
    affichage='type',
    legende=TRUE,
    hectare=TRUE
) {

  args <- list(
    coddep=code_insee,
    annee_max=annee_max,
    annee_min=annee_min,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='conso_espace'
  indicateur_2='communes'

  code_insee <- stringr::str_pad(code_insee,width = 5,pad = "0",side = "left")

  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,code_insee,'/',
    .sep = "/"
  )

  # Chek for internet
  # check_internet()

  res <- httr::GET(url, query = purrr::compact(args))

  # Check the result
  # check_status(res)

  res <- jsonlite::fromJSON(rawToChar(res$content))$results


  if (affichage=='total'){

    prep_graph <-
      res %>%
      dplyr::rename(conso=naf_arti) %>%
      dplyr::mutate(type='total')


  } else if (affichage=='type'){

    prep_graph <-
      res %>%
      dplyr::rename(
        "Activité"=conso_act,
        "Habitat"=conso_hab,
        "Mixte"=conso_mix,
        "Inconnu"=conso_inc
      ) %>%
      tidyr::pivot_longer(
        cols = c(5:8),
        names_to = "type",
        values_to = "conso"
      )

  }

  if (hectare) {

    prep_graph <-
      prep_graph %>%
      dplyr::mutate(conso=conso/10000)
  }

  prep_graph %>%
    plotly::plot_ly(
      x=~annee,
      y=~conso,
      color=~type,
      type="bar"
    ) %>%
    plotly::layout(title="Consommation d'espace",
                   xaxis = list(title = '',showticklabels=TRUE),
                   yaxis = list(title = ifelse(hectare,'hectares','mètres carrés')),
                   barmode = 'stack',
                   hovermode="color",
                   showlegend=legende) %>%
    plotly::config(displaylogo = FALSE)


}
