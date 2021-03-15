#' CS Go Statistics
#'
#' This function will return all the CS Go Statistics of the user_id (input).
#'
#' @param api_key string with the key provided by the steam API.
#'
#' PS: If you don`t have a API key yet go to <https://steamcommunity.com/login/home/?goto=%2Fdev%2Fapikey> and follow the presented steps.
#'
#' @param user_id string with the steam user ID.
#'
#' Steam ID is the NUMBER OR NAME at the end of your steam profile URL. ex: '76561198263364899'.
#'
#' PS: The user should have a public status.
#'
#' @return data frame with all the CS Go statistics of the user ID.
#' @export
#'
#' @examples
#' \dontrun{
#' ## It is necessary to fill the "api_key" parameter to run the example
#'
#' df_stats <- csgo_api_stats(api_key = 'XXX', user_id = '76561198263364899')
#' }
csgo_api_stats <- function(api_key, user_id)
{
  # Stats
  call_cs_stats <- sprintf(
    'http://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v0002/?appid=730&key=%s&steamid=%s&apiname=%s',
    api_key,
    user_id,
    '1458786300'
  )

  api_query_stats <- httr::GET(call_cs_stats)

  api_content_stats <- httr::content(api_query_stats, 'text')

  if(stringr::str_detect(api_content_stats, 'Internal Server Error'))
  {
    db_stats <- data.frame(name = NA, value = NA)
  }else{
    json_content_stats <- jsonlite::fromJSON(api_content_stats, flatten = TRUE)

    db_stats <- as.data.frame(json_content_stats$playerstats$stats)
  }

  return(db_stats)

}
