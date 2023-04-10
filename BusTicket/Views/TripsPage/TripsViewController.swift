//
//  TripsViewController.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 5.04.2023.
//

import UIKit

class TripsViewController: UIViewController {
    
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    var trips = [BusTrip]()
    var ticket = Ticket()
    var departure = String()
    var destination = String()
    var selectedDate = String()
    var todayDateAsDate = Date()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        topButton.setTitle(selectedDate, for: .normal)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        backButton.contentMode = .scaleToFill
        backButton.clipsToBounds = true
        
        topButton.layer.borderWidth = 0.5
        topButton.layer.cornerRadius = 5
        topButton.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        
        trips.append(BusTrip(companyImage: UIImage(named: "metro")!, price: 200, departure: ticket.from!, destination: ticket.to!, time: "01:00"))
        trips.append(BusTrip(companyImage: UIImage(named: "kamilkoc")!, price: 250, departure: ticket.from!, destination: ticket.to!, time: "03:15"))
        trips.append(BusTrip(companyImage: UIImage(named: "pamukkale")!, price: 270, departure: ticket.from!, destination: ticket.to!, time: "05:45"))
        trips.append(BusTrip(companyImage: UIImage(named: "metro")!, price: 200, departure: ticket.from!, destination: ticket.to!, time: "06:00"))
        trips.append(BusTrip(companyImage: UIImage(named: "kamilkoc")!, price: 250, departure: ticket.from!, destination: ticket.to!, time: "07:15"))
        trips.append(BusTrip(companyImage: UIImage(named: "pamukkale")!, price: 270, departure: ticket.from!, destination: ticket.to!, time: "08:45"))
        trips.append(BusTrip(companyImage: UIImage(named: "metro")!, price: 200, departure: ticket.from!, destination: ticket.to!, time: "09:00"))
        trips.append(BusTrip(companyImage: UIImage(named: "kamilkoc")!, price: 250, departure: ticket.from!, destination: ticket.to!, time: "10:15"))
        trips.append(BusTrip(companyImage: UIImage(named: "pamukkale")!, price: 270, departure: ticket.from!, destination: ticket.to!, time: "11:45"))
        
        self.tableView.register(UINib(nibName: "TripsTableViewCell", bundle: nil), forCellReuseIdentifier: "tripCell")
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
extension TripsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath) as! TripsTableViewCell
        cell.selectionStyle = .none
        cell.setup(model: trips[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ticket.price = trips[indexPath.row].price
        ticket.clock = trips[indexPath.row].time
        let controller = storyboard?.instantiateViewController(withIdentifier: "SeatVC") as! SeatViewController
        controller.modalPresentationStyle = .fullScreen
        controller.ticket = ticket
        
        present(controller, animated: true)
    }
    
    
}
