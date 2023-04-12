//
//  MyTicketsViewController.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 10.04.2023.
//

import UIKit
import MapKit
import Contacts

class MyTicketsViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var myTickets = [Ticket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        backButton.contentMode = .scaleToFill
        backButton.clipsToBounds = true
        
        delayedDisappear()
        topLabel.layer.borderWidth = 0.5
        topLabel.layer.cornerRadius = 5
        topLabel.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        
        
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "MyTicketsTableViewCell", bundle: nil), forCellReuseIdentifier: "myTicketCell")
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    // Making label disappear with animation after 3 seconds
    func delayedDisappear(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            UIView.animate(withDuration: 0.4, animations: {
                self.topLabel.alpha = 0.0
                self.topLabel.transform = CGAffineTransform(translationX: 0, y: -self.topLabel.frame.size.height)
            }) { (_) in
                self.topLabel.isHidden = true
            }
        }
    }
    // Func to do maps search
    func searchInAppleMaps(city: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "\(city) otogar"
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.1885, longitude: 29.0610), latitudinalMeters: 10000, longitudinalMeters: 10000)
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let error = error {
                print("Error performing search: \(error.localizedDescription)")
                return
            }
            if let mapItems = response?.mapItems, !mapItems.isEmpty {
                let mapItem = mapItems[0]
                mapItem.openInMaps(launchOptions: nil)
            } else {
                let alert = UIAlertController(title: "Sonuç Bulunamadı", message: "Böyle bir sonuç bulunamadıd", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
extension MyTicketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTickets.count
    }
    // Formatting the day and month to be a string
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var day = String()
        var month = String()
        let year = allTickets[indexPath.row].date?.year
        let clock = allTickets[indexPath.row].clock
        // Formatting Month
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        if let date = dateFormatter.date(from: allTickets[indexPath.row].date!.month) {
            dateFormatter.dateFormat = "MMMM"
            month = dateFormatter.string(from: date)
        } else {
            print("Invalid month")
        }
        // Formatting Day
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let dayNumber = numberFormatter.number(from: allTickets[indexPath.row].date!.day) {
            day = String(dayNumber.intValue)
        } else {
            print("Invalid day")
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTicketCell", for: indexPath) as! MyTicketsTableViewCell
        let price = String(allTickets[indexPath.row].price!)
        let seatLabelString = allTickets[indexPath.row].selectedChairs!.map { String($0) }.joined(separator: ",")
        let from = allTickets[indexPath.row].from
        let to = allTickets[indexPath.row].to
        
        cell.selectionStyle = .none
        cell.dateTimeLabel.text = "\(day) \(month) 20\(year!) - \(clock!)"
        cell.nameLabel.text = allTickets[indexPath.row].passenger?.name
        cell.priceLabel.text = "\(price) TL"
        cell.seatLabel.text = seatLabelString
        cell.toFromLabel.text = "\(from!) - \(to!)"
        cell.totalPriceLabel.text = "\(String(allTickets[indexPath.row].price!*allTickets[indexPath.row].selectedChairs!.count)) TL"
        cell.fromLocationTapHandler = {
            self.searchInAppleMaps(city: from!)
        }
        cell.toLocationTapHandler = {
            self.searchInAppleMaps(city: to!)
        }
        
        return cell
    }
    
    
}
