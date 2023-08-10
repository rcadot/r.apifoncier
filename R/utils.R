get_geodataframe <- function(self
                             # ,PROXY = PROXY,TOKEN = TOKEN
                             ) {

  if (!is.null(self$lon_lat)) {
    lon <- self$lon_lat[1]
    lat <- self$lon_lat[2]
    lon_min <- lon - 0.01
    lon_max <- lon + 0.01
    lat_min <- lat - 0.01
    lat_max <- lat + 0.01
    in_bbox <- sprintf("in_bbox=%f,%f,%f,%f", lon_min, lat_min, lon_max, lat_max)
    url <- sprintf("%s?%s&contains_geom={\"type\": \"Point\", \"coordinates\":[%f, %f]}", self$url, in_bbox, lon, lat)
    return(get_all_geodata(url, self$params, use_token = self$use_token))#,PROXY = PROXY,TOKEN = TOKEN))
  }
  if (!is.null(self$in_bbox)) {
    url <- sprintf("%s?in_bbox=%s&page_size=500", self$url, paste(self$in_bbox, collapse = ","))
    return(get_all_geodata(url, self$params, use_token = self$use_token))#,PROXY = PROXY,TOKEN = TOKEN))
  }
  if (!is.null(self$code_insee)) {
    datas <- list()
    for (code in self$code_insee) {
      url <- sprintf("%s?code_insee=%s&page_size=500", self$url, code)
      data <- get_all_geodata(url, self$params, use_token = self$use_token)#,PROXY = PROXY,TOKEN = TOKEN)
      datas <- append(datas, list(data))
    }
  }
  if (!is.null(self$coddep)) {
    datas <- list()
    for (code in self$coddep) {
      url <- sprintf("%s?coddep=%s&page_size=500", self$url, code)
      data <- get_all_geodata(url, self$params, use_token = self$use_token)#,PROXY = PROXY,TOKEN = TOKEN)
      datas <- append(datas, list(data))
    }
  }
  # browser()
  if (length(datas) == 1) {
    #on converti les integer en numeric
    data_a_retourner <- datas[[1]]  %>% en_num()
      # dplyr::mutate(
      #   dplyr::across(
      #     dplyr::where(
      #       is.integer
      #     ),
      #     ~{as.numeric(.)}
      #   )
      # )
    return(data_a_retourner)
  } else {
    # dplyr::bind_rows(datas)
    combined_data <- do.call(rbind, datas)
    #on converti les integer en numeric
    combined_data <- combined_data  %>% en_num()
      # dplyr::mutate(
      #   dplyr::across(
      #     dplyr::where(
      #       is.integer
      #     ),
      #     ~{as.numeric(.)}
      #   )
      # )
    return(combined_data)
  }
}

get_all_geodata <- function(url, params = NULL, use_token = FALSE){#,PROXY = PROXY,TOKEN = TOKEN) {
  progress_bar <- get_param("PROGRESS_BAR")
  data_pages <- list()
  has_more_pages <- TRUE

  if (progress_bar) {
    cli::cli_progress_bar()
  }
  while (has_more_pages) {
    response <- get_api_response(url, params, use_token)#,PROXY = PROXY,TOKEN = TOKEN)
    if (length(response$features) > 0) {
      data_page <- sf::st_read(jsonlite::toJSON(response, auto_unbox = TRUE), quiet = TRUE)
      data_pages <- append(data_pages, list(data_page))

    }

    if (is.null(response$`next`)) {
      has_more_pages <- FALSE
      if (progress_bar) {
        cli::cli_progress_done()
      }
    } else {
      if (progress_bar) {
        cli::cli_progress_update(total = response$count,inc=500)
      }
      url <- response$`next`
    }
  }

  if (length(data_pages) > 0) {
    # combined_data <- data_pages
    # combined_data <- dplyr::bind_rows(data_pages)
    combined_data <- do.call(rbind, data_pages)

    return(combined_data)
  } else {
    return(NULL)
  }
}

