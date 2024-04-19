//
//  SelectedHotelImageVC.swift
//  Travgate
//
//  Created by FCI on 18/03/24.
//

import UIKit

class SelectedHotelImageVC: UIViewController {

    
    @IBOutlet weak var img: UIImageView!
    
    
    static var newInstance: SelectedHotelImageVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectedHotelImageVC
        return vc
    }
    
    var imageurlString = String()
    var isvcfrom = String()
    
    override func viewWillAppear(_ animated: Bool) {
       
        
        if isvcfrom == "contact" {
            img.image = UIImage(named: imageurlString)
        }else {
            img.sd_setImage(with: URL(string: imageurlString ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.8)
        img.layer.cornerRadius = 8
    }
    

    @IBAction func didTapOnBackBtnAction(_ sender: Any) {callapibool = false
        dismiss(animated: false)
    }

}
