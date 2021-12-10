#' rgba_to_hex
#'
#' @param color_rgba A vector of length 4: c(red value, green value, blue value, alpha).
#' All colour values must be between 0 and 255. Alpha must be between 0 and 1.
#' @param background_color The background color must either be a recognised color name (e.g. \"white\"),
#' a hex color code (e.g. \"#ffffff\") or vector of length 3 (red value, green value, blue value),
#' with all values between 0 and 255. The default value is white ("#ffffff").
#'
#' @return Returns the corresponding hex color code
#' @export
#'
#' @examples rgba_to_hex(c(52, 46, 39, 0.8))
#'
#' rgba_to_hex(c(52, 46, 39, 0.8), "blue")
#'
#' rgba_to_hex(c(52, 46, 39, 0.8), "#032cfc")
#'
rgba_to_hex <- function(color_rgba,  background_color = "#ffffff"){

  new_col <- rgba_to_rgb(color_rgba, background_color)

  new_col_hex <- rgb_to_hex(new_col)

  return(new_col_hex)

}
