//
//  CardView.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 3.04.2023.
//

import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        layer.backgroundColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        //layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        //layer.cornerRadius = 10
        layer.shadowOpacity = 0.2
        //cornerRadius = 10
    }
}
