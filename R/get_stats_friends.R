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
#' fr_list <- get_stats_friends(api_key = 'XXX', user_id = '76561198263364899')
#' fr_list$friends_stats
#' fr_list$friends
#' }
get_stats_friends <- function(api_key, user_id)
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

  # GETING THE FRIENDS IDs
  friend_list <- csgo_api_friend(api_key, user_id)

  # VERIFY IF THE USER IS PUBLIC OR NOT
  print("Public friends check..")

  # auxiliary function to create/check if the friend has public data or not
  check_public <- function(steamid, ...)
  {
    df_return <- data.frame(
      steamid = steamid,
      personaname = NA,
      public = NA,
      profileurl = NA,
      avatarfull = NA
    )

    temp <- csgo_api_profile(api_key, steamid)

    if(("communityvisibilitystate" %in% colnames(temp)))
    {
      df_return$public <- ifelse(
        as.numeric(temp$communityvisibilitystate) > 1,
        "Public",
        "Not Public"
      )
      df_return$personaname <- temp$personaname
      df_return$profileurl <- temp$profileurl
      df_return$avatarfull <- temp$avatarfull

    }
    else{
      df_return$public <- "Not Public"
    }
    return(df_return)
  }

  friend_list <- purrr::map_df(.x = friend_list$steamid, .f = check_public)

  friend_list2 <- friend_list %>%
    dplyr::filter(public == "Public")

  # GETING THE STATS OF EACH FRIEND
  print("Pulling friends stats..")
  return_list <- list()

  if(nrow(friend_list2) > 0)
  {
    db_friends_complete <- purrr::map2_df(
      .x = api_key,
      .y = as.character(friend_list2$steamid),
      .f = get_stats_user
    )

    db_friends_complete <- db_friends_complete %>%
      dplyr::filter(!is.na(value))

    return_list$friends_stats <- db_friends_complete
    return_list$friends <- friend_list
  }else{
    return_list$friends_stats <- 'NO PUBLIC FRIENDS'
    return_list$friends <- friend_list
  }

  return(return_list)

}
