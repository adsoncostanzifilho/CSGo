#' CS Go Achievements
#'
#' This function will return all the CS Go Achievements of the user_id (input).
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
#' @return data frame with all the CS Go achievements of the user ID.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ## It is necessary to fill the "api_key" parameter to run the example
#'
#' df_ach <- csgo_api_ach(api_key = 'XXX', user_id = '76561198263364899')
#' }
csgo_api_ach <- function(api_key, user_id)
{

  # Achievements
  call_cs_ach <- sprintf(
    'http://api.steampowered.com/ISteamUserStats/GetPlayerAchievements/v0001/?appid=730&key=%s&steamid=%s',
    api_key,
    user_id
  )

  api_query_ach <- httr::GET(call_cs_ach)

  api_content_ach <- httr::content(api_query_ach, 'text')

  json_content_ach <- jsonlite::fromJSON(api_content_ach, flatten = TRUE)

  db_achievements <- as.data.frame(json_content_ach$playerstats$achievements)

  # RETURN
  return(db_achievements)

}
