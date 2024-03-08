//
//  FlightUpcomingTVCell.swift
//  Travgate
//
//  Created by FCI on 08/03/24.
//

import UIKit

protocol FlightUpcomingTVCellDelegate {
    func didTapOnViewVoucherBtnAction(cell:FlightUpcomingTVCell)
}

class FlightUpcomingTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var voucherBtn: UIButton!
    @IBOutlet weak var tvview: UIView!
    
    
    var delegate:FlightUpcomingTVCellDelegate?
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
        tvview.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        tvview.layer.cornerRadius = 8
    }
    
    
    override func updateUI() {
        
    }
    
    
    @IBAction func didTapOnViewVoucher(_ sender: Any) {
        delegate?.didTapOnViewVoucherBtnAction(cell: self)
    }
    
    
}
