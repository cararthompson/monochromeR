# This uses the  behavior-driven development (BDD) language
# https://testthat.r-lib.org/reference/describe.html
describe("generate_palette()", {
  specified_colour_name <- "red"
  specified_colour_hex <- "#ff0000"
  specified_colour_rgb <- c(255, 0, 0)
  specified_colour_modification <- "go_darker"
  specified_colour_n_colours <- 5
  result_vector_hex_specified_colour <- c("#FF0000", "#CC0000", "#990000", "#650000", "#330000")

  modification_go_darker <- "go_darker"
  modification_go_lighter <- "go_lighter"
  modification_go_both_ways <- "go_both_ways"
  modification_blend <- "blend"
  modification_blend_colour <- "blue"

  result_vector_hex_modification_go_darker <- c("#FF0000", "#CC0000", "#990000", "#650000", "#330000")
  result_vector_hex_modification_go_lighter <- c("#FF0000", "#FF3232", "#FF6666", "#FF9999", "#FFCCCC")
  result_vector_hex_modification_go_both_ways <- c("#FFCCCC", "#FF6666", "#FF0000", "#990000", "#330000")
  result_vector_hex_modification_blend <- c("#FF0000", "#CC0032", "#990066", "#650099", "#3300CC")


  describe("starting from a specified colour name", {
    it("can generate a monochrome palette starting from a specified colour name", {
      expect_equal(generate_palette(
        specified_colour_name, specified_colour_modification,
        specified_colour_n_colours
      ), result_vector_hex_specified_colour)
    })
    it("can generate a monochrome palette starting from a specified colour hex", {
      expect_equal(generate_palette(
        specified_colour_hex, specified_colour_modification,
        specified_colour_n_colours
      ), result_vector_hex_specified_colour)
    })
    it("can generate a monochrome palette starting from a specified colour rgb", {
      expect_equal(generate_palette(
        specified_colour_rgb, specified_colour_modification,
        specified_colour_n_colours
      ), result_vector_hex_specified_colour)
    })
    it("can show user error for invalid specified colour", {
      expect_error(generate_palette(
        NULL, specified_colour_modification,
        specified_colour_n_colours
      ))
    })
  })

  describe("palette modification compared to specified starting colour", {
    it("can go darker", {
      expect_equal(generate_palette(
        specified_colour_name, modification_go_darker,
        specified_colour_n_colours
      ), result_vector_hex_modification_go_darker)
    })
    it("can go lighter", {
      expect_equal(generate_palette(
        specified_colour_name, modification_go_lighter,
        specified_colour_n_colours
      ), result_vector_hex_modification_go_lighter)
    })
    it("can go both ways", {
      expect_equal(generate_palette(
        specified_colour_name, modification_go_both_ways,
        specified_colour_n_colours
      ), result_vector_hex_modification_go_both_ways)
    })
    it("can blend from one colour to the other", {
      # Because you supplied a blend_colour, the modification variable is set to "blend".
      # To use other modification options ("go_darker", "go_lighter" or "go_both_ways"),
      # leave blend_colour as NULL.

      # Specifying blend colour only, modification NULL
      expect_equal(generate_palette(
        specified_colour_name,
        modification = NULL,
        specified_colour_n_colours,
        blend_colour = modification_blend_colour
      ), result_vector_hex_modification_blend)

      # Specifying blend colour, modification explicitly blend
      expect_equal(generate_palette(
        specified_colour_name,
        modification = modification_blend,
        specified_colour_n_colours,
        blend_colour = modification_blend_colour
      ), result_vector_hex_modification_blend)
    })
    it("can show error for invalid blend colour", {
      # Specifying blend colour, modification explicitly blend
      # blend_colour invalid
      expect_error(generate_palette(
        specified_colour_name,
        modification = modification_blend,
        specified_colour_n_colours,
        blend_colour = -1
      ))
      # modification explicitly blend but blend_colour invalid NULL
      # TODO: better user error, currently object 'bg_col' not found
      expect_error(generate_palette(
        specified_colour_name,
        modification = modification_blend,
        specified_colour_n_colours,
        blend_colour = NULL
      ))
    })
    it("can handle invalid modification", {
      expect_error(generate_palette(
        specified_colour_name,
        modification = "qwerty",
        specified_colour_n_colour
      ))
    })
  })

  describe("change number of colours in palette", {
    # n_colours = Number of colours (levels) required in the palette

    it("can change palette to multiple number of colours", {
      expect_equal(generate_palette(
        specified_colour_name,
        specified_colour_modification,
        n_colours = 1
      ), c("#FF0000"))
      expect_equal(generate_palette(
        specified_colour_name,
        specified_colour_modification,
        n_colours = 2
      ), c("#FF0000", "#330000"))
      expect_equal(generate_palette(
        specified_colour_name,
        specified_colour_modification,
        n_colours = 10
      ), c(
        "#FF0000", "#E80000", "#D10000", "#BB0000", "#A40000", "#8D0000",
        "#770000", "#600000", "#490000", "#330000"
      ))
    })

    it("can handle invalid number of colours", {
      # TODO: FAILS when n_colors is null, add more error handing,
      # currently Error in ans[npos] <- rep(no, length.out = len)[npos] :
      # replacement has length zero
      expect_null(generate_palette(
        specified_colour_name,
        specified_colour_modification,
        n_colours = NULL
      ))

      # TODO: better user warning for when number of colours set to zero
      # currently generates NULL for palette result, but maybe warn user?
      expect_null(generate_palette(
        specified_colour_name,
        specified_colour_modification,
        n_colours = 0
      ))
    })
  })

  describe("view palette", {
    it("can display the palette", {
      expect_equal(generate_palette(
        specified_colour_name, specified_colour_modification,
        specified_colour_n_colours,
        view_palette = TRUE
      ), result_vector_hex_specified_colour)

      # cant use visual test here as plot object not returned by function
    })
    it("can hide the palette", {
      expect_equal(generate_palette(
        specified_colour_name, specified_colour_modification,
        specified_colour_n_colours,
        view_palette = FALSE
      ), result_vector_hex_specified_colour)
    })
  })

  describe("view labels on palette", {
    it("can display the palette with labels", {
      expect_equal(generate_palette(
        specified_colour_name, specified_colour_modification,
        specified_colour_n_colours,
        view_palette = TRUE,
        view_labels = TRUE,
      ), result_vector_hex_specified_colour)
    })
    it("can display the palette without labels", {
      expect_equal(generate_palette(
        specified_colour_name, specified_colour_modification,
        specified_colour_n_colours,
        view_palette = TRUE,
        view_labels = FALSE,
      ), result_vector_hex_specified_colour)
    })
  })

  describe("US spelling", {
    # colour
    it("can handle parameter colour or color", {
      expect_equal(generate_palette(
        colour = specified_colour_name,
        specified_colour_modification,
        specified_colour_n_colours
      ), result_vector_hex_specified_colour)

      # TODO: FAILS using 'color',
      # Error in grDevices::col2rgb(colour) : invalid color name 'go_darker'
      # Called from: grDevices::col2rgb(colour)
      # In covr we don't seem to reach inside this if statement in the code
      #   if (missing(colour) & "color" %in% names(check_dots)) {
      #     colour <- check_dots$color
      #   }
      expect_equal(generate_palette(
        color = specified_colour_name,
        specified_colour_modification,
        specified_colour_n_colours
      ), result_vector_hex_specified_colour)
    })
    # blend_colour
    it("can handle parameter blend_colour or blend_color", {
      expect_equal(generate_palette(
        specified_colour_name,
        modification = modification_blend,
        specified_colour_n_colours,
        blend_colour = modification_blend_colour
      ), result_vector_hex_modification_blend)
      expect_equal(generate_palette(
        specified_colour_name,
        modification = modification_blend,
        specified_colour_n_colours,
        blend_color = modification_blend_colour
      ), result_vector_hex_modification_blend)
    })

    # n_colours
    it("can handle parameter n_colours or n_colors", {
      expect_equal(generate_palette(
        specified_colour_name,
        specified_colour_modification,
        n_colours = specified_colour_n_colours
      ), result_vector_hex_specified_colour)
      expect_equal(generate_palette(
        specified_colour_name,
        specified_colour_modification,
        n_colors = specified_colour_n_colours
      ), result_vector_hex_specified_colour)
    })
  })
  describe("examples", {
    #' generate_palette("red",
    #'                  #'   modification = "go_lighter",
    #'                  #'   n_colours = 5, view_palette = TRUE, view_labels = TRUE
    #'                  #' )
    expect_equal(generate_palette(
      "red",
      modification = "go_lighter",
      n_colours = 5,
      view_palette = TRUE,
      view_labels = TRUE
    ), c("#FF0000", "#FF3232", "#FF6666", "#FF9999", "#FFCCCC"))

    #' generate_palette(c(15, 75, 99),
    #'   modification = "go_both_ways",
    #'   n_colours = 12, view_palette = TRUE, view_labels = FALSE
    #' )
    expect_equal(generate_palette(
      c(15, 75, 99),
      modification = "go_both_ways",
      n_colours = 12,
      view_palette = TRUE,
      view_labels = FALSE
    ), c(
      "#CFDBDF", "#AFC3CB", "#8FABB6", "#6F93A1", "#4E7B8C", "#2E6377",
      "#0F4B63", "#0D4155", "#0B3748", "#092D3B", "#07232E", "#051921"
    ))

    #'
    #' generate_palette("red",
    #'   blend_colour = "blue",
    #'   n_colours = 6, view_palette = TRUE
    #' )
    expect_equal(generate_palette(
      "red",
      blend_colour = "blue",
      n_colours = 6,
      view_palette = TRUE
    ), c("#FF0000", "#D60028", "#AD0051", "#84007A", "#5B00A3", "#3300CC"))
  })
})
