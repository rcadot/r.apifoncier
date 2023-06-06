
- <a href="#installation" id="toc-installation">Installation</a>
- <a href="#fonctions-et-données-disponibles"
  id="toc-fonctions-et-données-disponibles">Fonctions et données
  disponibles</a>
  - <a href="#accès-libre" id="toc-accès-libre">Accès libre</a>
  - <a href="#accès-restreint" id="toc-accès-restreint">Accès restreint</a>

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

# Fonctions et données disponibles

## Accès libre

### Indicateurs de consommation d’espace (accès libre)

Retrouvez les

### Indicateurs de prix (accès libre)

La base de données DV3F facilite l’observation des marchés et permet de
produire des indicateurs de prix et de volumes de transactions à
différentes échelles géographiques afin d’apprécier et d’étudier les
marchés fonciers et immobiliers d’un territoire.

Les indicateurs de prix sont disponibles annuellement et de manière
triennale à plusieurs échelles :

- Régions ;
- Départements ;
- Aires d’attractivités des villes ;
- EPCI ;
- Communes.

La période proposée court de 2010 à 2022 avec une exhaustivité moindre
sur les derniers semestres.

Les indicateurs proposés dans la version 2023-1 de DV3F utilisent les
périmètres administratifs au 1er janvier 2022.

Retrouvez l’ensemble de la documentation en suivant [ce
lien](https://doc-datafoncier.cerema.fr/dv3f/tuto/indicateurs_agreges).

Retrouvez un article dédié sur le site de `vignette('DVF-')`.

### Cartofriches (accès libre)

Les travaux effectués par le Cerema pour constituer un premier
inventaire national ont permis de montrer la possibilité de
pré-identifier une partie des friches, mais ils montrent aussi les
limites de l’approche nationale. En effet, sur un sujet aussi complexe
que les friches, les bases nationales manquent d’exhaustivité et de mise
à jour. La comparaison de la base nationale avec des inventaires locaux
met en évidence l’absence de définition réglementaire d’une friche, et
le peu de mise à jour de certaines informations nationales.

Ainsi, si une base nationale permet d’avoir des informations homogènes
sur le territoire métropolitain, une base de données consolidées
nécessite la contribution large de nombreux acteurs proches du terrain,
et l’agglomération de données issues d’observatoires locaux, en
partageant un minimum de concepts.

[Plus d’informations sur
cartofriches](https://artificialisation.developpement-durable.gouv.fr/cartofriches/donnees-utilisees)

### DVF+ (accès libre)

La DGALN et le Cerema propose “DVF+ open-data”, qui permet d’accéder
librement à cette même donnée sous la forme d’une base de données
géolocalisée aisément exploitable pour l’observation des marchés
fonciers et immobiliers.

La structuration de la donnée DVF proposée s’appuie sur le modèle de
données partagé dit “DVF+”, issu des travaux menés à l’initiative du
groupe national DVF et qui existe depuis 2013. Ce modèle, développé pour
faciliter les analyses, fournit notamment une table des mutations dans
laquelle chaque ligne correspond aux informations et à la localisation
d’une transaction.

La géolocalisation s’appuie sur les différents millésimes du Plan
cadastral informatisé également disponibles en open-data sur
data.gouv.fr.

Chacune des variables du modèle DVF+ est calculée uniquement à partir
des données brutes de DVF. Les variables calculées s’appliquent sur
l’ensemble du territoire et relèvent d’une méthodologie partagée. Il n’y
a pas de données exogènes à ce stade hormis les données de
géolocalisation issue du PCI Vecteur.

A noter que le modèle DVF+ constitue également le socle pour la
constitution de la base de données DV3F.

[Pour en savoir plus sur
DVF+](http://doc-datafoncier.cerema.fr/dv3f/tuto/objectif_tutoriel)

## Accès restreint

### DV3F (accès restreint)

### Fichiers fonciers (accès restreint)
