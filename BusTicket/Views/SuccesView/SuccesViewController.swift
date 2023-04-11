//
//  SuccesViewController.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 6.04.2023.
//

import UIKit

class SuccesViewController: UIViewController {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var chairsLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var chairs = String()
    var ticket = Ticket()
    
    var priceToCome = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toLabel.text = ticket.to
        fromLabel.text = ticket.from
        guard let id = ticket.passenger?.id else { return }
        idLabel.text = String(id)
        nameLabel.text = ticket.passenger?.name
        
        guard let selectedChairs = ticket.selectedChairs else { return }
        let selectedChairsText = selectedChairs.map { String($0) }.joined(separator: ",")
        chairsLabel.text = selectedChairsText
        guard let dates = ticket.date else { return }
        guard let clock = ticket.clock else { return }
        dateLabel.text = "\(dates.day)/\(dates.month)/\(dates.year) - \(clock)"
        guard let price = ticket.price else { return }
        totalPriceLabel.text = "\(price*ticket.selectedChairCount!) TL"
    }
    
    @IBAction func homePageTappd(_ sender: Any) {
        allTickets.append(ticket)
        let controller = storyboard?.instantiateViewController(withIdentifier: "firstVC") as! HomePageViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}
