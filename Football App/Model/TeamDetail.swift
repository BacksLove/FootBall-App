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
    var strTeam: String = ""
    var strLeague: String = ""
    var strCountry: String = ""
    var strDescriptionEN : String?
    var strTeamBanner: String?
    var strSport: String = ""

}
