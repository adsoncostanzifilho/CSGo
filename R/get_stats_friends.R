#' Get the Friends Statistics
#'
#' This function will return the complete CS Go Statistics for all public friends of the user_id (input).
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
#' @param n_return numeric indicating the number of friends to return, to return all use n_return = "all" (the default is "all").
#'
#' @return a list of two data frames
#'
#' friends_stats: data frame with all the CS Go statistics of all public friends of the user ID.
#'
#' friends: data frame with all the CS Go friends of the user ID (public and non public).
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ## It is necessary to fill the "api_key" parameter to run the example
#'
#' # set the "plan" to collect the data in parallel!!!!
#' future::plan(future::multisession, workers = parallel::detectCores())
#'
#' fr_list <- get_stats_friends(api_key = 'XXX', user_id = '76561198263364899')
#' fr_list$friends_stats
#' fr_list$friends
#' }
get_stats_friends <- function(api_key, user_id, n_return = 'all')
{

  # COLLECT THE PROFILE BY USER NAME OR BY USER ID
  # it will depend on the type of user_id
  if(is.na(as.numeric(user_id)))
  {
    user_profile <- csgo_api_profile(api_key, user_id, name = TRUE)
    user_id <- as.character(as.vector(user_profile$steamid))
  }else{
    user_id <- as.character(user_id)
  }

  # Get Friends IDs
  friend_list <- csgo_api_friend(api_key, user_id)

  # SPLITING THE IDs by 100 (each query allows max 100 user_id)
  f_steamid <- split(friend_list$steamid, ceiling(seq_along(friend_list$steamid)/100))


  # VERIFY IF THE USER IS PUBLIC OR NOT
  print("Public friends check..")

  f_profile <- furrr::future_map2_dfr(
    .x = api_key,
    .y = f_steamid,
    .f = purrr::possibly(csgo_api_profile,"Cant retrieve data")
  )

  # Verify public friends
  f_profile <- f_profile %>%
    dplyr::mutate(
      public = ifelse(
        as.numeric(f_profile$communityvisibilitystate) > 1,
        "Public",
        "Not Public"
      )
    ) %>%
    dplyr::left_join(friend_list, by = c("steamid" = "steamid"))

  friend_list2 <- f_profile %>%
    dplyr::filter(public == "Public")

  # N FRIENDS TO RETURN
  if(is.numeric(n_return) & nrow(friend_list2) >= n_return)
  {
    friend_list2 <- friend_list2 %>%
      dplyr::top_n(n = n_return, wt = friend_list2$friend_since)
  }

  print("Pulling friends stats..")

  return_list <- list()

  if(nrow(friend_list2) > 0)
  {
    db_friends_complete <- furrr::future_map2_dfr(
      .x = api_key,
      .y = as.character(friend_list2$steamid),
      .f = purrr::possibly(get_stats_user,"Cant retrieve data")
    )

    db_friends_complete <- db_friends_complete %>%
      dplyr::filter(!is.na(value))

    return_list$friends_stats <- db_friends_complete
    return_list$friends <- friend_list2
  }else{
    return_list$friends_stats <- 'NO PUBLIC FRIENDS'
    return_list$friends <- friend_list2
  }


  return(return_list)

}
