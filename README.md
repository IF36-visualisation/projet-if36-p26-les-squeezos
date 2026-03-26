---
title: Proposition de projet IF36
author: Adeline VERCOUTRE, Antoine NERET, Karl MEHANNA, Juliette SIEBERING
date: 26 Mars 2026
output:
  prettydoc::html_pretty:
    theme: cayman
---

# Données

Notre jeu de données regroupe une grande partie des jeux publiés par Steam, avec de nombreuses informations comme le prix, le système d’exploitation, la date de publication, etc… (voir tableau ci-dessous).
Il provient du site Kaggle, nous avons choisi ce jeu en particulier pour sa richesse (89618 observations et 47 variables) et pour sa récence (les données datent de mars 2025).
Étant tous des joueurs dans le groupe, cela nous paraît intéressant de voir les données concernant nos jeux préférés.

## Tableau contenant les noms des variables, leur format type et sous-catégorie/sous-groupe

| Catégorie - sous-groupe          | Variable                 | Format | Type     |
|:--------------------------------:|:------------------------:|:------:|:--------:|
|                                  | appid                    | int    | discrète |
|                                  | name                     | chr    | nominale |
|                                  | release_date             | date   | discrète |
|                                  | required_age             | int    | discrète |
|                                  | price                    | num    | continue |
|                                  | dlc_count                | int    | discrète |
|                                  | detailed_description     | chr    | nominale |
|                                  | about_the_game           | chr    | nominale |
|                                  | short_description        | chr    | nominale |
|                                  | reviews                  | chr    | nominale |
|                                  | header_image             | chr    | nominale |
|                                  | website                  | chr    | nominale |
|                                  | support_url              | chr    | nominale |
|                                  | support_email            | chr    | nominale |
| Système d'exploitation           | windows                  | logi   | discrète |
| Système d'exploitation           | mac                      | logi   | discrète |
| Système d'exploitation           | linux                    | logi   | discrète |
|                                  | metacritic_score         | int    | discrète |
|                                  | metacritic_url           | chr    | nominale |
|                                  | achievements             | int    | discrète |
|                                  | recommendations          | int    | discrète |
|                                  | notes                    | chr    | nominale |
|                                  | supported_languages      | chr    | nominale |
|                                  | full_audio_languages     | chr    | nominale |
|                                  | packages                 | chr    | nominale |
|                                  | developers               | chr    | nominale |
|                                  | publishers               | chr    | nominale |
|                                  | categories               | chr    | nominale |
|                                  | genres                   | chr    | nominale |
|                                  | screenshots              | chr    | nominale |
|                                  | movies                   | chr    | nominale |
|                                  | user_score               | int    | discrète |
|                                  | score_rank               | int    | discrète |
| Nombre de reviews                | positive                 | int    | discrète |
| Nombre de reviews                | negative                 | int    | discrète |
|                                  | estimated_owners         | chr    | nominale |
| Moyenne temps de jeu             | average_playtime_forever | int    | discrète |
| Moyenne temps de jeu             | average_playtime_2weeks  | int    | discrète |
| Médiane temps de jeu             | median_playtime_forever  | int    | discrète |
| Médiane temps de jeu             | median_playtime_2weeks   | int    | discrète |
|                                  | discount                 | int    | discrète |
|                                  | peak_ccu                 | int    | discrète |
|                                  | tags                     | chr    | nominale |
| Pourcentage de reviews positives | pct_pos_total            | int    | discrète |
| Nombre de reviews                | num_reviews_total        | int    | discrète |
| Pourcentage de reviews positives | pct_pos_recent           | int    | discrète |
| Nombre de reviews                | num_reviews_recent       | int    | discrète |

# Plan d'analyse

## Questions

Nos interrogations sont les suivantes :

- Relation : Est-ce que le prix influence les ventes ? (“price” et “estimated_owners”)
- Relation : Quelle est l’influence du nombre de langues supportées sur le nombre de ventes ? (“estimated_owners” et “supported_languages”)
- Relation : Est-ce que les jeux payants sont mieux notés / Est-ce que le prix influence la qualité ? (“price” et “pct_pos_total”) 
- Comparaison : Quels sont les "meilleurs" éditeurs ? (“pct_pos_total” et “publisher”)
- Comparaison : Quel genre de jeu retient le plus l'attention des joueurs (voir avec le temps de jeu moyen) ? (“categories”/”genres” et “average_playtime_forever”, “mediam_playtime_forever”)
- Comparaison : Est-ce qu'on passe plus de temps sur des jeux gratuits ou payants ? (Temps passé sur des jeux gratuits et jeux payants (“average_playtime_forever” et “price”))
- Comparaison : Y a-t-il des systèmes d’exploitation plus utilisés que d’autres ? (“Windows”, “Mac” et “Linux”)
- Evolution : Y a-t-il une amélioration de la qualité des jeux au fil du temps ? (“release_date”, “pct_pos_total”)

## Informations obtenues

Les principales informations que nous aimerions tirer sont l’influence des différents facteurs sur les ventes et la qualité (prix, langues, systèmes d’exploitation).

## Problèmes potentiels : 

- Les variables “categories”, “genres”, “tags”, “supported_language”, “full_audio_language” sont des listes/dictionnaires de chaînes de caractères perçus par R comme des chaînes de caractères. Il faudra donc penser à les convertir avant de pouvoir les exploiter.
- Certaines variables n’ont pas beaucoup d’observations (“user_score” et “score_rank”), il pourrait donc être compliqué de les exploiter. De plus, le peu d’observations enregistrées semblent incohérentes (pour “score_rank”, seulement quelques 98, 99 et 100, puis que des NA)
- La variable “estimated_owners” est de format “char” et devra être converti en valeur numérique (int)

