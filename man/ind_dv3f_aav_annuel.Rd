% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ind_dv3f.R
\name{ind_dv3f_aav_annuel}
\alias{ind_dv3f_aav_annuel}
\title{Indicateurs annuels DV3F à l'échelle AAV}
\usage{
ind_dv3f_aav_annuel(
  code_aav,
  annee = NULL,
  ordering = NULL,
  page = NULL,
  page_size = NULL
)
}
\arguments{
\item{code_aav}{Code AAV de l'aire INSEE}

\item{annee}{Année de mutation}

\item{ordering}{Which field to use when ordering the results.}

\item{page}{A page number within the paginated result set.}

\item{page_size}{Number of results to return per page.}
}
\value{
Renvoie les indicateurs annuels DV3F à l'échelle AAV
}
\description{
Indicateurs annuels DV3F à l'échelle AAV
}
\examples{
ind_dv3f_aav_annuel('004')
}
