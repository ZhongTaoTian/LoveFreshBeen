//  RAMItemAnimationProtocol.swift
//
// Copyright (c) 11/10/14 Ramotion Inc. (http://ramotion.com)



import Foundation
import UIKit

protocol RAMItemAnimationProtocol {

    func playAnimation(icon : UIImageView, textLabel : UILabel)
    func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor)
    func selectedState(icon : UIImageView, textLabel : UILabel)
}

class RAMItemAnimation: NSObject, RAMItemAnimationProtocol {

    var duration : CGFloat = 0.5
    var textSelectedColor: UIColor = UIColor.grayColor()
    var iconSelectedColor: UIColor?

    func playAnimation(icon : UIImageView, textLabel : UILabel) {
    }

    func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor) {
    }

    func selectedState(icon: UIImageView, textLabel : UILabel) {
    }
    
}
