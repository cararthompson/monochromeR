#' View a created colour palette
#'
#' @description
#' `view_palette()` provides an option to view a vector of colours. It requires
#'  \{ggplot2\} to work.
#'
#'
#' @param x A character vector of colours encoded in a way [ggplot()] can work
#'  with, see `vignette("ggplot2-specs")`. Of course you can also call a palette
#'  generating function such as e.g. [palette_monochrome_blend()] or
#'  [palette_monochrome_bw()] inside `view_palette()`.
#' @param view_labels A logical. If `TRUE`, the hex colour codes and, if `x` is
#'  named, the names are shown in the plot as well. If `FALSE`, the colours `x`
#'  are shown alone.
#' @param monochrome_palette `r lifecycle::badge("deprecated")` Use the `x`
#'  argument instead.
#'
#' @return A ggplot showing all the colours in the palette in one row. Optionally,
#'  the hex color codes and, if available, the names can also be displayed.
#' @export
#'
#' @examplesIf rlang::is_installed("ggplot2")
#' view_palette(c("#464E69", "#8C90A1", "#D1D2D9"))
#' banana_palette <- c("unripe" = "#89973d", "ripe" = "#e8b92f", "overripe" = "#a45e41")
#' view_palette(banana_palette)
#' view_palette(
#'  palette_monochrome_bw("#CD3278FF", n_colours = 5), view_labels = FALSE
#'  )
#'
view_palette <- function(x, view_labels = TRUE, monochrome_palette = deprecated()) {

  if (lifecycle::is_present(monochrome_palette)) {
    lifecycle::deprecate_warn(
      "1.0.0", "view_palette(monochrome_palette)", "view_palette(x)",
      always = TRUE
      )
    x <- monochrome_palette
  }

  if(is.null(names(x))) {
    label_vector <- x
    } else {
      label_vector <- paste0("\"", names(x), "\"\n", x)
      }

  aes_x <- c(1:length(x))

  plt <- ggplot2::ggplot() +
    ggplot2::geom_tile(ggplot2::aes(aes_x, 1, fill = x)) +
    ggplot2::scale_fill_identity() +
    ggplot2::theme_void()

  if (isTRUE(view_labels)) {
    plt +
      ggplot2::geom_text(
        ggplot2::aes(aes_x, 0.8, label = label_vector), color = "black"
      ) +
      ggplot2::geom_text(
        ggplot2::aes(aes_x, 1.2, label = label_vector), color = "white"
      )
    } else {
      plt
      }

}

