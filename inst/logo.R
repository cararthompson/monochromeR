
library(ggplot2)
library(hexSticker)
library(dplyr)
library(extrafont)
library(showtext)

font_add_google("Lato", "lato")

showtext_auto()

pal <- generate_palette(c(15, 75, 99), modification = "go_both_ways",
                        n_colors = 12, view_palette = F)

p <- ggplot(aes(x = 1, y = coord),
            data = tibble(coord = c(1:7))) +
  geom_bar(aes(fill = as.character(coord)), position="stack",
           stat="identity", show.legend = F) +
  scale_discrete_manual(aesthetics = "fill", values = pal[2:9]) +
  theme_void() +
  theme_transparent()

sticker(p, package="monochromeR", p_y = 1.11, p_size=18.5, s_x=1, s_y=1, s_width=1.9, s_height=2.2,
        h_color = pal[2], p_color = pal[1], p_family = "lato",
        white_around_sticker = T,
        url = "github.com/cararthompson/monochromeR",
        u_color = pal[2], u_size = 3.6, u_family = "lato",
        filename = "man/figures/logo.png")
