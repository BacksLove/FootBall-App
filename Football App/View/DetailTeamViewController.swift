//
//  DetailTeamViewController.swift
//  Football App
//
//  Created by Boubakar Traore on 05/05/2021.
//

import UIKit

class DetailTeamViewController: UIViewController, DetailPresenterDelegate {
    
    @IBOutlet weak var teamBannerImageView: UIImageView!
    @IBOutlet weak var teamCountryLabel: UILabel!
    @IBOutlet weak var teamLeagueLabel: UILabel!
    @IBOutlet weak var teamDescriptionLabel: UILabel!
    
    var selectedTeam: String = ""
    var team: TeamDetailInfo = TeamDetailInfo()
    private let presenter = DetailPresenter()
    
    override func viewDidLoad() {
        presenter.setViewDelegate(delegate: self)
        presenter.getAllDetail(team: selectedTeam)
    }
    
    func getDetailTeam(team: TeamDetailInfo) {
        DispatchQueue.main.async {
            self.team = team
            self.updateUI()
        }
    }
    
    func updateUI() {
        if self.team.banner != nil {
            let url = URL(string: self.team.banner!)
            self.teamBannerImageView.kf.setImage(with: url)
        }
        self.title = self.team.name
        self.teamCountryLabel.text = self.team.country
        self.teamLeagueLabel.text = self.team.league
        if self.team.description != nil {
            self.teamDescriptionLabel.text = self.team.description
        }
    }

}

