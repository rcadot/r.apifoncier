test_that("test numeric ok", {
  expect_true(!is.null(ind_conso_espace_communes('1')))
  expect_equal(ind_conso_espace_communes(1),ind_conso_espace_communes(01))
})
