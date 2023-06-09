% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ind_dv3f.R
\name{ind_dv3f_reg_annuel}
\alias{ind_dv3f_reg_annuel}
\title{Indicateurs annuels DV3F à l'échelle de la région}
\usage{
ind_dv3f_reg_annuel(
  codreg,
  annee = NULL,
  ordering = NULL,
  page = NULL,
  page_size = NULL
)
}
\arguments{
\item{codreg}{Code INSEE de la région (possibilité de passer un vecteur de code insee sans limite maximum)}

\item{annee}{Année de mutation}

\item{ordering}{Which field to use when ordering the results.}

\item{page}{A page number within the paginated result set.}

\item{page_size}{Number of results to return per page.}
}
\value{
Renvoie les indicateurs annuels DV3F à l'échelle du département
}
\description{
Indicateurs annuels DV3F à l'échelle de la région
}
\examples{
ind_dv3f_reg_annuel('59')
}
