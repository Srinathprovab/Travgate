//
//  BookingSucessVC.swift
//  BabSafar
//
//  Created by FCI on 25/08/23.
//

import UIKit

class BookingSucessVC: UIViewController {
    
    
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    
    static var newInstance: BookingSucessVC? {
        let storyboard = UIStoryboard(name: Storyboard.Calender.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingSucessVC
        return vc
    }
    
    
    var voucherUrl = String()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view.
        if let gifPath = Bundle.main.path(forResource: "sucessful", ofType: "gif") {
            if let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) {
                
                let jeremyGif = UIImage.animatedGif(from: gifData)
                self.gifImageView.image = jeremyGif
                
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.gotoBookingConfirmedVC()
        }
       
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
       
    }
    
    func gotoBookingConfirmedVC() {
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
}

extension UIImage {
    static func animatedGif(named: String, framesPerSecond: Double = 10) -> UIImage? {
        guard let asset = NSDataAsset(name: named) else { return nil }
        return animatedGif(from: asset.data, framesPerSecond: framesPerSecond)
    }
    
    static func animatedGif(from data: Data, framesPerSecond: Double = 10) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        let imageCount = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        for i in 0 ..< imageCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
        }
        return UIImage.animatedImage(with: images, duration: Double(images.count) / framesPerSecond)
    }
}
