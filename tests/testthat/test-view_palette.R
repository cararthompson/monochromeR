describe("view_palette()", {
  it("can create a plot showing all the colours in the palette on the same row", {
    # Note that expect_doppelganger() requires R version 4.1.0. If run on an
    # earlier version of R, it emits a testthat::skip() so that you can still
    # run other checks on old versions of R.

    # Local, interactive use. We mostly use devtools::test_coverage_active_file()
    # and devtools::test_coverage(), for exploring the coverage of an individual
    # file or the whole package, respectively.

    vdiffr::expect_doppelganger(
      title = "grey palette with labels",
      fig = view_palette(c("#464E69", "#8C90A1", "#D1D2D9"), view_labels = TRUE)
    )
    vdiffr::expect_doppelganger(
      title = "ripe palette with labels",
      fig = view_palette(
        c(
          "unripe" = "#89973d",
          "ripe" = "#e8b92f",
          "overripe" = "#a45e41"
        ),
        view_labels = TRUE
      )
    )
    vdiffr::expect_doppelganger(
      title = "pink palette with labels",
      fig = view_palette(
        generate_palette("pink",
          "go_darker",
          n_colours = 3
        ),
        view_labels = TRUE
      )
    )
    vdiffr::expect_doppelganger(
      title = "grey palette no labels",
      fig = view_palette(c("#464E69", "#8C90A1", "#D1D2D9"),
        view_labels = FALSE
      )
    )
    vdiffr::expect_doppelganger(
      title = "ripe palette no labels",
      fig = view_palette(
        c(
          "unripe" = "#89973d",
          "ripe" = "#e8b92f",
          "overripe" = "#a45e41"
        ),
        view_labels = FALSE
      )
    )
    vdiffr::expect_doppelganger(
      title = "pink palette no labels",
      fig = view_palette(
        generate_palette("pink",
          "go_darker",
          n_colours = 3
        ),
        view_labels = FALSE
      )
    )
  })
})
