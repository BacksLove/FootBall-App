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
        if self.team.strTeamBanner != nil {
            let url = URL(string: self.team.strTeamBanner!)
            self.teamBannerImageView.kf.setImage(with: url)
        }
        self.title = self.team.strTeam
        self.teamCountryLabel.text = self.team.strCountry
        self.teamLeagueLabel.text = self.team.strLeague
        if self.team.strDescriptionEN != nil {
            self.teamDescriptionLabel.text = self.team.strDescriptionEN
        }
    }

}

