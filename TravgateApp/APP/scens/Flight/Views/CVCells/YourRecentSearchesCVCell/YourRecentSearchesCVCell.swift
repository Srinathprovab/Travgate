//
//  YourRecentSearchesCVCell.swift
//  TravgateApp
//
//  Created by FCI on 07/02/24.
//

import UIKit

protocol YourRecentSearchesCVCellDelegate {
    func didTapOnCloserecentSearchBtnAction(cell:YourRecentSearchesCVCell)
    func didTapOnSearchRecentFlightsBtnAction(cell:YourRecentSearchesCVCell)
}

class YourRecentSearchesCVCell: UICollectionViewCell {

    
    
    @IBOutlet weak var tripTypelbl: UILabel!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var classlbl: UILabel!
    
 
    
    var carrier = String()
    var adult = String()
    var from_loc_id = String()
    var currency = String()
    var trip_type = String()
    var to_loc_id = String()
    var to_custom = String()
    var sector_type = String()
    var from = String()
    var user_id = String()
    var from_custom = String()
    var child = String()
    var sreturn = String()
    var search_source = String()
    var psscarrier = String()
    var infant = String()
    var search_flight = String()
    var depature = String()
    var to = String()
    var origin = String()
    var v_class = String()
    var fcityname = String()
    var tcityname = String()
    
    var delegate:YourRecentSearchesCVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func didTapOnCloserecentSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnCloserecentSearchBtnAction(cell: self)
    }
    
    @IBAction func didTapOnSearchRecentFlightsBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchRecentFlightsBtnAction(cell: self)
    }
    
}
