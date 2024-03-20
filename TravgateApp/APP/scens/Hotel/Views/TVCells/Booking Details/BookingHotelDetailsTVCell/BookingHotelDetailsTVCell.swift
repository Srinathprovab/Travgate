//
//  BookingHotelDetailsTVCell.swift
//  Travgate
//
//  Created by FCI on 19/03/24.
//

import UIKit

class BookingHotelDetailsTVCell: TableViewCell {
    
    
    @IBOutlet weak var hotelnamelbl: UILabel!
    @IBOutlet weak var hotellocationlbl: UILabel!
    @IBOutlet weak var hotelimage: UIImageView!
    @IBOutlet weak var chickinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var guestlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupui()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupui(){
        hotelimage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        hotelimage.layer.cornerRadius = 8
    }
    
}
