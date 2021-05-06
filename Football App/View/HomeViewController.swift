//
//  ViewController.swift
//  Football App
//
//  Created by Boubakar Traore on 05/05/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let presenter = HomePresenter()
    var allTeams = [Team]()
    var allLeagues = [String]()
    var selectedTeam: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        presenter.setViewDelegate(delegate: self)
        presenter.getAllLeagues()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK:- CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTeams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let team: Team
        team = allTeams[indexPath.item]
        let url = URL(string: team.strTeamBadge)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath)
        let cellImage = cell.viewWithTag(1001) as! UIImageView
        let cellText = cell.viewWithTag(1002) as! UILabel
        
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url!) {
                cellImage.image = UIImage(data: data)
            }
        }
        cellText.text = team.strTeam
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let team: Team
        team = allTeams[indexPath.row]
        let dtvc = storyboard?.instantiateViewController(withIdentifier: "DetailTeamViewController") as? DetailTeamViewController
        dtvc?.selectedTeam = team.strTeam
        self.navigationController?.pushViewController(dtvc!, animated: true)
    }
}

// MARK:- SearchBar

extension HomeViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.getAllTeams(league: searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        allTeams = []
        self.collectionView.reloadData()
    }
}

// MARK:- PresenterDelegate

extension HomeViewController: HomePresenterDelegate {
    func getTeamsLeague(teams: [Team]) {
        DispatchQueue.main.async {
            self.allTeams = teams
            self.collectionView.reloadData()
        }
    }
    
    func getAllLeagues(leagues: [String]) {
        DispatchQueue.main.async {
            self.allLeagues = leagues
        }
    }
}

