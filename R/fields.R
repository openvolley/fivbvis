#' Return the fields for a given VIS data type
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/}
#' @param type string: the data type, currently one of "Volleyball Tournament", "Volleyball Tournament Ranking", "Volleyball Tournament Filter", "Volleyball Player", "Volleyball Match"
#'
#' @return A character vector of field names
#'
#' @examples
#' v_fields("Volleyball Tournament")
#'
#' @export
v_fields <- function(type) {
    switch(type,
           "Referee" = c("No", "Gender", "FirstName", "LastName", "Birthdate", "FederationCode"),
           
           "Volleyball Tournament" = c("Actions", "ArticleBaseUrl", "BuyTicketsUrl", "City", "Code", "ContainsLiveComments", "ContainsLiveScores", "ContainsMatches", "ContainsMatchResults", "ContainsNews", "ContainsPictures", "ContainsPlayByPlay", "ContainsPlayers", "ContainsRanking", "ContainsStatistics", "ContainsTeams", "ContainsVideos", "ContainsVideoTracking", "CountryCode", "DeadlineO2", "DeadlineO2A", "DeadlineO2bis", "DefaultMatchFormat", "DefaultPlayersRanking", "DeletedDT", "EndDate", "EventLogos", "Gender", "IsFreeEntrance", "IsVisManaged", "LastChangeDT", "LastChangeUser", "LastChangeUsername", "Logos", "MaxNbPlayersO2", "MaxNbPlayersO2A", "MaxNbPlayersO2bis", "MaxNbTeamOfficialsOnBench", "MaxNbTeams", "Name", "No", "NoArticlePresentation", "NoEvent", "NoImageLogo", "NoImageOrganizerLogo", "NoImagePublicity", "OrganizerCode", "OrganizerType", "PlayerDisplayMethod", "PoolName", "PublishOnMsdp", "RoundCode", "Season", "ShortName", "ShortNameOrName", "StartDate", "Status", "TeamType", "TournamentLogos", "Type", "Version", "WebSite"),

           "Volleyball Tournament Ranking" = c("DeletedDT", "LastChangeDT", "LastChangeUser", "LastChangeUsername", "No", "NoTeam", "NoTournament", "Position", "Rank", "RankText", "RankTextWithRepeat", "TeamCode", "TeamName", "TeamNameOrCodeOrSource", "TeamSource", "Version"),

           "Volleyball Tournament Filter" = c("CountryCode", "FirstDate", "Genders", "IsVisManaged", "LastDate", "NoEvent", "Numbers", "PublishOnMsdp", "Seasons", "Statuses"), ## https://www.fivb.org/VisSDK/VisWebService/#VolleyTournamentFilter.html

           "Volleyball Player" = c("Block", "ClubFederationCode", "ClubName", "DeletedDT", "Height", "IsCaptain", "IsLibero", "IsPreselected", "IsSelected", "LastChangeDT", "LastChangeUser", "LastChangeUsername", "NbSelOG", "NbSelOther", "NbSelWC", "No", "NoEvent", "NoPhoto", "NoPlayer", "NoShirt", "NoTeam", "NoTournament", "Spike", "Version", "Weight"),

           "Volleyball Match" = c("AcquisitionMethod", "AssistantScorerCountryCode", "AssistantScorerFirstName", "AssistantScorerLastName", "BeginDateTimeUtc", "BuyTicketsUrl", "City", "CountryCode", "CountryName", "DateLocal", "DateTimeLocal", "DateTimeUtc", "DeletedDT", "Difficulty", "DifficultyRemarks", "DurationSet1", "DurationSet2", "DurationSet3", "DurationSet4", "DurationSet5", "DurationSet6", "DurationSet7", "DurationTotal", "EndDateTimeUtc", "Format", "FullDuration", "Hall", "HasLiveData", "IsFreeEntrance", "LastChangeDT", "LastChangeUser", "LastChangeUsername", "LineJudge1CountryCode", "LineJudge1FirstName", "LineJudge1LastName", "LineJudge2CountryCode", "LineJudge2FirstName", "LineJudge2LastName", "LineJudge3CountryCode", "LineJudge3FirstName", "LineJudge3LastName", "LineJudge4CountryCode", "LineJudge4FirstName", "LineJudge4LastName", "LiveScoreFromScoresheet", "LiveStreamUri", "LoserRank", "MatchPointsA", "MatchPointsB", "MatchResultText", "NbSets", "NbSpectators", "No", "NoDocumentP2", "NoDocumentScoresheet", "NoInjuriesForTeamA", "NoInjuriesForTeamB", "NoInTournament", "NoPool", "NoPoolRound", "NoReferee1", "NoReferee2", "NoRefereeChallenge", "NoRefereeDelegate", "NoRefereeReservce", "NoTeamA", "NoTeamB", "NoTournament", "PointsTeamASet1", "PointsTeamASet2", "PointsTeamASet3", "PointsTeamASet4", "PointsTeamASet5", "PointsTeamASet6", "PointsTeamASet7", "PointsTeamBSet1", "PointsTeamBSet2", "PointsTeamBSet3", "PointsTeamBSet4", "PointsTeamBSet5", "PointsTeamBSet6", "PointsTeamBSet7", "Referee1FederationCode", "Referee1Name", "Referee2FederationCode", "Referee2Name", "ResultType", "ResultTypeText", "ScheduleInfo", "ScorerCountryCode", "ScorerFirstName", "ScorerLastName", "SetsResultsText", "Status", "StatusText", "TeamACalculatedCode", "TeamACalculatedName", "TeamACode", "TeamALiberoUniformColor", "TeamAName", "TeamAShirtColor", "TeamAText", "TeamBCalculatedCode", "TeamBCalculatedName", "TeamBCode", "TeamBLiberoUniformColor", "TeamBName", "TeamBShirtColor", "TeamBText", "TimeLocal", "Version", "WinnerRank"), ## https://www.fivb.org/VisSDK/VisWebService/VolleyMatch.html

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
