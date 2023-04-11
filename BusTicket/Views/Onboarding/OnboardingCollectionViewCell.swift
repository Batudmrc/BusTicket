//
//  OnboardingCollectionViewCell.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 1.04.2023.
//

import UIKit
import Lottie
class OnboardingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var LottieAnimationView: LottieAnimationView!
    @IBOutlet weak var slideDescription: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    func setup(_ slide: OnboardingSlide) {
        
        title.text = slide.title
        slideDescription.text = slide.description
        let animation = LottieAnimation.named(slide.image!)
        
        LottieAnimationView.animation = animation
        LottieAnimationView.loopMode = .loop
        if !LottieAnimationView.isAnimationPlaying{ LottieAnimationView.play() }
    }
    
    }
