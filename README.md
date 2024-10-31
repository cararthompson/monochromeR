
# monochromeR <img src='man/figures/logo.png' style="float:right" height="250" />

**monochromeR** let’s you create and view monochrome colour palettes.
Two options are given to create palettes: go towards black and white
from you start colour or “blend” your start colour with another colour.
The package provide also a handy function to display a generated
palette.

<!-- mention `rgb_to_hex()` and co if maintaining them -->

**Please ensure accessibility criteria wherever you use colours.**

**Notice** Breaking chances were made with version 1.0.0. Please refer
to the end of the README for breaking changes.

## Installation

You can install the released version of {monochromeR} from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("monochromeR")
```

If you want the development version instead then install directly from
[GitHub](https://github.com/):

``` r
# install.packages("devtools")
devtools::install_github("cararthompson/monochromeR")
```

## Can we see some examples?

Sure! Let’s get started right away.

``` r
library(monochromeR)
```

### `palette_monochrome_blend()` and `palette_monochrome_bw()`

You can see the returned hex values printed for example,

``` r
palette_monochrome_blend("darkseagreen", blend_colour = "black", n_colours = 7)
#> [1] "#8FBC8F" "#7CA37C" "#698A69" "#567156" "#435843" "#303F30" "#1D261D"
palette_monochrome_blend("#96410EFF", blend_colour =  "#418979FF", n_colours = 5)
#> [1] "#96410E" "#854F23" "#745E39" "#636C4E" "#527B64"
```

or create a vector of them with a value (let’s choose `my_palette`)
assigned to it as illustrated next. This is handy, for example, if you
want to use it elsewhere or multiple times.

``` r
my_palette <- palette_monochrome_blend(
  "darkseagreen", blend_colour = "black", n_colours = 7
  )
```

Let’s get an impression by plotting these colours:

``` r
view_palette(my_palette)
```

![](man/figures/README-unnamed-chunk-5-1.png)<!-- -->

And take a look how people with a color vision deficiency might perceive
these colours:

``` r
prismatic::check_color_blindness(my_palette)
```

![](man/figures/README-unnamed-chunk-6-1.png)<!-- -->

Things work similar for `palette_monochrome_bw()`, here’s an example.

``` r
view_palette(palette_monochrome_bw("violetred3", n_colours = 5))
```

![](man/figures/README-unnamed-chunk-7-1.png)<!-- -->

### View any palette, with or without labels

From version 0.2.0 onwards, if you have created a named vector for your
colours, the names you have provided are displayed alongside the hex
codes.

``` r
banana_palette <- c(
  "unripe" = "#89973d", "ripe" = "#e8b92f", "overripe" = "#a45e41"
  )

view_palette(banana_palette)
```

![](man/figures/README-unnamed-chunk-8-1.png)<!-- -->

``` r
view_palette(
  c(
    wesanderson::wes_palettes$Moonrise1,
    wesanderson::wes_palettes$Moonrise2[1:2]
    )
  )
```

![](man/figures/README-unnamed-chunk-9-1.png)<!-- -->

If you’re searching inspiration from a broad range of palettes, you may
want to take a look at the
[paletter](https://emilhvitfeldt.github.io/paletteer/) package as well.

## Using `palette_monochrome_` within data visualisations

### Within `scale_colour_manual()`

Here’s a simple example, using {monochromeR}’s `palette_monochrome_bw()`
to create a colour palette on the fly within the {ggplot2} framework.

``` r
library(ggplot2)

penguins_plot <- palmerpenguins::penguins |>
  ggplot() +
  geom_point(
    aes(flipper_length_mm, bill_length_mm, colour = species, size = body_mass_g),
    alpha = 0.8
    ) +
  labs(
    title = "Famous palmer penguins", 
    subtitle = "Each dot represents a penguin. The bigger the dot, the heavier the penguin. \nLook at them!",
    x = "Flipper length (mm)",
    y = "Bill length (mm)"
    ) +
  guides(
    colour = guide_legend("Species", override.aes = list(size = 4)),
    size = "none"
    ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16),
    plot.subtitle = element_text(hjust = 0.5)
    )

penguins_plot
```

![](man/figures/README-unnamed-chunk-10-1.png)<!-- -->

``` r

penguins_plot +
 scale_colour_manual(values = palette_monochrome_bw("#0F4B63", n_colours = 3))
```

![](man/figures/README-unnamed-chunk-10-2.png)<!-- -->

### Creating a unified aesthetic across all aspects of the dataviz

Here’s an example using `{monochromeR}`’s `palette_monochrome_bw()` to
control the colours used in the plot, resulting in a more polished look
with minimal effort.

``` r
pp <- palette_monochrome_bw("#0F4B63", n_colours = 17)

penguins_plot +
  scale_colour_manual(values = pp[c(9, 11, 13)]) +
  theme(
    plot.background = element_rect(fill = pp[2], colour = pp[2]),
    panel.grid = element_line(colour = pp[5]),
    panel.background = element_rect(fill = pp[2], colour = pp[2]),
    text = element_text(colour = pp[16]),
    axis.ticks = element_line(colour = pp[5]),
    axis.text = element_text(colour = pp[16])
    )
```

![](man/figures/README-unnamed-chunk-11-1.png)<!-- -->

### Get the hex colour code from an rgb or rgba vector

<!-- to do -->

``` r
# Get hex code from rgb
rgb_to_hex(c(15, 75, 99))
#> [1] "#0F4B63"


# Get hex code from rgba
rgba_to_hex(c(15, 75, 99, 0.8))
#> [1] "#3E6E82"
```

### Get the rgb values from a hex code

<!-- to do -->

``` r
# Get the rgb values from the hex code
hex_to_rgb("#FFFFFF")
#> [1] "r = 255, g = 255, b = 255"

# Get the rgb values from the hex code
hex_to_rgb("#0F4B63")
#> [1] "r = 15, g = 75, b = 99"
```

## Breaking changes

In versions \<= 1.0.0 the function `generate_palette()` existed. It was
deprecated with version 1.0.0. It’s main intention is now given by
`palette_monochrome_blend()` and `palette_monochrome_bw()`.

## Bugs and queries

I’ve done my best to make the functions in this package user-friendly,
and to make the error messages easy to understand. If you come across a
bug or an error message that doesn’t make sense, or if there’s something
you think would make this package better, please open an
[issue](https://github.com/cararthompson/monochromeR/issues)!
