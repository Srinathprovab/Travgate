//
//  BookingHotelDetailsTVCell.swift
//  Travgate
//
//  Created by FCI on 19/03/24.
//

import UIKit
import AARatingBar


class BookingHotelDetailsTVCell: TableViewCell {
    
    
    @IBOutlet weak var hotelnamelbl: UILabel!
    @IBOutlet weak var hotellocationlbl: UILabel!
    @IBOutlet weak var hotelimage: UIImageView!
    @IBOutlet weak var chickinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var guestlbl: UILabel!
    @IBOutlet weak var ratingView: AARatingBar!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupui()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        
        hotelnamelbl.text = MySingleton.shared.bhotelDetials?.name ?? ""
        hotellocationlbl.text = MySingleton.shared.bhotelDetials?.address ?? ""
        chickinlbl.text = defaults.string(forKey: UserDefaultsKeys.checkin)
        checkoutlbl.text = defaults.string(forKey: UserDefaultsKeys.checkout)
        guestlbl.text = defaults.string(forKey: UserDefaultsKeys.hoteladultscount)
        ratingView.value = CGFloat(MySingleton.shared.bhotelDetials?.star_rating ?? 0)
        
        
        
        self.hotelimage.sd_setImage(with: URL(string: MySingleton.shared.bhotelDetials?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
                print("Error loading image: \(error.localizedDescription)")
                // Check if the error is due to a 404 Not Found response
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    // Set placeholder image for 404 error
                    self.hotelimage.image = UIImage(named: "noimage")
                } else {
                    // Set placeholder image for other errors
                    self.hotelimage.image = UIImage(named: "noimage")
                }
            }
        })
        
    }
    
    func setupui(){
        hotelimage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        hotelimage.layer.cornerRadius = 8
    }
    
    
    
}
