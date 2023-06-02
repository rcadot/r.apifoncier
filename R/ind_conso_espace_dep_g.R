#' Consommation d'espace par département (Graphique)
#'
#' @param coddep Code INSEE du département
#' @param annee_max Année jusqu'à laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param annee_min Année à partir de laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param ordering Which field to use when ordering the results.
#' @param page A page number within the paginated result set.
#' @param page_size Number of results to return per page.
#' @param affichage 'total' ou par 'type'
#' @param hectare valeur de la consommation en hectares
#' @param legende Affichage de la légende True/False
#'
#' @return Renvoie les indicateurs de consommation d'espace pour la période comprise entre annee_min et annee_max, bornes incluses, à l'échelle départementale
#' @export
#'
#' @examples
#' ind_conso_espace_dep_g(59)
ind_conso_espace_dep_g <- function(
    coddep,
    annee_max=NULL,
    annee_min=NULL,
    ordering=NULL,
    page=NULL,
    page_size=NULL,
    legende=TRUE,
    affichage='type',
    hectare=TRUE
) {

  # if (!is.numeric(code_insee)) {stop("x should be numeric")}

  args <- list(
    coddep=coddep,
    annee_max=annee_max,
    annee_min=annee_min,
    ordering=ordering,
    page=page,
    page_size=page_size)

  base_url='https://apidf-preprod.cerema.fr'
  donnees='indicateurs'
  indicateur_1='conso_espace'
  indicateur_2='departements'

  coddep <- stringr::str_pad(coddep,width = 2,pad = "0",side = "left")

  url=glue::glue(
    base_url,donnees,indicateur_1,indicateur_2,coddep,'/',
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
        "Activite"=conso_act,
        "Habitat"=conso_hab,
        "Mixte"=conso_mix,
        "Inconnu"=conso_inc
      ) %>%
      tidyr::pivot_longer(
        cols = c(4:7),
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
      hovertemplate = paste('%{y:.2f}',ifelse(hectare,'hectares','m2')),
      type="bar"
    ) %>%
    plotly::layout(title="Consommation d'espace",
                   xaxis = list(title = '',showticklabels=TRUE),
                   yaxis = list(title = ifelse(hectare,'hectares','metres carre')),
                   barmode = 'stack',
                   hovermode = "x unified",
                   # hovermode="color",
                   showlegend=legende) %>%
    plotly::config(displaylogo = FALSE)



}
