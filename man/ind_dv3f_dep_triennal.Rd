% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ind_dv3f.R
\name{ind_dv3f_dep_triennal}
\alias{ind_dv3f_dep_triennal}
\title{Indicateurs triennaux DV3F à l'échelle du département}
\usage{
ind_dv3f_dep_triennal(
  coddep,
  annee = NULL,
  ordering = NULL,
  page = NULL,
  page_size = NULL
)
}
\arguments{
\item{coddep}{Code INSEE du département (possibilité de passer un vecteur de code insee sans limite maximum)}

\item{annee}{Année de mutation centrale de la période triennale (par exemple, 2011 pour la période 2010-2012)}

\item{ordering}{Which field to use when ordering the results.}

\item{page}{A page number within the paginated result set.}

\item{page_size}{Number of results to return per page.}
}
\value{
Renvoie les indicateurs triennaux DV3F à l'échelle du département
}
\description{
Indicateurs triennaux DV3F à l'échelle du département
}
\examples{
ind_dv3f_dep_triennal('59')
}
