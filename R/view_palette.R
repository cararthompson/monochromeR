

#' Easy way to view the created palette
#'
#' @param monochrome_palette Vector of hex colour codes, or a `generate_palette()` call
#' @param view_labels Logical. If `view_palette` is set to TRUE, `view_labels` determines whether or
#' not the hex colour codes are shown on the palette displayed in the plot window.
#'
#' @return A plot showing all the colours in the palette on the same row
#' @export
#'
#' @examples view_palette(c("#464E69", "#8C90A1", "#D1D2D9"))
#'view_palette(generate_palette("pink", "go_darker", n_colours = 3))

view_palette <- function(monochrome_palette,
                         view_labels = TRUE) {

  palette_tiles <- ggplot2::ggplot() +
    ggplot2::geom_tile(ggplot2::aes(x = c(1:length(monochrome_palette)),
                  y = rep(1, length(monochrome_palette)),
                  fill = monochrome_palette),
              show.legend = F) +
    ggplot2::scale_fill_identity() +
    ggplot2::theme_void()

  if(view_labels == TRUE) {
    palette_tiles <- palette_tiles +
      ggplot2::geom_text(ggplot2::aes(x = c(1:length(monochrome_palette)),
                    y = rep(1.2, length(monochrome_palette)),
                    label = monochrome_palette),
                show.legend = F,
                fontface = "bold") +
      ggplot2::geom_text(ggplot2::aes(x = c(1:length(monochrome_palette)),
                    y = rep(0.8, length(monochrome_palette)),
                    label = monochrome_palette),
                show.legend = F,
                colour = "white",
                fontface = "bold")
  }
  palette_tiles
}
