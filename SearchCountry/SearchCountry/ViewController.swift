//
//  ViewController.swift
//  SearchCountry
//
//  Created by Murat Merekov on 03.08.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var searchButton: UIBarButtonItem!
    var countryList = [Detail]()
    let reuseidentifier = "countrycell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Countries"
    
        navigationController?.navigationBar.prefersLargeTitles = true
    
        view.backgroundColor = .white
        
        searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(showSearchBar))
        self.navigationItem.rightBarButtonItem = searchButton
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Country","Capital"]
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: reuseidentifier)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        
        getCountries()
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func showSearchBar(){
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        navigationItem.rightBarButtonItem = nil
        searchBar.becomeFirstResponder()
    }
    
    func getCountries(){
        
        NetworkManager.getCountries { (data) in
          self.countryList = data
       DispatchQueue.main.async {
              self.tableView.reloadData()
            }
        }
    
}
}

extension ViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = searchButton
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            //parseData
            getCountries()
        }else{
            if searchBar.selectedScopeButtonIndex == 0{
                countryList = countryList.filter({ (detail) -> Bool in
                    return detail.name.lowercased().contains(searchText.lowercased())
                })
            }else{
                countryList = countryList.filter({ (detail) -> Bool in
                    return detail.capital.lowercased().contains(searchText.lowercased())
                })
            }
        }
        
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseidentifier, for: indexPath) as! CountryTableViewCell
        let info = countryList[indexPath.row]
        cell.configure(info)
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
}
