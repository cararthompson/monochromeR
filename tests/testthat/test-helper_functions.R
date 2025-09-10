# This uses the  behaviour-driven development (BDD) language
# https://testthat.r-lib.org/reference/describe.html
describe("check_colour_return_rgb()", {
  # Checks colour variables are either RGB values, hex colour codes or a
  # recognised colour name and converts to rgb
  specified_colour_vector_white <- c("red" = 255, "green" = 255, "blue" = 255)
  specified_colour_hexcode_white <- "#ffffff"
  specified_colour_colour_name_white <- "white"
  specified_colour_variable_name <- "test_colour"

  specified_colour_matrix_white <- as.matrix(specified_colour_vector_white)

  specified_invalid_colour_vector <- c("red" = 256, "green" = 256, "blue" = 256)
  specified_invalid_colour_hexcode <- "#ffffffz"
  specified_invalid_colour_colour_name <- "whitez"

  it("can handle colour RGB vector", {
    # TODO returns numeric vector, check is this wanted, the other two return a
    # matrix
    # If check_colour_return_rgb changed to return matrix for vector RGB values
    # then change second specified_colour_vector_white to
    # specified_colour_matrix_white
    expect_equal(
      check_colour_return_rgb(
        specified_colour_vector_white,
        specified_colour_variable_name
      ),
      specified_colour_vector_white
    )
  })

  it("can handle colour hex codes", {
    expect_equal(
      check_colour_return_rgb(
        specified_colour_hexcode_white,
        specified_colour_variable_name
      ), specified_colour_matrix_white
    )
  })

  it("can handle colour name", {
    expect_equal(
      check_colour_return_rgb(
        specified_colour_colour_name_white,
        specified_colour_variable_name
      ),
      specified_colour_matrix_white
    )
  })

  describe("invalid colours", {
    # RGB values, hex colour codes or a recognised colour name and converts to
    # rgb
    it("can show error for invalid colour rgb values", {
      expect_error(check_colour_return_rgb(
        specified_invalid_colour_vector,
        specified_colour_variable_name
      ))
    })
    it("can show error for invalid colour hex code", {
      # TODO Yes error called but not using your error message
      expect_error(check_colour_return_rgb(
        specified_invalid_colour_hexcode,
        specified_colour_variable_name
      ))
    })
    it("can show error for invalid colour name", {
      expect_error(check_colour_return_rgb(
        specified_invalid_colour_hexcode,
        specified_invalid_colour_colour_name
      ))
    })
  })

  describe("examples", {
    it("example valid colour name White", {
      expect_equal(
        check_colour_return_rgb("White", "test_colour"),
        specified_colour_matrix_white
      )
    })
    # TODO Yes an error is thrown but it's not your error message due to the
    # grepl looking for 'colour' 'instead of 'color'
    it("can show error for invalid colour name", {
      expect_error(check_colour_return_rgb("foo", "test_colour"))
    })
  })
})

