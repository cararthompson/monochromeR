

#' Generate a monochrome palette
#'
#' #' @description
#' `r lifecycle::badge("deprecated")`
#' `generate_palette()` has been deprecated in favour of [palette_monochrome_bw()]
#' and [palette_monochrome_blend()].
#'
#' This function allows users generate a monochrome colour palette
#' containing any number of colours, starting from the colour they specify. The `modification`
#' parameter can be set to make the palette go darker, lighter, or both
#' ways from the starting colour. The function also allows users to create
#' a palette that goes from one colour to another, by providing a `blend_colour`.
#'
#'
#' @param colour The starting colour for the palette, which must be either be a recognised colour name (e.g. "white"),
#' a hex colour code (e.g. "#ffffff") or vector of length 3 (red value, green value, blue value, e.g. c(15, 75, 99)),
#' with all values between 0 and 255.
#' @param modification One of the following: "go_darker", "go_lighter", "go_both_ways", or "blend".
#' If a `blend_colour` is supplied, `modification` is automatically set to "blend".
#' @param n_colours Number of colours (levels) required in the palette
#' @param blend_colour Optional. Can be either be a recognised colour name (e.g. "white"),
#' a hex colour code (e.g. "#ffffff") or vector of length 3 (red value, green value, blue value, e.g. c(15, 75, 99)),
#' with all values between 0 and 255.
#' @param view_palette Logical. `view_palette = TRUE` displays the palette in the plot window.
#' @param view_labels Logical. If view_palette is set to TRUE, view_labels = FALSE determines whether or
#' not the hex colour codes are shown on the palette displayed in the plot window.
#' @param ... Allows for US spelling of color/colour.
#'
#' @return A vector of hex colour codes making up the generated palette
#' @export
#'
#' @examples generate_palette("red", modification = "go_lighter",
#' n_colours = 5, view_palette = TRUE, view_labels = TRUE)
#'
#' generate_palette(c(15, 75, 99), modification = "go_both_ways",
#' n_colours = 12, view_palette = TRUE, view_labels = FALSE)
#'
#' generate_palette("red", blend_colour = "blue",
#' n_colours = 6, view_palette = TRUE)
#'
generate_palette <- function(colour, modification, n_colours,
                             blend_colour = NULL,
                             view_palette = FALSE, view_labels = TRUE, ...) {

  lifecycle::deprecate_warn(
    "1.0.0",
    "generate_palette()",
    details = c(
      i = "Use `palette_monochrome_blend()` or `palette_monochrome_bw()` instead"
      ),
    always = TRUE
    )

  # Allows for US spelling input
  check_dots <- list(...)

  if(missing(colour) & "color" %in% names(check_dots)) {
    colour <- check_dots$color
  }

  if(missing(n_colours) & "n_colors" %in% names(check_dots)) {
    n_colours <- check_dots$n_colors
  }

  if("blend_color" %in% names(check_dots)) {
   blend_colour <- check_dots$blend_color
  }

  col_rgb <- check_colour_return_rgb(colour, "colour")
  if(!is.null(blend_colour)){
    bg_col <- c(check_colour_return_rgb(blend_colour, "blend_colour"))
    message("
Because you supplied a blend_colour, the modification variable is set to \"blend\".
To use other modification options (\"go_darker\", \"go_lighter\" or \"go_both_ways\"),
leave blend_colour as NULL.")
    modification <- "blend"
  } else if(modification == "go_darker") {
    bg_col <- "black"
  } else if(modification == "go_lighter") {
    bg_col <- "white"
  }

  if(!modification %in% c("go_darker", "go_lighter", "go_both_ways", "blend")) {
    stop("modification must be one of the following: \"go_darker\", \"go_lighter\", \"go_both_ways\", or \"blend\"")
  }

  # if it's go both ways, need to do black and white separately for n_colours/2
  alpha_values <- seq(from = 1, to = 0.2, length.out = ifelse(modification == "go_both_ways",
                                                              floor(n_colours/2) + 1,
                                                              n_colours))

  generated_palette <- c()

  if(modification == "go_both_ways"){
    for (alpha_value in sort(alpha_values)) {
      generated_palette <- c(generated_palette, rgba_to_hex(c(col_rgb, alpha_value), "white"))
    }
    for (alpha_value in alpha_values) {
      generated_palette <- c(generated_palette, rgba_to_hex(c(col_rgb, alpha_value), "black"))
    }
    generated_palette <- unique(generated_palette)[1:n_colours]

  } else {
    for (alpha_value in alpha_values) {
      generated_palette <- c(generated_palette, rgba_to_hex(c(col_rgb, alpha_value), bg_col))
    }
  }

  if(view_palette == TRUE) {
    print(view_palette(generated_palette, view_labels = view_labels))
  }

  return(generated_palette)

}
