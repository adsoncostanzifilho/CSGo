#' CS Go Friends
#'
#' This function will return all the CS Go friends of the user_id (input).
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
#' @return data frame with all the CS Go friends of the user ID.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ## It is necessary to fill the "api_key" parameter to run the example
#'
#' df_friend <- csgo_api_friend(api_key = 'XXX', user_id = '76561198263364899')
#' }
csgo_api_friend <- function(api_key, user_id)
{
  # Friends
  call_cs_friend <- sprintf(
    'http://api.steampowered.com/ISteamUser/GetFriendList/v0001/?appid=730&relationship=friend&key=%s&steamid=%s',
    api_key,
    user_id
  )

  api_query_friend <- httr::GET(call_cs_friend)

  api_content_friend <- httr::content(api_query_friend, 'text')

  json_content_friend <- jsonlite::fromJSON(api_content_friend, flatten = TRUE)

  db_friend <- as.data.frame(json_content_friend$friendslist$friends)

  # RETURN
  return(db_friend)

}
