#' Generate monochrome palette from start colour going towards another colour
#'
#' @description
#' `palette_monochrome_blend()` generates a monochrome palette from a start
#' colour going towards another colour. It is a wrapper around
#' [prismatic::clr_mix()].
#'
#'
#'
#' @details
#' * Alpha values in `colour` and `blend_colour` are ignored.
#' * The colour specification refers to the standard sRGB colorspace (IEC
#'   standard 61966).
#'
#'
#' @param colour The colour starting from which the palette is to be generated.
#'  Must be a length one character of a specification that [prismatic::clr_mix()]
#'  accepts as `col`.
#' @param blend_colour The colour to be used for "blending". Must be a length
#'  one character of a specification that [prismatic::clr_mix()] accepts as `col`.
#' @param n_colours A length 1 integerish (but not factor) vector indicating the
#'  number of colours to generate for the palette.
#'
#' @return A length `n_colours` character vector with hexencoded rgb values
#'  (i.e., "#rrggbb").
#'
#' @export
#' @family monochrome palettes
#'
#' @examples
#' palette_monochrome_blend("#0D3F53", blend_colour = "white", n_colours = 5)
#' palette_monochrome_blend("#96410EFF", blend_colour = "#418979FF", n_colours = 6)
#'
palette_monochrome_blend <- function(colour, blend_colour, n_colours) {

  if (!rlang::is_scalar_character(colour)) {
    stop("invalid `colour` type")
  }

  if (!rlang::is_scalar_character(blend_colour)) {
    stop("invalid `blend_colour` type")
  }

  if (!is_integerish_nofactor(n_colours, n = 1) || n_colours < 1) {
    stop("`n_colours` must be a positive integerish number")
  }

  zz <- prismatic::clr_mix(
    rep(blend_colour, n_colours), colour, seq(0.2, 1, length.out = n_colours)
  )

  pre_res <- rev(unclass(zz))
  # dirty removal of alpha channel, which is set to FF by `clr_mix()`
  gsub("(#[[:alnum:]]{6})FF$", "\\1", pre_res)

}


#' Generate monochrome palette from start colour going towards black and white
#'
#'
#' @description
#' `palette_monochrome_blend()` generates a monochrome palette from a start
#' colour going towards black and white.
#'
#'
#' @details
#' * Alpha values in `colour` are ignored.
#' * The colour specification refers to the standard sRGB colorspace (IEC
#'   standard 61966).
#'
#'
#' @param colour The colour starting from which the palette is to be generated.
#'  Must be a length one character of a specification that [prismatic::clr_mix()]
#'  accepts as `col`.
#' @param n_colours A length 1 integerish (but not factor) vector. Must be an
#'  odd number, so that the created palette is balanced in the sense of
#'  containing `floor(n_colours / 2)` colours in both directions. Must be larger
#'  than 1.
#'
#' @return A character vector of length `n_colours` with hexencoded rgb values
#'  (i.e., "#rrggbb").
#'
#' @export
#' @family monochrome palettes
#'
#' @examples
#' palette_monochrome_bw("violetred3", n_colours = 5)
#' palette_monochrome_bw("#CD3278FF", n_colours = 5)
#' palette_monochrome_bw("#0F4B63", n_colours = 11)
#'
palette_monochrome_bw <- function(colour, n_colours) {

  if (!rlang::is_scalar_character(colour)) {
    stop("invalid `colour` type")
  }

  if (!is_integerish_nofactor(n_colours, n = 1) || n_colours <= 1 || n_colours %% 2 == 0) {
    stop("`n_colours` must be a positive odd number larger than 1")
  }

  temp_n <- floor(n_colours / 2) + 1
  blk <- prismatic::clr_mix(
    rep("black", temp_n), colour, seq(0.2, 1, length.out = temp_n)
    )
  wht <- prismatic::clr_mix(
    rep("white", temp_n), colour, seq(0.2, 1, length.out = temp_n)
    )
  pre_res <- unclass(union(blk, rev(wht)))
  # dirty removal of alpha channel, which is set to FF by `clr_mix()`
  gsub("(#[[:alnum:]]{6})FF$", "\\1", pre_res)

}
