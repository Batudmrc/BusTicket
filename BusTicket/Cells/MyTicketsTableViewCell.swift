//
//  MyTicketsTableViewCell.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 10.04.2023.
//

import UIKit

class MyTicketsTableViewCell: UITableViewCell {

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var toFromLabel: UILabel!
    
    var fromLocationTapHandler: (() -> Void)?
    var toLocationTapHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func fromLocationTap(_ sender: Any) {
        fromLocationTapHandler?()
    }
    
    @IBAction func toLocationTap(_ sender: Any) {
        toLocationTapHandler?()
    }
}
