#' Get the User Statistics
#'
#' This function will return the complete CS Go Statistics of the user_id (input).
#'
#' Similar to the csgo_api_stats function but it will return a clean data frame with category and description of each statistic.
#'
#' @param api_key string with the key provided by the steam API.
#'
#' PS: If you don`t have a API key yet run \code{vignette("auth", package = "CSGo")} and follow the presented steps.
#'
#' @param user_id string with the steam user ID.
#'
#' Steam ID is the NUMBER OR NAME at the end of your steam profile URL. ex: '76561198263364899'.
#'
#' PS: The user should have a public status.
#'
#' @return data frame with all the CS Go statistics (divided in categories and subcategories) of the user ID.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ## It is necessary to fill the "api_key" parameter to run the example
#'
#' df <- get_stats_user(api_key = 'XXX', user_id = '76561198263364899')
#' }
get_stats_user <- function(api_key, user_id)
{
  # COLLECT THE PROFILE BY USER NAME OR BY USER ID
  # it will depend on the type of user_id
  if(is.na(as.numeric(user_id)))
  {
    user_id <- as.character(as.vector(csgo_api_profile(api_key, user_id, name = TRUE)))[1]
  } else{
    user_id <- as.character(user_id)
  }

  # COLLECT THE DATA
  stats <- csgo_api_stats(api_key,user_id)

  profile_name <- csgo_api_profile(api_key,user_id)$personaname

  # INCLUDING LABELS AND CATEGORIES
  stats <- fuzzyjoin::fuzzy_left_join(
    stats,
    support,
    by = c('name' = 'name_match'),
    match_fun = stringr::str_detect)

  # REMOVE DUPLICATES
  aux <- stats %>%
    dplyr::filter(stats$type == 'maps', stats$name_match == 'dust2')

  stats <- stats %>%
    dplyr::anti_join(aux, by = c("value"="value")) %>%
    dplyr::bind_rows(aux) %>%
    dplyr::mutate(player_name = profile_name)


  # RETURN
  return(stats)
}
