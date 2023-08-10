#' Retourne les indicateurs annuels de consommation d’espace communaux
#'
#' @param code_insee Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param annee_max Année jusqu'à laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param annee_min Année à partir de laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param ordering Champs à utiliser pour ordonner le résultat. Defaults to None.
#' @param ... pour futurs developpements
#'
#' @return Retourne les indicateurs annuels de consommation d’espace communaux
#' @export
#'
#' @examples
#'
#' conso_enaf.communes(code_insee="59350")
#' conso_enaf.communes(code_insee=c("59350", "62041"), annee_min="2015")

conso_enaf.communes <- function(code_insee,
                                annee_min=NULL,
                                annee_max=NULL,
                                ordering=NULL,
                                ...){
  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=paste0(get_param("BASE_URL"),"/indicateurs/conso_espace/communes/"),
    lon_lat=NULL,
    in_bbox=NULL,
    code_insee=code_insee,
    coddep=NULL,
    params= list(annee_max=annee_max,
                 annee_min=annee_min,
                 ordering=ordering,...)
    # token=NULL
  )

  get_dataframe(
    self = resultat,
    no_param_code = TRUE
  )
}



#' Retourne les indicateurs annuels de consommation d’espace departementaux
#'
#' @param coddep Code INSEE du département (possibilité de passer un vecteur de code insee sans limite maximum)
#' @param annee_max Année jusqu'à laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param annee_min Année à partir de laquelle renvoyer les indicateurs d'artificialisation (incluse)
#' @param ordering Champs à utiliser pour ordonner le résultat. Defaults to None.
#' @param ... pour futurs developpements
#'
#' @return Retourne les indicateurs annuels de consommation d’espace departementaux
#' @export
#'
#' @examples
#' conso_enaf.departements(coddep="59")
#' conso_enaf.departements(coddep=c("59", "62"), annee_max="2015")

conso_enaf.departements <- function(coddep,
                                    annee_min=NULL,
                                    annee_max=NULL,
                                    ordering=NULL,
                                    ...){
  resultat=list(
    use_token=FALSE,
    base_url=get_param("BASE_URL"),
    url=paste0(get_param("BASE_URL"),"/indicateurs/conso_espace/departements/"),
    lon_lat=NULL,
    in_bbox=NULL,
    code_insee=NULL,
    coddep=coddep,
    params= list(annee_max=annee_max,
                 annee_min=annee_min,
                 ordering=ordering,...)
  )

  get_dataframe(
    self = resultat,
    no_param_code = TRUE
  )
}
