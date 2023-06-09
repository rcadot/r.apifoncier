% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ff.R
\name{ff_locaux}
\alias{ff_locaux}
\title{Locaux}
\usage{
ff_locaux(
  token,
  code_insee = NULL,
  dteloc = NULL,
  fields = NULL,
  idpar = NULL,
  idprocpte = NULL,
  idsec = NULL,
  locprop = NULL,
  loghlls = NULL,
  ordering = NULL,
  proba_rprs = NULL,
  slocal_max = NULL,
  slocal_min = NULL,
  typeact = NULL,
  catpro3 = NULL
)
}
\arguments{
\item{token}{token}

\item{code_insee}{Code INSEE communal ou d'arrondissement municipal (possibilité de passer un vecteur de code insee sans limite maximum)}

\item{dteloc}{Type(s) de local (il est possible de spécifier plusieurs types et de séparer par une virgule) - exemple : dteloc=1,2 - cf dteloc}

\item{fields}{Retourne tous les champs associés si fields=all, sinon retourne uniquement une selection de champs.}

\item{idpar}{Identifiant de parcelle - cf idpar}

\item{idprocpte}{Identifiant de compte communal - cf idprocpte}

\item{idsec}{Identifiant de section cadastrale - cf idsec}

\item{locprop}{Localisation généralisée du propriétaire recevant la Taxe Foncière - cf locprop}

\item{loghlls}{Logement d’habitation de type logement social repéré par exonération - cf loghlls}

\item{ordering}{Which field to use when ordering the results.}

\item{proba_rprs}{Probabilité de résidence principale ou secondaire (il est possible de spécifier plusieurs types et de séparer par une virgule) - exemple : proba_rprs=AC,NO - cf proba_rprs}

\item{slocal_max}{Surface maximale des parties d'évaluation (m2) - cf slocal}

\item{slocal_min}{Surface minimale des parties d'évaluation (m2) - cf slocal}

\item{typeact}{Chaîne(s) de caractères contenue dans le classement du local selon le type d'activité (Code catégorie du local d’activité) (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : typeact=MAG,SPE3 - cf typeact}

\item{catpro3}{Chaîne(s) de caractères contenue dans le code de catégorie de propriétaire (il est possible de ne specifier que les premiers niveaux et de séparer par une virgule) - exemple : catpro3=P,F2,A2c - cf catpro3}
}
\value{
Retourne les locaux issus des Fichiers Fonciers pour la commune demandée (paramètre code_insee obligatoire)
}
\description{
Locaux
}
\examples{
\dontrun{
ff_locaux(code_insee='59001',token=token)
}
}