get_dataframe <- function(self, no_param_code = FALSE,conversion_tibble=FALSE){#,PROXY = PROXY,TOKEN = TOKEN) {

  if (!is.null(self$lon_lat)) {
    lon <- as.numeric(self$lon_lat[1])
    lat <- as.numeric(self$lon_lat[2])
    lon_min <- lon - 0.01
    lon_max <- lon + 0.01
    lat_min <- lat - 0.01
    lat_max <- lat + 0.01
    in_bbox <- sprintf("in_bbox=%f,%f,%f,%f", lon_min, lat_min, lon_max, lat_max)
    url <- sprintf("%s?%s&contains_geom={\"type\": \"Point\", \"coordinates\":[%f, %f]}", self$url, in_bbox, lon, lat)
    return(get_all_data(url, self$params, use_token = self$use_token,conversion_tibble))
  }

  if (!is.null(self$in_bbox)) {
    url <- sprintf("%s?in_bbox=%s&page_size=500", self$url, paste(self$in_bbox, collapse = ","))
    return(get_all_data(url, self$params, use_token = self$use_token,conversion_tibble))#,PROXY = PROXY,TOKEN = TOKEN))
  }

  if (!is.null(self$code_insee)) {
    datas <- list()
    for (code in self$code_insee) {
      if (!no_param_code) {
        url <- sprintf("%s?code_insee=%s&page_size=500", self$url, code)
      } else {
        # # on décompose les codes insee
        # paste0("code_insee=",paste0(code,collapse = "%2C"))
        url <- sprintf("%s%s/", self$url, code)
      }
      data <- get_all_data(url, self$params, use_token = self$use_token,conversion_tibble)#,PROXY = PROXY,TOKEN = TOKEN)
      datas <- append(datas, list(data))
    }
  }

  if (!is.null(self$coddep)) {
    datas <- data.frame()
    for (code in self$coddep) {
      if (!no_param_code) {

        url <- sprintf("%s?coddep=%s&page_size=500", self$url, code)
      } else {
        url <- sprintf("%s%s/", self$url, code)
      }


      data <- get_all_data(url, self$params, use_token = self$use_token,conversion_tibble)#,PROXY = PROXY,TOKEN = TOKEN)
      datas <- append(datas, list(data))
      # datas <- dplyr::bind_rows(datas, data)
    }
  }

  # attention si on peut binder pas forcement evident pour notamment friches ?
  # return(datas)
  if (length(datas) == 1) {
    return(datas[[1]])
  } else {
    dplyr::bind_rows(datas)
    # return(do.call(rbind, datas))
  }
}

get_all_data <- function(url, params = NULL, use_token = FALSE,conversion_tibble=conversion_tibble){#,PROXY = PROXY,TOKEN = TOKEN) {
  progress_bar <- get_param("PROGRESS_BAR")
  data_pages <- list()
  has_more_pages <- TRUE
  if (progress_bar) {
    cli::cli_progress_bar()
  }
  while (has_more_pages) {

        response <- get_api_response(url, params, use_token)#,PROXY = PROXY,TOKEN = TOKEN) # je récupere un df sans $results
    if (length(response$results) > 0) {

      if (conversion_tibble){ # certains retours sont sur en format tibble (dv3f.mutations)

        data_page <- do.call(rbind, response$results)
        data_page <- dplyr::as_tibble(data_page)

      } else {

        data_page <- dplyr::bind_rows(response$results)
      }

      data_pages <-
        dplyr::bind_rows(data_pages, data_page) %>% en_num()
        # on converti les integer en numeric
        # dplyr::mutate(
        #   dplyr::across(
        #     dplyr::where(
        #       is.integer
        #     ),
        #     ~{as.numeric(.)}
        #   )
        # )
    }


        if (is.null(response$`next`)) {
      has_more_pages <- FALSE
      if (progress_bar) {
        cli::cli_progress_done()
      }
    } else {
      url <- response$`next`
      if (progress_bar) {
        cli::cli_progress_update(total = response$count,inc=500)
      }
    }
  }

  if (conversion_tibble){
  data_pages_simplifie <-
    data_pages %>%
    jsonlite::toJSON() %>%
    jsonlite::fromJSON(simplifyDataFrame = T)

  } else {

    data_pages_simplifie <-
      data_pages
  }

  return(
    data_pages_simplifie
  )
  # if (length(data_pages) > 0) {
  #   data <- dplyr::bind_rows(rbind, data_pages)
    # return(data)
  # } else {
  #   return(NULL)
  # }
}

