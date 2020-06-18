//
//  CountryViewController.swift
//  iTraveler
//
//  Created by Oleksandr Kurtsev on 18/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class CountryInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var country: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackground()
        prepareNavigationTitle()
        prepareTableView()
    }
    
    // MARK: - Private Method

    private func prepareNavigationTitle() {
        navigationController?.navigationBar.barTintColor = Colors.tropicYellow
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 30)!, .foregroundColor: Colors.tropicBlue]
        
        if country.name.count > 7 {
            navigationItem.title = country.demonym
        } else {
            navigationItem.title = country.name
        }
        
        let backButton = UIBarButtonItem(title: kButtonItemBack, style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([.font: UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 20)!], for: .normal)
    }
    
    private func prepareTableView() {
        tableView.register(CountryInfoTableViewCell.nib(), forCellReuseIdentifier: CountryInfoTableViewCell .identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
    
    // MARK: - Actions
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CountryInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryInfoTableViewCell.identifier, for: indexPath) as! CountryInfoTableViewCell
                        
        cell.configure()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension CountryInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 10
    }
}
