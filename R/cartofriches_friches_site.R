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