describe("rgba_to_rgb()", {
  # Converts RGBA to RGB

  specified_rgba <- c(255, 0, 0, 0.8)
  specified_rgba_default_matrix <- as.matrix(c("red" = 255, "green" = 51, "blue" = 51))
  specified_rgba_background_colour_colour_name <- "white"
  specified_rgba_background_colour_colour_hex_code <- "#ffffff"
  specified_rgba_background_colour_colour_rgb <- c(255, 255, 255)

  specified_rgba_invalid_length <- c(255, 0, 0, 0.8, 255)
  specified_rgba_invalid_colour <- c(-1, -1, -1, 0.8)
  specified_rgba_invalid_alpha <- c(255, 0, 0, 2)
  specified_rgba_invalid_background_colour_colour_name <- "fakewhite"
  specified_rgba_invalid_background_colour_colour_hexcode <- "#ffffffz"
  specified_rgba_invalid_background_colour_colour_rgb <- c(256, 256, 256)

  example_rgba <- c(52, 46, 39, 0.8)
  example_rgba_default_matrix <- as.matrix(c("red" = 92.6, "green" = 87.8, "blue" = 82.2))

  example_rgba_colour_name <- "blue"
  example_rgba_colour_name_matrix <- as.matrix(c("red" = 41.6, "green" = 36.8, "blue" = 82.2))
  example_rgba_colour_hex_code <- "#032cfc"
  example_rgba_colour_hex_code_matrix <- as.matrix(c("red" = 42.2, "green" = 45.6, "blue" = 81.6))

  it("can convert RGBA to RGB, background colour default white", {
    expect_equal(rgba_to_rgb(specified_rgba), specified_rgba_default_matrix)
    # A matrix of red, green and blue values
    expect_true(is.matrix(rgba_to_rgb(specified_rgba)))
    expect_equal(rownames(rgba_to_rgb(specified_rgba)), c("red", "green", "blue"))
  })
  # `background_colour` must either be a recognised colour name (e.g. "white"),
  # a hex colour code (e.g. "#ffffff")
  # or vector of length 3 (red value, green value, blue value),
  # with all values between 0 and 255. The default value is white ("#ffffff").
  it("can convert RGBA to RGB, background colour blend with user colour name", {
    expect_equal(rgba_to_rgb(
      specified_rgba,
      specified_rgba_background_colour_colour_name
    ), specified_rgba_default_matrix)
  })
  it("can convert RGBA to RGB, background colour blend with user colour hex code", {
    expect_equal(rgba_to_rgb(
      specified_rgba,
      specified_rgba_background_colour_colour_hex_code
    ), specified_rgba_default_matrix)
  })
  it("can convert RGBA to RGB, background colour blend with user colour rgb vector", {
    expect_equal(rgba_to_rgb(
      specified_rgba,
      specified_rgba_background_colour_colour_rgb
    ), specified_rgba_default_matrix)
  })

  describe("US spelling color/colour", {
    it("can accept color_rgba instead of colour_rgba ", {
      expect_equal(rgba_to_rgb(color_rgba = specified_rgba), specified_rgba_default_matrix)
    })
    it("can accept background_color instead of background_colour", {
      expect_equal(rgba_to_rgb(
        specified_rgba,
        background_color = specified_rgba_background_colour_colour_name
      ), specified_rgba_default_matrix)
    })
  })

  describe("errors in parameters", {
    describe("handles errors in colour_rgba", {
      it("can show error invalid colour_rgba where colour_rgba = NULL", {
        expect_error(rgba_to_rgb(NULL))
      })
      it("can show error invalid colour_rgba length where length != 4 c(red value, green value, blue  value, alpha)'", {
        expect_error(rgba_to_rgb(specified_rgba_invalid_length))
      })
      # TODO - no testing of colour values 0-255 inside function
      it("can show error invalid colour_rgba colour value where 'All colour values must be between 0 and 255'", {
        expect_error(rgba_to_rgb(specified_rgba_invalid_colour))
      })
      # TODO - no testing of alpha 0-1 inside function
      it("can show error invalid colour_rgba alpa where 'Alpha must be between 0 and 1'", {
        expect_error(rgba_to_rgb(specified_rgba_invalid_alpha))
      })
    })
    describe("handles errors in background_colour", {
      #  must either be a recognised colour name (e.g. "white"),
      # a hex colour code (e.g. "#ffffff")
      # or vector of length 3 (red value, green value, blue value),
      # with all values between 0 and 255.
      # The default value is white ("#ffffff").
      it("can default to white background_colour where background_colour = NULL", {
        expect_equal(
          rgba_to_rgb(specified_rgba, , NULL),
          specified_rgba_default_matrix
        )
      })
      it("can show error invalid background_colour colour name", {
        expect_error(rgba_to_rgb(
          specified_rgba,
          specified_rgba_invalid_background_colour_colour_name
        ))
      })
      it("can show error invalid background_colour colour hex code", {
        expect_error(rgba_to_rgb(
          specified_rgba,
          specified_rgba_invalid_background_colour_colour_hexcode
        ))
      })
      it("can show error invalid background_colour vector rgb", {
        expect_error(rgba_to_rgb(
          specified_rgba,
          specified_rgba_invalid_background_colour_colour_rgb
        ))
      })
    })
  })

  describe("examples", {
    it("example default white background", {
      expect_equal(
        rgba_to_rgb(example_rgba),
        example_rgba_default_matrix
      )
    })
    it("example colour name", {
      expect_equal(
        rgba_to_rgb(example_rgba, example_rgba_colour_name),
        example_rgba_colour_name_matrix
      )
    })
    it("example colour hex code", {
      expect_equal(
        rgba_to_rgb(example_rgba, example_rgba_colour_hex_code),
        example_rgba_colour_hex_code_matrix
      )
    })
  })
})

describe("rgb_to_hex()", {
  # Converts RGB values to hex colour code

  specified_rgb_matrix_red <- as.matrix(c("red" = 255, "green" = 0, "blue" = 0))

  # rgb missing blue
  specified_rgb_matrix_red_invalid <- as.matrix(c("red" = 255, "green" = 0))
  specified_rgb_hex_code_red <- "#FF0000"

  example_rgb_matrix <- rgba_to_rgb(c(52, 46, 39, 0.8))
  example_rgb_hex_code <- "#5C5752"

  it("can turn matrix of red, blue and green values to hex colour code", {
    expect_equal(rgb_to_hex(specified_rgb_matrix_red), specified_rgb_hex_code_red)
    expect_error(rgb_to_hex(specified_rgb_matrix_red_invalid))
  })

  describe("examples", {
    it("example rgb matrix", {
      expect_equal(rgb_to_hex(example_rgb_matrix), example_rgb_hex_code)
    })
  })
})

describe("hex_to_rgb()", {
  # Converts Hex codes values to RGB vectors
  specified_colour_name <- "red"
  specified_colour_name_invalid <- "fakered"
  specified_rgb_colour_name <- "r = 255, g = 0, b = 0"
  specified_colour_hex_code <- "#ff0000"
  specified_colour_hex_code_invalid <- "#zz0000"

  example_colour_name_purple <- "purple"
  example_hex <- "#fafafa"
  example_rgb_colour_name_purple <- "r = 160, g = 32, b = 240"
  example_rgb_hex <- "r = 250, g = 250, b = 250"

  it("can handle colourname", {
    expect_equal(hex_to_rgb(specified_colour_name), specified_rgb_colour_name)
    # If a string is not a valid colour name
    expect_error(hex_to_rgb(specified_colour_name_invalid))
  })

  it("can handle hex codes", {
    expect_equal(hex_to_rgb(specified_colour_hex_code), specified_rgb_colour_name)
    # If a hex code string is not a valid hex colour
    expect_error(hex_to_rgb(specified_colour_hex_code_invalid))
  })

  describe("examples", {
    it("example colour name purple", {
      expect_equal(hex_to_rgb(example_colour_name_purple), example_rgb_colour_name_purple)
    })
    it("example colour hex code #fafafa", {
      expect_equal(hex_to_rgb(example_hex), example_rgb_hex)
    })
  })
})
