//
//  BaggageInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 14/02/24.
//

import UIKit

class BaggageInfoTVCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var carronbaggagelbl: UILabel!
    @IBOutlet weak var checkedinbaggagelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        
        if cellInfo?.title == "0" {
            titlelbl.text = "Departure"
        }else {
            titlelbl.text = "Return"
        }
        
        
        cityslbl.text = cellInfo?.subTitle ?? ""
        //   carronbaggagelbl.text = cellInfo?.buttonTitle ?? ""
        
        
        let convertedString = MySingleton.shared.convertToDesiredFormat(cellInfo?.text ?? "0 Kg")
        if convertedString != "Invalid input format." {
            checkedinbaggagelbl.text = convertedString
        } else {
            checkedinbaggagelbl.text = "0Kg"
        }

       
        let convertedString1 = MySingleton.shared.convertToDesiredFormat(cellInfo?.buttonTitle ?? "0 Kg")
        if convertedString1 != "Invalid input format." {
            carronbaggagelbl.text = convertedString1
        } else {
            carronbaggagelbl.text = "0Kg"
        }
        
    }
    
}
