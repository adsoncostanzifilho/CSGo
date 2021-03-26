#' CS Go User Profile
#'
#' This function will return the CS Go Profile of the user_id (input).
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
#' @param name logical: if the user_id input is a name change it for TRUE. ex: 'generalcapivara'.
#'
#' @return data frame with all the CS Go friends of the user ID.
#' @export
#'
#' @examples
#' \dontrun{
#' ## It is necessary to fill the "api_key" parameter to run the example
#'
#' df_profile <- csgo_api_profile(api_key = 'XXX', user_id = '76561198263364899')
#'
#' df_profile <- csgo_api_profile(api_key = 'XXX', user_id = 'generalcapivara', name = TRUE)
#' }
csgo_api_profile <- function(api_key, user_id, name = FALSE)
{

  if(name)
  {
    # Profile by user_name
    call_cs_profile <- sprintf(
      'http://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/?&key=%s&vanityurl=%s',
      api_key,
      user_id
    )

    api_query_profile <- httr::GET(call_cs_profile)

    api_content_profile <- httr::content(api_query_profile, 'text')

    json_content_profile <- jsonlite::fromJSON(api_content_profile, flatten = TRUE)

    user_id <- json_content_profile$response$steamid

    call_cs_profile <- sprintf(
      'http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?&key=%s&steamids=%s',
      api_key,
      user_id
    )


  }else{
    # Profile by user_id
    call_cs_profile <- sprintf(
      'http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?&key=%s&steamids=%s',
      api_key,
      user_id
    )
  }


  api_query_profile <- httr::GET(call_cs_profile)

  api_content_profile <- httr::content(api_query_profile, 'text')

  json_content_profile <- jsonlite::fromJSON(api_content_profile, flatten = TRUE)

  db_profile <- as.data.frame(json_content_profile$response$players)


  # RETURN
  return(db_profile)

}
