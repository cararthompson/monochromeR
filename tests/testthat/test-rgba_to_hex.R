# This uses the  behavior-driven development (BDD) language
# https://testthat.r-lib.org/reference/describe.html
describe("rgba_to_hex()", {
  # An double vector is an atomic vector of type "double"
  rgba_vector_alpha <- 0.8
  rgba_vector <- c(52, 46, 39, rgba_vector_alpha)
  rgba_vector_type <- "double"
  hex_result_type <- "character"

  describe("no background colour supplied, use white default", {
    # white default
    hex_result_no_background <- "#5C5752"

    it("can return the corresponding hex colour code for valid vector of RGBA
       values", {
      expect_type(rgba_vector, rgba_vector_type)
      expect_type(rgba_to_hex(rgba_vector), hex_result_type)
      expect_equal(rgba_to_hex(rgba_vector), hex_result_no_background)
    })
    it("can show error if colour values not length 4", {
      rgba_invalid_vector_not_length_4 <- c(-1, 256, 999)
      expect_error(rgba_to_hex(rgba_invalid_vector_not_length_4))
    })
    it("can show error if colour values not between 0 and 255", {
      rgba_invalid_vector_not_rgb_0to255 <- c(-1, 256, 999, 0.8)
      expect_error(rgba_to_hex(rgba_invalid_vector_not_rgb_0to255))
    })
    it("can show error if colour values not alpha must be between 0 and 1", {
      rgba_invalid_vector_not_alpha_0to1 <- c(1, 2, 3, 99)
      expect_error(rgba_to_hex(rgba_invalid_vector_not_alpha_0to1))
    })
    it("can handle US spelling of color/colour for parameter named colour_rgba", {
      expect_equal(
        rgba_to_hex(colour_rgba = rgba_vector),
        hex_result_no_background
      )
      expect_equal(
        rgba_to_hex(color_rgba = rgba_vector),
        hex_result_no_background
      )
    })
  })
  describe("background colour supplied", {
    background_colour_name <- "blue"
    hex_result_background_colour_name <- "#292452"

    it("can return the corresponding hex colour code, background - recognised
    colour name", {
      expect_equal(
        rgba_to_hex(rgba_vector, background_colour_name),
        hex_result_background_colour_name
      )
    })
    it("can return the corresponding hex colour code, background - hex colour
    code (e.g. '#ffffff')", {
      background_colour_hex <- "#032cfc"
      hex_result_background_colour_hex <- "#2A2D51"
      expect_equal(
        rgba_to_hex(rgba_vector, background_colour_hex),
        hex_result_background_colour_hex
      )
    })
    it("can return the corresponding hex colour code , background - vector of
    length 3 (red value, green value, blue value), with all values between 0 and
       255", {
      rgba_background_vector <- c(52, 46, 39)
      hex_result_background_colour_rgb <- "#342E27"
      expect_equal(
        rgba_to_hex(rgba_vector, rgba_background_vector),
        hex_result_background_colour_rgb
      )
    })
    it("can handle US spelling of color/colour for background_colour", {
      expect_equal(
        rgba_to_hex(rgba_vector, background_colour = background_colour_name),
        hex_result_background_colour_name
      )
      expect_equal(
        rgba_to_hex(rgba_vector, background_color = background_colour_name),
        hex_result_background_colour_name
      )
    })
  })
})
