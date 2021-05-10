//
//  TeamDetail.swift
//  Football App
//
//  Created by Boubakar Traore on 05/05/2021.
//

import Foundation

struct TeamDetail: Codable {
    var teams: [TeamDetailInfo]
}

struct TeamDetailInfo: Codable {
    var name: String = ""
    var league: String = ""
    var country: String = ""
    var description : String? = ""
    var banner: String? = ""
    var sport: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "strTeam"
        case league = "strLeague"
        case country = "strCountry"
        case description = "strDescriptionEN"
        case banner = "strTeamBanner"
        case sport = "strSport"
    }

}
