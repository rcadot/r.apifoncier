
<!-- README.md is generated from README.Rmd. Please edit that file -->

   

`r.apifoncier` est un package `R` qui propose une boîte à outils pour
interagir plus facilement avec [l’API Données foncières du
Cerema](https://apidf-preprod.cerema.fr/).

Il permet d’interroger facilement les différentes bases de données
foncières produites par le Cerema et la DGALN directement via `R`

> *Certains flux de l’API sont à accès restreint et nécessitent
> d’appartenir à une structure publique bénéficiaire des données
> foncières. Rendez-vous sur
> [ConsultDF](https://consultdf.cerema.fr/consultdf/services/apidf) pour
> obtenir un jeton d’accès.*

# Installation

Vous pouvez installer `r.apifoncier` depuis
[GitHub](https://github.com/) avec le code suivant :

``` r
# install.packages("devtools") # à décommenter si vous n'avez pas {devtools} d'installé
devtools::install_github("rcadot/r.apifoncier")
```

# Usage

## Accès ouvert

Pour démarrer, il suffit de charger le package et de récupérer les
données dans un dataframe ou un sf via la fonction adéquate :

``` r
## Récupérer des données de consommation d'espace sur une commune
library(r.apifoncier)

df <- conso_enaf.communes(code_insee='59350')
```

``` r
## Récupérer des données de prix sur une commune
df <- prix.communes(code_insee='59350')
```

``` r
## Récupérer des transactions issues de DVF+ sur une commune
df <- dvf.mutations(code_insee='59350')

# avec les geometries
gdf <- dvf.geomutations(in_bbox=c(3, 50, 3.01, 50.01))
```

``` r
## Récupérer les friches
# sur un département
df <- cartofriches.friches(coddep='59')

# sur une commune avec les contours géométriques
gdf <- cartofriches.geofriches(code_insee=c("59350", "59009"))
```

## Accès restreint

Pour les données Fichiers fonciers et DV3F, il faut disposer d’un
**jeton d’accès API** pour s’authentifier et récupérer les données
correspondantes. Le jeton est fourni au module via la fonction
`configure()`

``` r
API_TOKEN <- "<MON_TOKEN_API>"

## Configuration préalable du jeton API
configure(TOKEN=API_TOKEN)
```

Une fois, le jeton configuré, les fonctions accessibles via le token
sont désormais utilisables.

``` r
## Récupérer les parcelles
# sur une commune
df <- ff.parcelles(code_insee='59646')

# sur une commune avec les contours géométriques
gdf <- ff.geoparcelles(in_bbox=c(3, 50, 3.01, 50.01))
```

``` r
# Récupérer les mutations de DV3F

# sur une commune
df <- dv3f.mutations(code_insee='59646')

# sur une commune avec les contours géométriques
gdf <- dv3f.geomutations(in_bbox=[3, 50, 3.01, 50.01])
```

# Ressources

Pour retrouver toutes les informations sur les données foncières :
[datafoncier.cerema.fr](https://datafoncier.cerema.fr/)

Dictionnaire et documentation sur toutes les variables :
[doc-datafoncier.cerema.fr](doc-datafoncier.cerema.fr)
