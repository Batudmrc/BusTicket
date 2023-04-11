//
//  CitiesTableViewController.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 3.04.2023.
//

import UIKit


protocol CitiesTableViewControllerDelegate {
    func citiesTableViewControllerDidSelect(city: String, forLabel label: UILabel)
}

class CitiesTableViewController: UITableViewController, UISearchBarDelegate {
    
    var filteredCities = [String]()
    let searchBar:UISearchBar = UISearchBar()
    var delegate: CitiesTableViewControllerDelegate?
    
    var cities = [ "Adana", "Adıyaman", "Afyon", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta", "Mersin", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"]
    
    var isSearchBarEmpty: Bool {
        return searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return !isSearchBarEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = searchBar
        view.backgroundColor = .white
        setupSearchBar()
        tableView.register (UITableViewCell.self, forCellReuseIdentifier: "ItemCell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCities.count
        }
        return cities.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var city = String()
        if isFiltering {
            city = filteredCities[indexPath.row]
        } else if isFiltering == false {
            city = cities[indexPath.row]
        }
        let selectedCity = city
        let selectedLabel = selection
        delegate?.citiesTableViewControllerDidSelect(city: selectedCity, forLabel: selectedLabel)
        searchBar.text = ""
        filteredCities = []
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        var city: String
        if isFiltering {
            city = filteredCities[indexPath.row]
        } else {
            city = cities[indexPath.row]
        }
        cell.textLabel?.text = city
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.1) {
            cell.alpha = 1
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        filteredCities = cities.filter({$0.lowercased().contains(textSearched.lowercased())})
        tableView.reloadData()
    }
    
    func filterContextForSearchText(searchText: String) {
        filteredCities = cities.filter({ (text:String) -> Bool in
            return text.lowercased().contains(searchText.lowercased())
        }
        )
    }
    
    func setupSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Şehir seçiniz "
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        view.addSubview(searchBar)
    }
    
}
