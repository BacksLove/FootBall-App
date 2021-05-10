//
//  Teams.swift
//  Football App
//
//  Created by Boubakar Traore on 05/05/2021.
//

import Foundation

struct Leagues:Codable {
    var leagues: [League]
}

struct League: Codable {
    var name: String
    var sport: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strLeague"
        case sport = "strSport"
    }
}

