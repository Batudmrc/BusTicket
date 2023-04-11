//
//  TripsTableViewCell.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 5.04.2023.
//

import UIKit

class TripsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var roadLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var companyImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(model: BusTrip) {
        self.roadLabel.text = " \(model.departure)   >   \(model.destination)"
        self.companyImageView.image = model.companyImage
        self.priceLabel.text = "\(model.price) TL"
        self.timeLabel.text = model.time
    }
    
}
