# errors if `colour` valid type but not a colour

    Code
      palette_monochrome_blend("nocolour", "white", n_colours = 4)
    Condition
      Error in `col2rgb()`:
      ! invalid color name 'nocolour'

---

    Code
      palette_monochrome_bw("nocolour", n_colours = 5)
    Condition
      Error in `col2rgb()`:
      ! invalid color name 'nocolour'

