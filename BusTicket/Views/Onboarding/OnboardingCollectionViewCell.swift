//
//  OnboardingCollectionViewCell.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 1.04.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideDescription: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func setup(_ slide: OnboardingSlide) {
        imageView.image = slide.image
        title.text = slide.title
        slideDescription.text = slide.description
    }
}
