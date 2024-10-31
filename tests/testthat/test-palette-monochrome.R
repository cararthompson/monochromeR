
# test `palette_monochrome_blend()` --------------------------------------------

test_that("returns character vector of correct length and hex codes", {

  expect_equal(
    palette_monochrome_blend("#0D3F53", blend_colour = "white", n_colours = 3),
    c("#0D3F53", "#6E8C98", "#CFD9DD")
  )

  expect_equal(
    palette_monochrome_blend("#96410EFF", "#418979FF", n_colours = 6),
    c("#96410E", "#884D1F", "#7B5830", "#6D6441", "#606F52", "#527B64")
  )

})

test_that("errors if `colour` invalid type", {

  expect_error(
    palette_monochrome_blend(factor(LETTERS[3:1]), "white", n_colours = 3),
    "invalid `colour` type"
  )

  expect_error(
    palette_monochrome_blend(list(pal = "#000000"), "white", n_colours = 3),
    "invalid `colour` type"
  )

  expect_error(
    palette_monochrome_blend(TRUE, "white", n_colours = 3),
    "invalid `colour` type"
  )

  expect_error(
    palette_monochrome_blend(c("#96410E", "orange"), "white", n_colours = 3),
    "invalid `colour` type"
  )

  expect_error(
    palette_monochrome_blend(8, "white", n_colours = 3),
    "invalid `colour` type"
  )

})

test_that("errors if `colour` valid type but not a colour", {

  expect_snapshot(
    palette_monochrome_blend("nocolour", "white", n_colours = 4),
    error = TRUE
    )

})

test_that("errors if `n_colours` not a single integerish number", {

  expect_error(
    palette_monochrome_blend(
      "violetred3", blend_colour = "white", n_colours = c(3, 5)
    ),
    "`n_colours` must be a positive integerish number"
  )

  expect_error(
    palette_monochrome_blend(
      "violetred3", blend_colour = "white", n_colours = "five"
    ),
    "`n_colours` must be a positive integerish number"
  )

  expect_error(
    palette_monochrome_blend(
      "violetred3", blend_colour = "white", n_colours = factor("a")
    ),
    "`n_colours` must be a positive integerish number"
  )

})

test_that("errors if `n_colours` lower equal zero", {

  expect_error(
    palette_monochrome_blend("violetred3", blend_colour = "white", n_colours = 0),
    "`n_colours` must be a positive integerish number"
  )

  expect_error(
    palette_monochrome_blend("violetred3", blend_colour = "white", n_colours = -10),
    "`n_colours` must be a positive integerish number"
  )

})


# test `palette_monochrome_bw()` -----------------------------------------------

test_that("returns character vector of correct length and hex codes", {

  expect_equal(
    palette_monochrome_bw("#0F4B63", n_colours = 5),
    c("#030F14", "#092D3B", "#0F4B63", "#6F93A1", "#CFDBE0")
    )
  expect_equal(
    palette_monochrome_bw("#0F4B63", n_colours = 7),
    c("#030F14", "#07232E", "#0B3749", "#0F4B63", "#4F7B8D", "#8FABB6", "#CFDBE0")
    )
  expect_equal(
    palette_monochrome_bw("violetred3", n_colours = 9),
    c("#290A18", "#521430", "#7B1E48", "#A42860", "#CD3278", "#D75B93",
      "#E184AE", "#EBADC9", "#F5D6E4")
    )

})

test_that("errors if `colour` invalid type", {

  expect_error(
    palette_monochrome_bw(factor(LETTERS[3:1]), n_colours = 3),
    "invalid `colour` type"
  )

  expect_error(
    palette_monochrome_bw(list(pal = "#000000"), n_colours = 3),
    "invalid `colour` type"
  )

  expect_error(palette_monochrome_bw(TRUE, n_colours = 3), "invalid `colour` type")

  expect_error(
    palette_monochrome_bw(c("violetred3", "white"), n_colours = 3),
    "invalid `colour` type"
  )

  expect_error(palette_monochrome_bw(8, n_colours = 3), "invalid `colour` type")

})

test_that("errors if `colour` valid type but not a colour", {

  expect_snapshot(palette_monochrome_bw("nocolour", n_colours = 5), error = TRUE)

})

test_that("errors if `n_colours` not a single integerish number", {

  expect_error(
    palette_monochrome_bw("violetred3", n_colours = c(3, 5)),
    "`n_colours` must be a positive odd number larger than 1"
  )

  expect_error(
    palette_monochrome_bw("violetred3", n_colours = "five"),
    "`n_colours` must be a positive odd number larger than 1"
  )

  expect_error(
    palette_monochrome_bw("violetred3", n_colours = factor("a")),
    "`n_colours` must be a positive odd number larger than 1"
  )

})

test_that("errors if `n_colours` lower equal one or an even number", {

  expect_error(
    palette_monochrome_bw("violetred3", n_colours = -1),
    "`n_colours` must be a positive odd number larger than 1"
  )

  expect_error(
    palette_monochrome_bw("violetred3", n_colours = 6),
    "`n_colours` must be a positive odd number larger than 1"
  )

})


# ------------------------------------------------------------------------------

