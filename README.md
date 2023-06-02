
<!-- README.md is generated from README.Rmd. Please edit that file -->

> 🚧 Warning
>
> Il s’agit d’une version de développement

> 📘 Info
>
> Les wrappers d’API sont des outils qui facilitent l’utilisation des
> fonctionnalités offertes par une interface de programmation
> d’applications (API). Ils simplifient la communication entre une
> application et une API en gérant les détails techniques et en offrant
> une interface plus conviviale. Les wrappers d’API permettent aux
> développeurs de se concentrer sur la logique de leur application
> plutôt que sur les aspects techniques de l’intégration avec l’API. Ils
> accélèrent le développement et améliorent la productivité en réduisant
> la quantité de code nécessaire.

Grâce à `{r.apifoncier}` vous pouvez accéder aux données disponibles par
l’[API données foncières du
cerema](https://apidf-preprod.cerema.fr/swagger/).

# Installation

You can install the development version of r.apifoncier from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("rcadot/r.apifoncier")
```

# Indicateur de consommations d’espace communes

## Exemple

En indiquant le code INSEE d’une commune au format `numeric` ou
`character`, on obtient un dataframe des consommations.

``` r
library(r.apifoncier)
ind_conso_espace_communes(59001)
#>    annee idcom  idcomtxt naf_arti conso_act conso_hab conso_mix conso_inc
#> 1   2009 59001 Abancourt    13286         0     13286         0         0
#> 2   2010 59001 Abancourt    13287         0     13287         0         0
#> 3   2011 59001 Abancourt        0         0         0         0         0
#> 4   2012 59001 Abancourt        0         0         0         0         0
#> 5   2013 59001 Abancourt        0         0         0         0         0
#> 6   2014 59001 Abancourt        0         0         0         0         0
#> 7   2015 59001 Abancourt     3733         0      3733         0         0
#> 8   2016 59001 Abancourt        0         0         0         0         0
#> 9   2017 59001 Abancourt        0         0         0         0         0
#> 10  2018 59001 Abancourt        0         0         0         0         0
#> 11  2019 59001 Abancourt        0         0         0         0         0
#> 12  2020 59001 Abancourt        0         0         0         0         0
```
