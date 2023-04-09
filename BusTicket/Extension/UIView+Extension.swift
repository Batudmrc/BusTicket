//
//  UIView+Extension.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 1.04.2023.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
