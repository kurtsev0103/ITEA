//
//  MainViewController.swift
//  iTraveler
//
//  Created by Oleksandr Kurtsev on 16/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCountries = Countries()
    private var countries = Countries()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCountries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackground()
        prepareButtons()
        prepareTableView()
        prepareNavigationTitle()
        prepareSearchController()
    }
    
    // MARK: - Private Method
    
    private func prepareSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = kSearchPlaceholder
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func prepareButtons() {
        logoutButton.backgroundColor = .clear
        logoutButton.setImage(UIImage(named: kNameAccountImage), for: .normal)
        logoutButton.layer.borderColor = UIColor.darkGray.cgColor
        logoutButton.layer.borderWidth = 2
        logoutButton.layer.cornerRadius = logoutButton.frame.height / 2
        logoutButton.clipsToBounds = true
    }
    
    private func prepareNavigationTitle() {
        navigationController?.navigationBar.barTintColor = Colors.tropicYellow
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 30)!, .foregroundColor: Colors.tropicOrange]
        navigationItem.title = kMainVCTitle
    }
    
    private func prepareTableView() {
        tableView.register(CountryTableViewCell.nib(), forCellReuseIdentifier: CountryTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
    
    private func fetchCountries() {
        NetworkManager.shared.requestApi(stringURL: "https://restcountries-v1.p.rapidapi.com/all", method: .GET) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                if let contriesArray = NetworkHelpers.shared.parseCountries(data) {
                    self.countries = contriesArray
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func logoutAction(_ sender: UIButton) {
        showLogoutActionSheet() {
            do {
                try Auth.auth().signOut()
                self.goToAuthViewController()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCountries.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as! CountryTableViewCell
                        
        if isFiltering {
            cell.configure(withCountry: filteredCountries[indexPath.row])
        } else {
            cell.configure(withCountry: countries[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "CountryViewController") as! CountryInfoViewController
        
        if isFiltering {
            vc.country = filteredCountries[indexPath.row]
        } else {
            vc.country = countries[indexPath.row]
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 10
    }
}

// MARK: UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        guard isFiltering else {
            tableView.reloadData()
            return
        }
        filterContentForSearchText(text)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        NetworkManager.shared.requestApi(stringURL: "https://restcountries-v1.p.rapidapi.com/name/\(searchText)", method: .GET) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                if let contriesArray = NetworkHelpers.shared.parseCountries(data) {
                    self.filteredCountries = contriesArray
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
