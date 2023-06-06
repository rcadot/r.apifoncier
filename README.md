
- <a href="#installation" id="toc-installation">Installation</a>
- <a href="#indicateurs-de-consommation-despace-accès-libre"
  id="toc-indicateurs-de-consommation-despace-accès-libre">Indicateurs de
  consommation d’espace (accès libre)</a>
- <a href="#indicateurs-de-prix-accès-libre"
  id="toc-indicateurs-de-prix-accès-libre">Indicateurs de prix (accès
  libre)</a>
- <a href="#cartofriches-accès-libre"
  id="toc-cartofriches-accès-libre">Cartofriches (accès libre)</a>
- <a href="#dvf-accès-libre" id="toc-dvf-accès-libre">DVF+ (accès
  libre)</a>
- <a href="#dv3f-accès-restreint" id="toc-dv3f-accès-restreint">DV3F
  (accès restreint)</a>
- <a href="#fichiers-fonciers-accès-restreint"
  id="toc-fichiers-fonciers-accès-restreint">Fichiers fonciers (accès
  restreint)</a>

<!-- README.md is generated from README.Rmd. Please edit that file -->

> 🚧 Avertissement
>
> Il s’agit d’une version de développement. Des modifications sur les
> fonctions peuvent intervenir.

> 📘
>
> Ce service permet l’interrogation des principales informations issues
> des différentes bases de données foncières produites par le Cerema et
> la DGALN. Une partie des données est interrogeable uniquement en tant
> que bénéficiaire des données foncières. Pour retrouver toutes les
> informations sur les données foncières :
> [datafoncier.cerema.fr](datafoncier.cerema.fr) Dictionnaire et
> documentation sur toutes les variables
> :[doc-datafoncier.cerema.fr](doc-datafoncier.cerema.fr)

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

