//
//  TripsTVCell.swift
//  TravgateApp
//
//  Created by FCI on 07/02/24.
//

import UIKit

protocol TripsTVCellDelegate {
    func didTapOnTripsBtnAction(cell:TripsTVCell)
}

class TripsTVCell: TableViewCell {

    
    @IBOutlet weak var logoimg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var tapbtn: UIButton!
    
    
    var delegate:TripsTVCellDelegate?
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
        tapbtn.addTarget(self, action: #selector(didTapOnTripsBtnAction(_:)), for: .touchUpInside)
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
        logoimg.image = UIImage(named: cellInfo?.image ?? "")
        
        if cellInfo?.key == "more" {
            logoimg.isHidden = true
        }
        
    }
    
    
    
    @objc func didTapOnTripsBtnAction(_ sender:UIButton) {
        delegate?.didTapOnTripsBtnAction(cell:self)
    }
    
}
