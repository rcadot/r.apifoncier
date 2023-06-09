% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ind_conso_espace.R
\name{ind_conso_espace_communes}
\alias{ind_conso_espace_communes}
\title{Consommation d'espace par commune}
\usage{
ind_conso_espace_communes(
  code_insee,
  annee_max = NULL,
  annee_min = NULL,
  ordering = NULL,
  page = NULL,
  page_size = NULL
)
}
\arguments{
\item{code_insee}{Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)}

\item{annee_max}{Année jusqu'à laquelle renvoyer les indicateurs d'artificialisation (incluse)}

\item{annee_min}{Année à partir de laquelle renvoyer les indicateurs d'artificialisation (incluse)}

\item{ordering}{Which field to use when ordering the results.}

\item{page}{A page number within the paginated result set.}

\item{page_size}{Number of results to return per page.}
}
\value{
Renvoie les indicateurs de consommation d'espace pour la période comprise entre annee_min et annee_max, bornes incluses, à l'échelle communale
}
\description{
Consommation d'espace par commune
}
\examples{
ind_conso_espace_communes(59001)
}
