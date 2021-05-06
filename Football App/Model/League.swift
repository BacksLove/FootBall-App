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
    var strLeague: String
    var strSport: String
}

