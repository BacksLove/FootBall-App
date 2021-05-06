//
//  DetailPresenter.swift
//  Football App
//
//  Created by Boubakar Traore on 05/05/2021.
//

import Foundation
import UIKit

protocol DetailPresenterDelegate: AnyObject {
    func getDetailTeam(team: TeamDetailInfo)
}

typealias DPresenter = DetailPresenterDelegate & UIViewController

class DetailPresenter {
    
    let teamURL = "https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t="
    
    weak var delegate: DPresenter?
    
    public func setViewDelegate(delegate: DPresenter) {
        self.delegate = delegate
    }
    
    func getAllDetail(team: String) {
        let tURL = (teamURL+team).replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: tURL) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, error in
            guard let safeData = data, error == nil else {
                return
            }
            do {
                let steamData = try JSONDecoder().decode(TeamDetail.self, from: safeData)
                var steam = TeamDetailInfo()
                for tmp in steamData.teams {
                    if tmp.strSport == "Soccer" && tmp.strTeam == team {
                        steam = tmp
                    }
                }
                self.delegate?.getDetailTeam(team: steam)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
