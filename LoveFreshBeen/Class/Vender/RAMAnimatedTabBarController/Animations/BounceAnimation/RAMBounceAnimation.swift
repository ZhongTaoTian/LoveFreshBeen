//  RAMBounceAnimation.swift
//
// Copyright (c) 11/10/14 Ramotion Inc. (http://ramotion.com)


import UIKit


class RAMBounceAnimation : RAMItemAnimation {
    
    override func playAnimation(icon : UIImageView, textLabel : UILabel) {
        playBounceAnimation(icon)
        textLabel.textColor = textSelectedColor
    }

    override func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor) {
        textLabel.textColor = defaultTextColor
      
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = defaultTextColor

        }
    }

    override func selectedState(icon : UIImageView, textLabel : UILabel) {
        textLabel.textColor = textSelectedColor

        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }

    func playBounceAnimation(icon : UIImageView) {

        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = NSTimeInterval(duration)
        bounceAnimation.calculationMode = kCAAnimationCubic

        icon.layer.addAnimation(bounceAnimation, forKey: "bounceAnimation")
      
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
    }

}
