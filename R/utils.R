
is_integerish_nofactor <- function(x, n = NULL, finite = NULL) {

  rlang::is_integerish(x, n = n, finite = finite) && !is.factor(x)

}
