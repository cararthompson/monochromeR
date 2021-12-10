
#' Checks color variables are either RGB values, hex color codes or a recognised color name
#' and converts to rgb (helper funct)
#'
#' @param color The color string / rgb vector to check
#' @param color_variable_name The name of the variable, for readability of error messages
#'
#' @return An error message if the color value can't be interpreted
#' @export
#'
#' @examples check_color_return_rgb("White", "test_color")
#' \dontrun{check_color_return_rgb("foo", "test_color")}
#'
check_color_return_rgb <- function(color, color_variable_name) {
  if(is.character(color)) {
    if(any(grepl("invalid color name", try(grDevices::col2rgb(color), silent = T)))){
      stop(paste0("
\nThe string you provided for ", color_variable_name, " is neither a hex color code (e.g. \"#ffffff\")
nor a recognised color name (e.g. \"white\")."))
    } else {
      col_rgb <- grDevices::col2rgb(color)
    }
  } else if(is.vector(color) &
            is.numeric(color) &
            length(color) == 3 &
            all(color < 256)) {
    col_rgb <- color
  } else {
    stop(paste0("
\n", color_variable_name, " must either be a recognised color name (e.g. \"white\"),
a hex color code (e.g. \"#ffffff\") or vector of length 3 (red value,
green value, blue value), with all values between 0 and 255."))
  }
  return(col_rgb)
}


#' Converts RGBA to RGB (helper function)
#'
#' @param color_rgba A vector of length 4: c(red value, green value, blue value, alpha).
#' All colour values must be between 0 and 255. Alpha must be between 0 and 1.
#' @param background_color The background color must either be a recognised color name (e.g. \"white\"),
#' a hex color code (e.g. \"#ffffff\") or vector of length 3 (red value, green value, blue value),
#' with all values between 0 and 255. The default value is white ("#ffffff").
#'
#' @return A matrix of red, green and blue values
#' @export
#'
#' @examples rgba_to_rgb(c(52, 46, 39, 0.8))
#'
#' rgba_to_rgb(c(52, 46, 39, 0.8), "blue")
#'
#' rgba_to_rgb(c(52, 46, 39, 0.8), "#032cfc")
#'
rgba_to_rgb <- function(color_rgba, background_color = "#ffffff"){

  # get alpha
  if(length(color_rgba) != 4) {
    stop("
color_rgba must be vector of length 4: c(red value, green value, blue value, alpha).
All colour values must be between 0 and 255.
Alpha must be between 0 and 1.")
  }

  alpha <- color_rgba[4]

  bg_col_rgb <- check_color_return_rgb(background_color, "background_color")

  # get new color
  new_col <- matrix(c(
    (1 - alpha) * bg_col_rgb[1] + alpha * color_rgba[1],
    (1 - alpha) * bg_col_rgb[2] + alpha * color_rgba[2],
    (1 - alpha) * bg_col_rgb[3] + alpha * color_rgba[3]),
    nrow = 3,
    ncol = 1,
    dimnames = list(c("red","green","blue"))
  )
  return(new_col)
}


#' Converts RGB values to hex color code
#'
#' @param x A matrix of red, blue and green values
#'
#' @return A corresponding hex color code
#' @export
#'
#' @examples temp_rgb_matrix <- rgba_to_rgb(c(52, 46, 39, 0.8))
#' rgb_to_hex(temp_rgb_matrix)
#'
rgb_to_hex <- function(x){
  grDevices::rgb(x[1], x[2], x[3], maxColorValue = 255)
}


