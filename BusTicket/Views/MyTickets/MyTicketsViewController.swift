//
//  MyTicketsViewController.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 10.04.2023.
//

import UIKit

class MyTicketsViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var myTickets = [Ticket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(myTickets)
        tableView.delegate = self
        tableView.dataSource = self
        
        backButton.contentMode = .scaleToFill
        backButton.clipsToBounds = true
        
        
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "MyTicketsTableViewCell", bundle: nil), forCellReuseIdentifier: "myTicketCell")
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
extension MyTicketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTickets.count
    }
    
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
        
        return cell
    }
    
    
}
