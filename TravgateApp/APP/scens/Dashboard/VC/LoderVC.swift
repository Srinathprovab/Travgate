//
//  LoderVC.swift
//  TravgateApp
//
//  Created by FCI on 08/02/24.
//

import UIKit

class LoderVC: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var gifimg: UIImageView!
    @IBOutlet weak var triptypelbl: UILabel!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    

    var gifImages: [UIImage] = []
    var currentFrame: Int = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        img.layer.cornerRadius = 40
        loadGifFrames()
        startGifAnimation()
       
    }
    
    
    func setupUI() {
        
        cityslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "") To \(defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "")"
        
        
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))"
        }else {
            datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM")) - \(MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))"
        }
        
       
        triptypelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.journeyType) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "") Travellers"
   
        
    }
    
    
    func loadGifFrames() {
        // Replace "your_gif_file" with the name of your GIF file (without extension)
        if let gifURL = Bundle.main.url(forResource: "loder", withExtension: "gif"),
           let gifSource = CGImageSourceCreateWithURL(gifURL as CFURL, nil) {
            let frameCount = CGImageSourceGetCount(gifSource)
            
            for index in 0..<frameCount {
                if let cgImage = CGImageSourceCreateImageAtIndex(gifSource, index, nil) {
                    let uiImage = UIImage(cgImage: cgImage)
                    gifImages.append(uiImage)
                }
            }
        }
    }
    
    func startGifAnimation() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(updateGifFrame), userInfo: nil, repeats: true)
    }
    
    @objc func updateGifFrame() {
        gifimg.image = gifImages[currentFrame]
        currentFrame += 1
        
        if currentFrame >= gifImages.count {
            currentFrame = 0
        }
    }
    
    // Don't forget to invalidate the timer when the view controller is deallocated
    deinit {
        timer?.invalidate()
    }
    
}
