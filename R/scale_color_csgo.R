#' CSGo color palette - color
#'
#' A color palette (color) to be used with \code{ggplot2}
#'
#' @param discrete logical: if TRUE it will generate a discrete pallet otherwise a continuous palette
#' @param ... all available options of the \code{discrete_scale} function or \code{scale_color_gradientn} both from \code{ggplot2}
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
#'  top_n(n = 10, wt = kills) %>%
#'  ggplot(aes(x = name_match, size = shots)) +
#'  geom_point(aes(y = kills_efficiency, color = "Kills Efficiency")) +
#'  geom_point(aes(y = hits_efficiency, color = "Hits Efficiency")) +
#'  geom_point(aes(y = hits_to_kill, color = "Hits to Kill")) +
#'  ggtitle("Weapon Efficiency") +
#'  ylab("Efficiency (%)") +
#'  xlab("") +
#'  labs(color = "Efficiency Type", size = "Shots") +
#'  theme_csgo(
#'    text = element_text(family = "quantico"),
#'    panel.grid.major.x = element_line(size = .1, color = "black",linetype = 2)
#'  ) +
#'  scale_color_csgo()
#'  }
scale_color_csgo <- function(discrete = TRUE, ...)
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
      aesthetics = "color",
      scale_name = 'csgo',
      palette = pal,
      ...
    )
  } else {
    ggplot2::scale_color_gradientn(colours = pal(300), ...)
  }
}
