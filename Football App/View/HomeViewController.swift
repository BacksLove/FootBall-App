//
//  ViewController.swift
//  Football App
//
//  Created by Boubakar Traore on 05/05/2021.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter = HomePresenter()
    var allTeams = [Team]()
    var allLeagues = [String]()
    var allSelectedLeagues = [String]()
    var selectedTeam: String = ""
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        searchBar.delegate = self
        presenter.setViewDelegate(delegate: self)
        presenter.getAllLeagues()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK:- TableView

// Tableview pour l'affichage des suggestions pour l'autocomplétion

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return allSelectedLeagues.count
        } else {
            return allLeagues.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selection: String
        if searching {
            selection = allSelectedLeagues[indexPath.row]
        } else {
            selection = allLeagues[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        let cellText = cell.viewWithTag(2001) as! UILabel
        cellText.text = selection
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.text = allSelectedLeagues[indexPath.row]
        self.tableView.isHidden = true
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
        let url = URL(string: team.logo)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath)
        let cellImage = cell.viewWithTag(1001) as! UIImageView
        let cellText = cell.viewWithTag(1002) as! UILabel
        
        cellImage.kf.setImage(with: url)
        cellText.text = team.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let team: Team
        team = allTeams[indexPath.row]
        let dtvc = storyboard?.instantiateViewController(withIdentifier: "DetailTeamViewController") as? DetailTeamViewController
        dtvc?.selectedTeam = team.name
        self.navigationController?.pushViewController(dtvc!, animated: true)
    }
}

// MARK:- SearchBar

extension HomeViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.tableView.isHidden = false
        allSelectedLeagues = allLeagues.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.getAllTeams(league: searchBar.text!)
        self.tableView.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searching = false
        allSelectedLeagues = []
        allTeams = []
        self.tableView.isHidden = true
        self.collectionView.reloadData()
    }
}

// MARK:- PresenterDelegate

// Transfert des données à la vue

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
            self.tableView.reloadData()
        }
    }
}

