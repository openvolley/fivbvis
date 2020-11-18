v_fields <- function(type) {
    switch(type,
           "Volleyball Tournament" = c("Actions", "ArticleBaseUrl", "BuyTicketsUrl", "City", "Code", "ContainsLiveComments", "ContainsLiveScores", "ContainsMatches", "ContainsMatchResults", "ContainsNews", "ContainsPictures", "ContainsPlayByPlay", "ContainsPlayers", "ContainsRanking", "ContainsStatistics", "ContainsTeams", "ContainsVideos", "ContainsVideoTracking", "CountryCode", "DeadlineO2", "DeadlineO2A", "DeadlineO2bis", "DefaultMatchFormat", "DefaultPlayersRanking", "DeletedDT", "EndDate", "EventLogos", "Gender", "IsFreeEntrance", "IsVisManaged", "LastChangeDT", "LastChangeUser", "LastChangeUsername", "Logos", "MaxNbPlayersO2", "MaxNbPlayersO2A", "MaxNbPlayersO2bis", "MaxNbTeamOfficialsOnBench", "MaxNbTeams", "Name", "No", "NoArticlePresentation", "NoEvent", "NoImageLogo", "NoImageOrganizerLogo", "NoImagePublicity", "OrganizerCode", "OrganizerType", "PlayerDisplayMethod", "PoolName", "PublishOnMsdp", "RoundCode", "Season", "ShortName", "ShortNameOrName", "StartDate", "Status", "TeamType", "TournamentLogos", "Type", "Version", "WebSite"),

           "Volleyball Tournament Ranking" = c("DeletedDT", "LastChangeDT", "LastChangeUser", "LastChangeUsername", "No", "NoTeam", "NoTournament", "Position", "Rank", "RankText", "RankTextWithRepeat", "TeamCode", "TeamName", "TeamNameOrCodeOrSource", "TeamSource", "Version"),

           "Volleyball Tournament Filter" = c("CountryCode", "FirstDate", "Genders", "IsVisManaged", "LastDate", "NoEvent", "Numbers", "PublishOnMsdp", "Seasons", "Statuses"), ## https://www.fivb.org/VisSDK/VisWebService/#VolleyTournamentFilter.html

           "Volleyball Player" = c("Block", "ClubFederationCode", "ClubName", "DeletedDT", "Height", "IsCaptain", "IsLibero", "IsPreselected", "IsSelected", "LastChangeDT", "LastChangeUser", "LastChangeUsername", "NbSelOG", "NbSelOther", "NbSelWC", "No", "NoEvent", "NoPhoto", "NoPlayer", "NoShirt", "NoTeam", "NoTournament", "Spike", "Version", "Weight"),

           stop("unexpected fields type: ", type)
           )
}

## internal helper function, retrieve the fields from the web page
## e.g.
## v_get_fields("https://www.fivb.org/VisSDK/VisWebService/VolleyTournamentRankingEntry.html")
v_get_fields <- function(url, selector) {
    this <- rvest::html_table(xml2::read_html(url))
    return(this)
    if (is.list(this) && !is.data.frame(this)) {
        idx <- vapply(this, function(z) is.data.frame(z) && all(c("name", "type", "description") %in% tolower(colnames(z))), FUN.VALUE = TRUE)
        this <- if (sum(idx) == 1) this[[which(idx)]] else NULL
    }
    if (!is.null(this) && is.data.frame(this)) this$Name else NULL
}
