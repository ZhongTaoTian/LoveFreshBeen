//  RAMFrameItemAnimation.swift

import UIKit
import QuartzCore

class RAMFrameItemAnimation: RAMItemAnimation {

    var animationImages : Array<CGImage> = Array()

    var selectedImage : UIImage!

    var isDeselectAnimation: Bool = true
    var imagesPath: String!

    override func awakeFromNib() {

        let path = NSBundle.mainBundle().pathForResource(imagesPath, ofType:"plist")

        let dict : NSDictionary = NSDictionary(contentsOfFile: path!)!

        let animationImagesName = dict["images"] as! Array<String>
        createImagesArray(animationImagesName)

        // selected image
        let selectedImageName = animationImagesName[animationImagesName.endIndex - 1]
        selectedImage = UIImage(named: selectedImageName)
    }


    func createImagesArray(imageNames : Array<String>) {
        for name : String in imageNames {
            let image = UIImage(named: name)?.CGImage
            animationImages.append(image!)
        }
    }

    override func playAnimation(icon : UIImageView, textLabel : UILabel) {

        playFrameAnimation(icon, images:animationImages)
        textLabel.textColor = textSelectedColor
    }

    override func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor) {
        if isDeselectAnimation {
            playFrameAnimation(icon, images:animationImages.reverse())
        }

        textLabel.textColor = defaultTextColor
    }

    override func selectedState(icon : UIImageView, textLabel : UILabel) {
        icon.image = selectedImage
        textLabel.textColor = textSelectedColor
    }

    func playFrameAnimation(icon : UIImageView, images : Array<CGImage>) {
        let frameAnimation = CAKeyframeAnimation(keyPath: "contents")
        frameAnimation.calculationMode = kCAAnimationDiscrete
        frameAnimation.duration = NSTimeInterval(duration)
        frameAnimation.values = images
        frameAnimation.repeatCount = 1
        frameAnimation.removedOnCompletion = false
        frameAnimation.fillMode = kCAFillModeForwards
        icon.layer.addAnimation(frameAnimation, forKey: "frameAnimation")
    }
}
