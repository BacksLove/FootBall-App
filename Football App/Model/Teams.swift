//
//  Teams.swift
//  Football App
//
//  Created by Boubakar Traore on 06/05/2021.
//

import Foundation

struct Teams:Codable {
    var teams: [Team]
}

struct Team: Codable {
    var name: String
    var logo: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strTeam"
        case logo = "strTeamBadge"
    }
}
