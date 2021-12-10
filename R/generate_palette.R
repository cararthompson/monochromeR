

#' Generate a monochrome palette
#'
#' This function allows users generate a monochrome color palette
#' with any number of levels, starting from any color. The `modification`
#' parameter can be set to make the palette go darker, lighter, or both
#' ways from the starting color. The function also allows users to create
#' a pelette that goes from one color to another, by providing a `blend_color`.
#'
#'
#' @param color The anchor color for the palette, which must be either be a recognised color name (e.g. "white"),
#' a hex color code (e.g. "#ffffff") or vector of length 3 (red value, green value, blue value, e.g. c(15, 75, 99)),
#' with all values between 0 and 255. The default value is white ("#ffffff").
#' @param modification One of the following: "go_darker", "go_lighter", "go_both_ways", or "blend".
#' If a `blend_color` is supplied, `modification` is automatically set to "blend".
#' @param n_colors Number of colors (levels) required in the palette
#' @param blend_color Optional. Can be either be a recognised color name (e.g. "white"),
#' a hex color code (e.g. "#ffffff") or vector of length 3 (red value, green value, blue value, e.g. c(15, 75, 99)),
#' with all values between 0 and 255. The default value is white ("#ffffff").
#' @param view_palette Logical. `view_palette = TRUE` displays the palette in the plot window.
#' @param view_labels Logical. If view_palette is set to TRUE, view_labels = FALSE determines whether or
#' not the hex color codes are shown on the palette displayed in the plot window.
#'
#' @return A vector of hex color codes making up the generated palette
#' @export
#'
#' @examples generate_palette("red", modification = "go_lighter", n_colors = 5, view_palette = TRUE, view_labels = TRUE)
#' generate_palette(c(15, 75, 99), modification = "go_both_ways", n_colors = 12, view_palette = TRUE, view_labels = FALSE)
#' generate_palette("red", blend_color = "blue", n_colors = 6, view_palette = TRUE)
#'
generate_palette <- function(color, modification, n_colors,
                             blend_color = NULL,
                             view_palette = FALSE, view_labels = TRUE) {

  col_rgb <- check_color_return_rgb(color, "color")
  if(!is.null(blend_color)){
    bg_col <- c(check_color_return_rgb(blend_color, "blend_color"))
    message("
Because you supplied a blend_color, the modification variable is set to \"blend\".
To use other modification options (\"go_darker\", \"go_lighter\" or \"go_both_ways\"),
leave blend_color as NULL.")
    modification <- "blend"
  } else if(modification == "go_darker") {
    bg_col <- "black"
  } else if(modification == "go_lighter") {
    bg_col <- "white"
  }

  if(!modification %in% c("go_darker", "go_lighter", "go_both_ways", "blend")) {
    stop("modification must be one of the following: \"go_darker\", \"go_lighter\", \"go_both_ways\", or \"blend\"")
  }

  # if it's go both ways, need to do black and white separately for n_colors/2
  alpha_values <- seq(from = 1, to = 0.2, length.out = ifelse(modification == "go_both_ways",
                                                              floor(n_colors/2) + 1,
                                                              n_colors))

  generated_palette <- c()

  if(modification == "go_both_ways"){
    for (alpha_value in sort(alpha_values)) {
      generated_palette <- c(generated_palette, rgba_to_hex(c(col_rgb, alpha_value), "white"))
    }
    for (alpha_value in alpha_values) {
      generated_palette <- c(generated_palette, rgba_to_hex(c(col_rgb, alpha_value), "black"))
    }
    generated_palette <- unique(generated_palette)[1:n_colors]

  } else {
    for (alpha_value in alpha_values) {
      generated_palette <- c(generated_palette, rgba_to_hex(c(col_rgb, alpha_value), bg_col))
    }
  }

  if(view_palette == TRUE) {
    view_palette(generated_palette, view_labels = view_labels)
  }

  return(generated_palette)

}
