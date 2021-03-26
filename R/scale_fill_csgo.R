#' CSGo color palette - fill
#'
#' A color palette (fill) to be used with \code{ggplot2}
#'
#' @param discrete logical: if TRUE it will generate a discrete pallet otherwise a continuous palette
#' @param ... all available options of the \code{discrete_scale} function or \code{scale_fill_gradientn} both from \code{ggplot2}
#'
#' @return \code{scale_color} object
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
#'  theme_csgo(text = element_text(family = "quantico")) +
#'  scale_fill_csgo()
#' }
scale_fill_csgo <- function(discrete = TRUE, ...)
{
  pal <- grDevices::colorRampPalette(
    colors = c(
      "#5d79ae",
      "#0c0f12",
      "#ccba7c",
      "#413a27",
      "#de9b35"
    )
  )

  if(discrete)
  {
    ggplot2::discrete_scale(
      aesthetics = "fill",
      scale_name = 'csgo',
      palette = pal,
      ...
    )
  } else {
    ggplot2::scale_fill_gradientn(colours = pal(300), ...)
  }
}
