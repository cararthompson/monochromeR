
#' Checks colour variables are either RGB values, hex colour codes or a recognised colour name
#' and converts to rgb (helper funct)
#'
#' @param colour The colour string / rgb vector to check
#' @param colour_variable_name The name of the variable, for readability of error messages
#'
#' @return An error message if the colour value can't be interpreted
#' @export
#'
#' @examples check_colour_return_rgb("White", "test_colour")
#' \dontrun{check_colour_return_rgb("foo", "test_colour")}
#'
check_colour_return_rgb <- function(colour, colour_variable_name) {
  if(is.character(colour)) {
    if(any(grepl("invalid colour name", try(grDevices::col2rgb(colour), silent = T)))){
      stop(paste0("
\nThe string you provided for ", colour_variable_name, " is neither a hex colour code (e.g. \"#ffffff\")
nor a recognised colour name (e.g. \"white\")."))
    } else {
      col_rgb <- grDevices::col2rgb(colour)
    }
  } else if(is.vector(colour) &
            is.numeric(colour) &
            length(colour) == 3 &
            all(colour < 256)) {
    col_rgb <- colour
  } else {
    stop(paste0("
\n", colour_variable_name, " must either be a recognised colour name (e.g. \"white\"),
a hex colour code (e.g. \"#ffffff\") or vector of length 3 (red value,
green value, blue value), with all values between 0 and 255."))
  }
  return(col_rgb)
}


#' Converts RGBA to RGB (helper function)
#'
#' @param colour_rgba A vector of length 4: c(red value, green value, blue value, alpha).
#' All colour values must be between 0 and 255. Alpha must be between 0 and 1.
#' @param background_colour Defaults to white. Users can specify a different colour to get
#' the hex code for their original colour blended with a specified background colour.
#' `background_colour` must either be a recognised colour name (e.g. "white"),
#' a hex colour code (e.g. "#ffffff") or vector of length 3 (red value, green value, blue value),
#' with all values between 0 and 255. The default value is white ("#ffffff").
#' @param ... Allows for US spelling of color/colour
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
rgba_to_rgb <- function(colour_rgba, background_colour = "#ffffff", ...){

  # Allows for US spelling input
  check_dots <- list(...)

  if(missing(colour_rgba) & "color_rgba" %in% names(check_dots)) {
    colour_rgba <- check_dots$color_rgba
  }

  if("background_color" %in% names(check_dots)) {
    background_colour <- check_dots$background_color
  }

  # get alpha
  if(length(colour_rgba) != 4) {
    stop("
colour_rgba must be vector of length 4: c(red value, green value, blue value, alpha).
All colour values must be between 0 and 255.
Alpha must be between 0 and 1.")
  }

  alpha <- colour_rgba[4]

  bg_col_rgb <- check_colour_return_rgb(background_colour, "background_colour")

  # get new colour
  new_col <- matrix(c(
    (1 - alpha) * bg_col_rgb[1] + alpha * colour_rgba[1],
    (1 - alpha) * bg_col_rgb[2] + alpha * colour_rgba[2],
    (1 - alpha) * bg_col_rgb[3] + alpha * colour_rgba[3]),
    nrow = 3,
    ncol = 1,
    dimnames = list(c("red","green","blue"))
  )
  return(new_col)
}


#' Converts RGB values to hex colour code
#'
#' @param x A matrix of red, blue and green values
#'
#' @return A corresponding hex colour code
#' @export
#'
#' @examples temp_rgb_matrix <- rgba_to_rgb(c(52, 46, 39, 0.8))
#' rgb_to_hex(temp_rgb_matrix)
#'
rgb_to_hex <- function(x){
  grDevices::rgb(x[1], x[2], x[3], maxColorValue = 255)
}