get_api_response <- function(url,
                             params = NULL,
                             use_token = FALSE,
                             attempt = 1
                             # PROXY = PROXY,
                             # TOKEN = TOKEN
                             ) {
  max_attempts <- get_param("MAX_ATTEMPTS")
  HEADERS <- c("Content-Type" = "application/json")

  PROXIES <- NULL
  proxy <- get_param("PROXY")
  # proxy <- PROXY
  if (!is.null(proxy)) {
    PROXIES <- c("http" = proxy, "https" = proxy)
  }

  if (use_token) {
    token <- get_param("TOKEN")
    # token <- TOKEN
    if (is.null(token)) {
      cli::cli_abort(TokenNotConfigured(),call = NULL)
      # stop(TokenNotConfigured())
    }
    HEADERS["Authorization"] <- paste("Token", token)
  }

  tryCatch({
    response <- httr::GET(url, query = params, httr::add_headers(.headers = HEADERS), httr::use_proxy(PROXIES))
  }, error = function(e) {
    if (attempt < max_attempts) {
      return(get_api_response(url, params, use_token, attempt + 1
                              # PROXY = PROXY,
                              # TOKEN = TOKEN
                              ))
    } else {
      stop(e)
    }
  })

  status_code <- httr::status_code(response)
  if (status_code != 200) {
    error_message <- httr::content(response, "parsed")$detail
    cli::cli_abort(ApiDFError(status_code, error_message),call = NULL)
    # stop(ApiDFError(status_code, error_message))
  }

  # response_content <- jsonlite::fromJSON(rawToChar(response$content))$results
  response_content <- httr::content(response, "parsed")
  return(response_content)
}

is_num <- function(value) {
  return(is.numeric(value))
}

en_num <- function(data){
  data %>%
    dplyr::mutate(
    dplyr::across(
      dplyr::where(
        is.integer
      ),
      ~{as.numeric(.)}
    )
  )
}

process_geo_params <- function(...) {
  keyword_priority <- c("lon_lat", "in_bbox", "code_insee", "coddep")

  # Vérification de l'obligation de préciser au moins un paramètre
  if (!any(keyword_priority %in% names(list(...)))) {
    stop("Veuillez préciser au moins un paramètre parmi code_insee, in_bbox, lonlat et coddep.")
  }

  # Vérification si plusieurs mots-clés ont été utilisés
  used_keywords <- names(Filter(function(x) !is.null(x), list(...)))
  first_keyword <- NULL
  for (keyword in keyword_priority) {
    if (keyword %in% used_keywords) {
      first_keyword <- keyword
      break
    }
  }

  if (length(used_keywords) > 1) {
    warning_message <- sprintf("Les mots-clés %s ont été précisés. Seul le mot-clé %s sera utilisé.", paste(used_keywords, collapse = ", "), first_keyword)
    warning(warning_message)
  }
}


