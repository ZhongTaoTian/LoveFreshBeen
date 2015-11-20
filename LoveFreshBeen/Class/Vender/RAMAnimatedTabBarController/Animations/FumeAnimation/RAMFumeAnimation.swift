
//  RAMFumeAnimation.swift
import UIKit

class RAMFumeAnimation : RAMItemAnimation {

    override func playAnimation(icon : UIImageView, textLabel : UILabel) {
        playMoveIconAnimation(icon, values:[icon.center.y, icon.center.y + 4.0])
        playLabelAnimation(textLabel)
        textLabel.textColor = textSelectedColor
      
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }

    override func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor) {
        playMoveIconAnimation(icon, values:[icon.center.y + 4.0, icon.center.y])
        playDeselectLabelAnimation(textLabel)
        textLabel.textColor = defaultTextColor
      
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = defaultTextColor
        }
    }

    override func selectedState(icon : UIImageView, textLabel : UILabel) {

        playMoveIconAnimation(icon, values:[icon.center.y + 8.0])
        textLabel.alpha = 0
        textLabel.textColor = textSelectedColor
      
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }

    func playMoveIconAnimation(icon : UIImageView, values: [AnyObject]) {

        let yPositionAnimation = createAnimation("position.y", values:values, duration:duration / 2)

        icon.layer.addAnimation(yPositionAnimation, forKey: "yPositionAnimation")
    }

    // MARK: select animation

    func playLabelAnimation(textLabel: UILabel) {

        let yPositionAnimation = createAnimation("position.y", values:[textLabel.center.y, textLabel.center.y - 60.0], duration:duration)
        yPositionAnimation.fillMode = kCAFillModeRemoved
        yPositionAnimation.removedOnCompletion = true
        textLabel.layer.addAnimation(yPositionAnimation, forKey: "yLabelPostionAnimation")

        let scaleAnimation = createAnimation("transform.scale", values:[1.0 ,2.0], duration:duration)
        scaleAnimation.fillMode = kCAFillModeRemoved
        scaleAnimation.removedOnCompletion = true
        textLabel.layer.addAnimation(scaleAnimation, forKey: "scaleLabelAnimation")

        let opacityAnimation = createAnimation("opacity", values:[1.0 ,0.0], duration:duration)
        textLabel.layer.addAnimation(opacityAnimation, forKey: "opacityLabelAnimation")
    }

    func createAnimation(keyPath: String, values: [AnyObject], duration: CGFloat)->CAKeyframeAnimation {
      
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.values = values
        animation.duration = NSTimeInterval(duration)
        animation.calculationMode = kCAAnimationCubic
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        return animation
    }

    // MARK: deselect animation

    func playDeselectLabelAnimation(textLabel: UILabel) {
      
        let yPositionAnimation = createAnimation("position.y", values:[textLabel.center.y + 15, textLabel.center.y], duration:duration)
        textLabel.layer.addAnimation(yPositionAnimation, forKey: "yLabelPostionAnimation")

        let opacityAnimation = createAnimation("opacity", values:[0, 1], duration:duration)
        textLabel.layer.addAnimation(opacityAnimation, forKey: "opacityLabelAnimation")
    }

}
