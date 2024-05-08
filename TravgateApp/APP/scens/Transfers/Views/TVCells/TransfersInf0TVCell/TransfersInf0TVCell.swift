//
//  TransfersInf0TVCell.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit
protocol TransfersInf0TVCellDelegate {
    func didTapOnBookNowBtnAction(cell:TransfersInf0TVCell)
}

class TransfersInf0TVCell: TableViewCell {
    

    var delegate:TransfersInf0TVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
}
