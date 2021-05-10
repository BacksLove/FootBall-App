//
//  HomePresenter.swift
//  Football App
//
//  Created by Boubakar Traore on 05/05/2021.
//

import Foundation
import UIKit

protocol HomePresenterDelegate: AnyObject {
    func getTeamsLeague(teams: [Team])
    func getAllLeagues(leagues: [String])
}

typealias HPresenter = HomePresenterDelegate & UIViewController

class HomePresenter {
    
    let teamsURL = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l="
    let ligueURL = "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php"
    
    weak var delegate: HPresenter?
    
    public func setViewDelegate(delegate: HPresenter) {
        self.delegate = delegate
    }
    
    public func getAllTeams(league: String) {
        let ligueURL = (teamsURL+league).replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: ligueURL) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, error in
            guard let safeData = data, error == nil else {
                return
            }
            do {
                let allTeams = try JSONDecoder().decode(Teams.self, from: safeData)
                self.delegate?.getTeamsLeague(teams: allTeams.teams)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    // Recupération en base de la liste des ligues pour l'autocomplétion
    
    public func getAllLeagues() {
        guard let url = URL(string: ligueURL) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, error in
            guard let safeData = data, error == nil else {
                return
            }
            do {
                let allLeaguesData = try JSONDecoder().decode(Leagues.self, from: safeData)
                var allLeagues = [String]()
                for league in allLeaguesData.leagues {
                    if league.sport == "Soccer" {
                        allLeagues.append(league.name)
                    }
                }
                self.delegate?.getAllLeagues(leagues: allLeagues)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }

    
}
