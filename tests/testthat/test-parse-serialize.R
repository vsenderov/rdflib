testthat::context("Parsers and Serializers")

doc <- system.file("extdata/example.rdf", package="redland")
out <- "testing.rdf"


testthat::test_that("we can parse (in rdfxml)
                    and serialize (in nquads) a simple rdf graph", {
                      rdf <- rdf_parse(doc) 
                      rdf_serialize(rdf, out, "nquads")
                      roundtrip <- rdf_parse(out, "nquads")
                      testthat::expect_is(roundtrip, "rdf")
                      
                      rdf_free(rdf)
                      })

testthat::test_that("we can add a namespace on serializing", {
  rdf <- rdf_parse(doc)
  rdf_serialize(rdf,
                out,
                namespace = "http://purl.org/dc/elements/1.1/",
                prefix = "dc")
  roundtrip <- rdf_parse(doc)
  testthat::expect_is(roundtrip, "rdf")
  
  rdf_free(rdf)
  rdf_free(roundtrip)
  
})

################################################################


testthat::test_that("we can parse and serialize json-ld", {
  rdf <- rdf_parse(doc)
  rdf_serialize(rdf, out, "jsonld")
  roundtrip <- rdf_parse(out, "jsonld")
  testthat::expect_is(roundtrip, "rdf")
  rdf_free(rdf)
  
})

testthat::test_that("we can parse and serialize nquads", {
  rdf <- rdf_parse(doc)
  rdf_serialize(rdf, out, "nquads")
  roundtrip <- rdf_parse(out, "nquads")
  testthat::expect_is(roundtrip, "rdf")
  rdf_free(rdf)
  
})
testthat::test_that("we can parse and serialize ntriples", {
  rdf <- rdf_parse(doc)
  rdf_serialize(rdf, out, "ntriples")
  roundtrip <- rdf_parse(out, "ntriples")
  testthat::expect_is(roundtrip, "rdf")
  rdf_free(rdf)
  
})
testthat::test_that("we can parse and serialize tutle", {
  rdf <- rdf_parse(doc)
  rdf_serialize(rdf, out, "turtle")
  roundtrip <- rdf_parse(out, "turtle")
  testthat::expect_is(roundtrip, "rdf")
  rdf_free(rdf)
})
testthat::test_that("we can parse and serialize rdfxml", {
  rdf <- rdf_parse(doc)
  rdf_serialize(rdf, out, "rdfxml")
  roundtrip <- rdf_parse(out, "rdfxml")
  testthat::expect_is(roundtrip, "rdf")
  rdf_free(rdf)
})

################################################################


testthat::test_that("we can parse from a url", {
  # CRAN seems okay with tests requiring an internet connection
  #testthat::skip_on_cran()
  rdf <- rdf_parse("https://tinyurl.com/ycf95c9h")
  testthat::expect_is(rdf, "rdf")
  
  rdf_free(rdf)
})

testthat::test_that("we can parse from a text string", {
  rdf <- rdf_parse(doc)
  txt <- format(rdf, format = "rdfxml")
  testthat::expect_is(txt, "character")
  roundtrip <- rdf_parse(txt, format="rdfxml")
  testthat::expect_is(roundtrip, "rdf")
  rdf_free(rdf)
  
  string <-
    '
  _:b0 <http://schema.org/jobTitle> "Professor" .
  _:b0 <http://schema.org/name> "Jane Doe" .
  _:b0 <http://schema.org/age> "35" .
  _:b0 <http://schema.org/url> <http://www.janedoe.com> .
  _:b0 <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://schema.org/Person> .
  '
  rdf <- rdf_parse(string, "nquads")
  testthat::expect_is(rdf, "rdf")
  
  rdf_free(rdf)
})

unlink(out)
