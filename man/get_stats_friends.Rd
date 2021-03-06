% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_stats_friends.R
\name{get_stats_friends}
\alias{get_stats_friends}
\title{Get the Friends Statistics}
\usage{
get_stats_friends(api_key, user_id, n_return = "all")
}
\arguments{
\item{api_key}{string with the key provided by the steam API.

PS: If you don`t have a API key yet run \code{vignette("auth", package = "CSGo")} and follow the presented steps.}

\item{user_id}{string with the steam user ID.

Steam ID is the NUMBER OR NAME at the end of your steam profile URL. ex: '76561198263364899'.

PS: The user should have a public status.}

\item{n_return}{numeric indicating the number of friends to return, to return all use n_return = "all" (the default is "all").}
}
\value{
a list of two data frames

friends_stats: data frame with all the CS Go statistics of all public friends of the user ID.

friends: data frame with all the CS Go friends of the user ID (public and non public).
}
\description{
This function will return the complete CS Go Statistics for all public friends of the user_id (input).
}
\examples{
\dontrun{
## It is necessary to fill the "api_key" parameter to run the example

# set the "plan" to collect the data in parallel!!!!
future::plan(future::multisession, workers = parallel::detectCores())

fr_list <- get_stats_friends(api_key = 'XXX', user_id = '76561198263364899')
fr_list$friends_stats
fr_list$friends
}
}
