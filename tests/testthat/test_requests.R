context("General tests of requests")

test_that("huge xml option works", {
    req <- fivbvis:::v_request(type = "GetBeachTournamentList", fields = v_fields("Beach Tournament"))
    ## this request tends to give (but not always) xml parse failures because the response is too deeply nested, so switch on the 'huge' xml parsing option
    res <- make_request(request = req, node_path = "//BeachTournament", huge = TRUE)
    expect_gt(nrow(res), 0)
})
