//
//  FlightSearchTVCell.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import UIKit

class FlightSearchTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: BorderedView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
       
    }
    
}
