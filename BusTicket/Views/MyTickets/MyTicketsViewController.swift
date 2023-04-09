//
//  MyTicketsViewController.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 10.04.2023.
//

import UIKit

class MyTicketsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var myTickets = [Ticket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(myTickets)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "MyTicketsTableViewCell", bundle: nil), forCellReuseIdentifier: "myTicketCell")
    }
    // myTicketCell
    
    
}

extension MyTicketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTicketCell", for: indexPath) as! MyTicketsTableViewCell
        cell.selectionStyle = .none
        //cell.setup(model: trips[indexPath.row])
        return cell
    }
    
    
}