Vous pouvez installer `{r.apifoncier}` depuis
[GitHub](https://github.com/) avec le code suivant :

``` r
# install.packages("devtools")
devtools::install_github("rcadot/r.apifoncier")
```

``` r
library(r.apifoncier)
```

# Indicateurs de consommation d’espace (accès libre)

# Indicateurs de prix (accès libre)

Les indicateurs de prix sont disponibles annuellement et de manière
triennale à plusieurs échelles :

- Régions ;
- Départements ;
- Aires d’attractivités des villes ;
- EPCI ;
- Communes.

``` r
ind_dv3f_com_annuel('59350') %>% 
  dplyr::select(1:10) # Le résultat contient 617 colonnes
#>    annee codgeo libgeo nbtrans_cod1 valeurfonc_sum_cod1 nbtrans_cod2
#> 1   2010  59350  Lille         5120           837659942           57
#> 2   2011  59350  Lille         4474           882766180           52
#> 3   2012  59350  Lille         4200           813426374           78
#> 4   2013  59350  Lille         3971           781613569           45
#> 5   2014  59350  Lille         3931           804964493           40
#> 6   2015  59350  Lille         4472           913893573           36
#> 7   2016  59350  Lille         4708          1016164793           43
#> 8   2017  59350  Lille         5387          1315158597           49
#> 9   2018  59350  Lille         5587          1533348525           50
#> 10  2019  59350  Lille         5914          1316236006           45
#> 11  2020  59350  Lille         5115          1338281971           52
#> 12  2021  59350  Lille         5638          1368565071           74
#> 13  2022  59350  Lille         5188          1793537471           44
#>    valeurfonc_sum_cod2 nbtrans_cod11 valeurfonc_sum_cod11 nbtrans_cod111
#> 1             11280409          1018            191957219           1009
#> 2             12029527          1007            193464212           1001
#> 3             10470981           898            185220834            888
#> 4              9220512           900            176372788            891
#> 5              9204725           809            158841064            800
#> 6              5374163           950            190094699            939
#> 7             18337891          1074            218153085           1058
#> 8             21091314          1066            218596803           1045
#> 9              8863366           999            209565961            986
#> 10            21399434          1129            260309641           1125
#> 11            22967299          1068            266500635           1057
#> 12            18772045          1102            286547302           1092
#> 13            19906913          1030            281169115           1020
```

# Cartofriches (accès libre)

On peut accéder aux friches, soit par département, commune ou encore à
partir d’une emprise au format WGS84

``` r
cartofriches_friches(coddep = 59)
#> # A tibble: 1,429 × 15
#>    site_id site_nom site_type site_adresse site_statut comm_nom comm_insee dep  
#>    <chr>   <chr>    <chr>     <lgl>        <chr>       <chr>    <chr>      <chr>
#>  1 59002_… carrièr… inconnu   NA           friche pot… ABSCON   59002      59   
#>  2 59002_… Atelier… inconnu   NA           friche pot… ABSCON   59002      59   
#>  3 59005_… Distill… inconnu   NA           friche pot… ALLENNE… 59005      59   
#>  4 59007_… l'Air L… inconnu   NA           inconnu     ANHIERS  59007      59   
#>  5 59008_… Expanver inconnu   NA           friche pot… ANICHE   59008      59   
#>  6 59008_… Le Mont… inconnu   NA           friche pot… ANICHE   59008      59   
#>  7 59008_… SARL MI… inconnu   NA           friche pot… ANICHE   59008      59   
#>  8 59008_… Terril … inconnu   NA           friche pot… ANICHE   59008      59   
#>  9 59008_… Usine d… inconnu   NA           friche pot… ANICHE   59008      59   
#> 10 59008_… 59008_1… inconnu   NA           inconnu     ANICHE   59008      59   
#> # ℹ 1,419 more rows
#> # ℹ 7 more variables: proprio_personne <chr>, unite_fonciere_surface <dbl>,
#> #   unite_fonciere_refcad <chr>, source_nom <chr>, proprio_type_lib <list>,
#> #   source_nature <chr>, urba_zone_type <chr>
```

``` r
cartofriches_friches(code_insee = 59350)
#> # A tibble: 135 × 15
#>    site_id site_nom site_type site_adresse site_statut comm_nom comm_insee dep  
#>    <chr>   <chr>    <chr>     <lgl>        <chr>       <chr>    <chr>      <chr>
#>  1 59350_… Teintur… inconnu   NA           friche pot… LILLE    59350      59   
#>  2 59350_… WILVIA … inconnu   NA           friche pot… LILLE    59350      59   
#>  3 59350_… Atelier… inconnu   NA           friche pot… LILLE    59350      59   
#>  4 59350_… Station… inconnu   NA           friche pot… LILLE    59350      59   
#>  5 59350_… Assitan… inconnu   NA           friche pot… LILLE    59350      59   
#>  6 59350_… Constru… inconnu   NA           inconnu     LILLE    59350      59   
#>  7 59350_… Atelier… inconnu   NA           friche pot… LILLE    59350      59   
#>  8 59350_… Appel à… inconnu   NA           friche ave… LILLE    59350      59   
#>  9 59350_… Cie Eur… inconnu   NA           inconnu     LILLE    59350      59   
#> 10 59350_… Appel à… inconnu   NA           friche ave… LILLE    59350      59   
#> # ℹ 125 more rows
#> # ℹ 7 more variables: proprio_personne <chr>, unite_fonciere_surface <dbl>,
#> #   unite_fonciere_refcad <chr>, source_nom <chr>, proprio_type_lib <list>,
#> #   source_nature <chr>, urba_zone_type <chr>
```

``` r
cartofriches_friches(in_bbox = '2.827642,50.495958,3.32616,50.767734')
#> # A tibble: 744 × 15
#>    site_id site_nom site_type site_adresse site_statut comm_nom comm_insee dep  
#>    <chr>   <chr>    <chr>     <lgl>        <chr>       <chr>    <chr>      <chr>
#>  1 59005_… "Distil… inconnu   NA           friche pot… ALLENNE… 59005      59   
#>  2 59009_… "SA Ate… inconnu   NA           inconnu     VILLENE… 59009      59   
#>  3 59009_… "Appel … inconnu   NA           friche ave… VILLENE… 59009      59   
#>  4 59009_… "Carrel… inconnu   NA           friche pot… VILLENE… 59009      59   
#>  5 59009_… "Fabriq… inconnu   NA           friche pot… VILLENE… 59009      59   
#>  6 59009_… "Colle … inconnu   NA           friche pot… VILLENE… 59009      59   
#>  7 59009_… "Vernis… inconnu   NA           friche pot… VILLENE… 59009      59   
#>  8 59009_… "Tanner… inconnu   NA           friche pot… VILLENE… 59009      59   
#>  9 59009_… "Atelie… inconnu   NA           friche pot… VILLENE… 59009      59   
#> 10 59009_… "Usine … inconnu   NA           friche pot… VILLENE… 59009      59   
#> # ℹ 734 more rows
#> # ℹ 7 more variables: proprio_personne <chr>, unite_fonciere_surface <dbl>,
#> #   unite_fonciere_refcad <chr>, source_nom <chr>, proprio_type_lib <list>,
#> #   source_nature <chr>, urba_zone_type <chr>
```

On peut également accéder aux objets géographiques associés.

``` r
cartofriches_geofriches(code_insee = 59350) %>% 
  mapview::mapview()
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="50%" />

# DVF+ (accès libre)

``` r
dvf_opendata_geomutations(code_insee=59001) %>% 
  dplyr::select(geometry) %>% 
  mapview::mapview()
#> [1] "84 / 84"
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="50%" />

# DV3F (accès restreint)

# Fichiers fonciers (accès restreint)