# OLD ----
# process_params <- function(self,...) {
#   args <- list(...)
#
#   # browser()
#   # if ("lon_lat" %in% names(args)){
#   #   self$lon_lat <- args$lon_lat
#   # }else{
#   #   self<-modifyList(self, list(lon_lat = NULL))
#   #   # self <- append(
#   #   #   self,
#   #   #   list(lon_lat = NULL)
#   #   # )
#   # }
#   #
#   # if ("in_bbox" %in% names(args)){
#   #   self$in_bbox <- args$in_bbox
#   # }else{
#   #   self<-modifyList(self, list(in_bbox = NULL))
#   #
#   #   # self <- append(
#   #   #   self,
#   #   #   list(in_bbox = NULL)
#   #   # )
#   # }
#   #
#   # if ("code_insee" %in% names(args)){
#   #   self$code_insee <- args$code_insee
#   # }else{
#   #   self<-modifyList(self, list(code_insee = NULL))
#   #   # self <- append(
#   #   #   self,
#   #   #   list(code_insee = NULL)
#   #   # )
#   # }
#   #
#   # if ("coddep" %in% names(args)){
#   #   self$coddep <- args$coddep
#   # }else{
#   #   self<-modifyList(self, list(coddep = NULL))
#   #   # self <- append(
#   #   #   self,
#   #   #   list(coddep = NULL)
#   #   # )
#   # }
#
#   self$params <- args[!names(args) %in% c("lon_lat","in_bbox","code_insee","coddep")]
#
#   # self$params <-
#   #   args[!(
#   #     names(args) %in% c("lon_lat","in_bbox","code_insee","coddep")
#   #     &
#   #     sapply(args, is.null)
#   #   )]
#   #
#   # if (length(self$params)==0){
#   #
#   #   self <- self[!names(self) %in% c("params")]
#   #   self <- append(
#   #     self,
#   #     list(params = NULL)
#   #   )
#   # }
#
#   self
# }


# process_params <- function(self, ...) {
#
#   args <- list(...)
#
#   geo_params <- process_filter_params(
#     lon_lat = args$lon_lat,
#     in_bbox = args$in_bbox,
#     code_insee = args$code_insee,
#     coddep = args$coddep
#   )
#
#   self$lon_lat <- geo_params$lon_lat
#   self$in_bbox <- geo_params$in_bbox
#   self$code_insee <- geo_params$code_insee
#   self$coddep <- geo_params$coddep
#
#   remaining_params <- process_filter_params(...)
#   self$params <- remaining_params
#
#   self
# }

# process_filter_params <- function(...) {
#   args <- list(...)
#   params <- list()
#
#   for (kw in names(args)) {
#     value <- args[[kw]]
#     if (!is.null(value)) {
#       params[[kw]] <- value
#     }
#   }
#
#   return(params)
# }

# process_geo_params <- function(...) {
#   keyword_priority <- c("lon_lat", "in_bbox", "code_insee", "coddep")
#
#   args <- list(...)
#
#   # Vérification de l'obligation de préciser au moins un paramètre
#   if (!any(keyword_priority %in% names(args))) {
#     stop("Veuillez préciser au moins un paramètre parmi code_insee, in_bbox, lon_lat et coddep.")
#   }
#
#   # Vérification si plusieurs mots-clés ont été utilisés
#   used_keywords <- names(args)[!sapply(args, is.null)]
#   first_keyword <- NULL
#   for (keyword in keyword_priority) {
#     if (keyword %in% used_keywords) {
#       first_keyword <- keyword
#       break
#     }
#   }
#   if (length(used_keywords) > 1) {
#     warning_message <- paste("Les mots-clés", paste(used_keywords, collapse = ", "),
#                              "ont été précisés. Seul le mot-clé", first_keyword, "sera utilisé.")
#     warning(warning_message)
#   }
#
#   values <- setNames(rep(list(NULL), length(keyword_priority)), keyword_priority)
#
#   # Vérification et traitement des paramètres selon la priorité des mots-clés
#   for (keyword in keyword_priority) {
#     if (keyword %in% names(args)) {
#       value <- args[[keyword]]
#
#       if (keyword == "lon_lat") {
#         # Vérification que lon_lat est une liste de 2 nombres
#         if (length(value) != 2 || !all(sapply(value, is.numeric))) {
#           stop("Le paramètre lon_lat doit être une liste de 2 nombres.")
#         }
#         values[[keyword]] <- as.character(value)
#         break
#       } else if (keyword == "in_bbox") {
#         # Vérification que in_bbox est une liste de 4 nombres
#         if (length(value) != 4 || !all(sapply(value, is.numeric))) {
#           stop("Le paramètre in_bbox doit être une liste de 4 nombres.")
#         }
#         values[[keyword]] <- as.character(value)
#         break
#       } else if (keyword %in% c("code_insee", "coddep")) {
#         if (is.character(value)) {
#           value <- list(value)
#         }
#         values[[keyword]] <- value
#         break
#       }
#     }
#   }
#
#   return(as.list(unlist(values)))
# }

