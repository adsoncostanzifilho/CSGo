#' CSGo theme
#'
#' A CSGo theme to be used with \code{ggplot2}
#'
#' @param ... all available options of the \code{theme} function from \code{ggplot2}
#'
#' @return \code{theme} object
#' @export
#'
#' @examples
#' \dontrun{
#' library(CSGo)
#' library(ggplot2)
#' library(dplyr)
#' library(showtext)
#'
#' ## Loading Google fonts (https://fonts.google.com/)
#' font_add_google("Quantico", "quantico")
#'
#' df %>%
#'  top_n(n = 10, wt = value) %>%
#'  ggplot(aes(x = name_match, y = value, fill = name_match)) +
#'  geom_col() +
#'  ggtitle("KILLS BY WEAPON") +
#'  ylab("Number of Kills") +
#'  xlab("") +
#'  labs(fill = "Weapon Name") +
#'  theme_csgo(text = element_text(family = "quantico"))
#'
#' }
theme_csgo <- function(...)
{
  ggplot2::theme_bw() +
    ggplot2::theme(
      strip.text = ggplot2::element_text(color = 'white', face = 'bold'),
      panel.grid = ggplot2::element_blank(),
      plot.title = ggplot2::element_text(hjust = 0.5),
      axis.title = ggplot2::element_text(face = 'bold'),
      axis.text = ggplot2::element_text(color = 'black'),
      axis.text.x = ggplot2::element_text(angle = 45, hjust = 1),
      ...
    )
}




