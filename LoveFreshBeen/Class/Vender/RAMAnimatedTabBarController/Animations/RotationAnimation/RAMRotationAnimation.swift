//  RAMRotationAnimation.swift
//
// Copyright (c) 11/10/14 Ramotion Inc. (http://ramotion.com)


import UIKit
import QuartzCore

enum RAMRotationDirection {
    case Left
    case Right
}

class RAMRotationAnimation : RAMItemAnimation {

    var direction : RAMRotationDirection!

    override func playAnimation(icon : UIImageView, textLabel : UILabel) {
        playRoatationAnimation(icon)
        textLabel.textColor = textSelectedColor
    }

    override func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor) {
        textLabel.textColor = defaultTextColor
      
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = defaultTextColor
        }
    }

    override func selectedState(icon : UIImageView, textLabel : UILabel) {
        textLabel.textColor = textSelectedColor
      
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }

    func playRoatationAnimation(icon : UIImageView) {

        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0

        var toValue = CGFloat(M_PI * 2.0)
        if direction != nil && direction == RAMRotationDirection.Left {
            toValue = toValue * -1.0
        }

        rotateAnimation.toValue = toValue
        rotateAnimation.duration = NSTimeInterval(duration)

        icon.layer.addAnimation(rotateAnimation, forKey: "rotation360")
      
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
    }
}

class RAMLeftRotationAnimation : RAMRotationAnimation {

    override init() {
        super.init()
        direction = RAMRotationDirection.Left
    }
}


class RAMRightRotationAnimation : RAMRotationAnimation {

    override init() {
        super.init()
        direction = RAMRotationDirection.Right
    }
}


