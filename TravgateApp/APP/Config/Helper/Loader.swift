//
//  Loader.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 05/05/22.
//

import Foundation
import MBProgressHUD
import SDWebImage

class Loader {
    
    static func showAdded(to view: UIView, animated: Bool) {
        DispatchQueue.main.async {
            
            
          
            
            
            if basicloderBool == true {
                
                DispatchQueue.main.async {
                    ProgressHUD.animationType = .lineSpinFade
                    ProgressHUD.colorAnimation = .Buttoncolor
                    ProgressHUD.show()
                }
                
            }else {
                if loderBool == false {
                    loaderShow(loder: "loder", v: view)
                }else {
                    //loaderShow(loder: "loder", v: view)
                }
            }
            
            
            
        }
        
//
        func loaderShow(loder:String,v:UIView) {

            let HUD = MBProgressHUD.showAdded(to: v, animated: true)
            let imageViewAnimatedGif = UIImageView()
            //The key here is to save the GIF file or URL download directly into a NSData instead of making it a UIImage. Bypassing UIImage will let the GIF file keep the animation.

            var filePath = Bundle.main.path(forResource: loder, ofType: "gif") ?? ""

            let gifData = NSData(contentsOfFile: filePath) as Data?
            imageViewAnimatedGif.image = UIImage.sd_image(withGIFData: gifData)
            HUD.customView = UIImageView(image: imageViewAnimatedGif.image)
            var rotation: CABasicAnimation?
            rotation = CABasicAnimation(keyPath: "transform.rotation")
            rotation?.fromValue = nil
            // If you want to rotate Gif Image Uncomment
            //  rotation?.toValue = CGFloat.pi * 2
            rotation?.duration = 0.7
            rotation?.isRemovedOnCompletion = false
            HUD.customView?.layer.add(rotation!, forKey: "Spin")
            HUD.mode = MBProgressHUDMode.customView
            // Change hud bezelview Color and blurr effect
            HUD.bezelView.color = UIColor.clear
            HUD.bezelView.tintColor = UIColor.clear
            HUD.bezelView.style = .solidColor
            HUD.bezelView.blurEffectStyle = .dark
            // Speed
            rotation?.repeatCount = .infinity
            HUD.show(animated: true)
        }
        
        
//        func loaderShow(loader: String, text: String, v: UIView) {
//            let HUD = MBProgressHUD.showAdded(to: v, animated: true)
//
//            // Load the GIF image
//            let imageViewAnimatedGif = UIImageView()
//            let filePath = Bundle.main.path(forResource: loader, ofType: "gif") ?? ""
//            let gifData = NSData(contentsOfFile: filePath) as Data?
//            imageViewAnimatedGif.image = UIImage.sd_image(withGIFData: gifData)
//
//            // Set up the custom view with GIF and label
//            let customView = UIView()
//            customView.addSubview(imageViewAnimatedGif)
//
//            // Add label below the GIF
//            let label = UILabel()
//            label.text = text
//            label.textAlignment = .center
//            label.textColor = UIColor.black
//            label.font = UIFont.systemFont(ofSize: 14)
//            customView.addSubview(label)
//
//            // Positioning the label below the GIF
//            imageViewAnimatedGif.translatesAutoresizingMaskIntoConstraints = false
//            label.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                imageViewAnimatedGif.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
//                imageViewAnimatedGif.topAnchor.constraint(equalTo: customView.topAnchor),
//
//                label.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
//                label.topAnchor.constraint(equalTo: imageViewAnimatedGif.bottomAnchor, constant: 8), // Adjust the constant as needed
//            ])
//
//            HUD.customView = customView
//
//            // Set up rotation animation
//            var rotation: CABasicAnimation?
//            rotation = CABasicAnimation(keyPath: "transform.rotation")
//            rotation?.fromValue = nil
//            rotation?.toValue = CGFloat.pi * 2
//            rotation?.duration = 0.7
//            rotation?.isRemovedOnCompletion = false
//            HUD.customView?.layer.add(rotation!, forKey: "Spin")
//
//            HUD.mode = MBProgressHUDMode.customView
//            HUD.bezelView.color = UIColor.clear
//            HUD.bezelView.tintColor = UIColor.clear
//            HUD.bezelView.style = .solidColor
//            HUD.bezelView.blurEffectStyle = .dark
//            rotation?.repeatCount = .infinity
//
//            HUD.show(animated: true)
//        }

    
    }
    
    
    
    
    static func hide(for view: UIView, animated: Bool) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
            ProgressHUD.dismiss()
        }
    }
    
    
}
