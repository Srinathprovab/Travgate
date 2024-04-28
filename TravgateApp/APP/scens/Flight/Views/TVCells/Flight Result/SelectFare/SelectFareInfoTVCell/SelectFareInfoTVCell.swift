//
//  SelectFareInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 22/04/24.
//

import UIKit

protocol SelectFareInfoTVCellDelegate {
    func didTapOnCloseFareBtnAction(cell:SelectFareInfoTVCell)
    func didTapOnSelectFareBtnAction(cell:SelectFareInfoTVCell)
}

class SelectFareInfoTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: BorderedView!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var fareNamelbl: UILabel!
    @IBOutlet weak var classlbl: UILabel!
    @IBOutlet weak var refundTypelbl: UILabel!
    @IBOutlet weak var baggagelbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var journytypecloaselbl: UILabel!
    
    
    var fareamount = Double()
    var indexpathDep = [IndexPath]()
    var indexpathRet = [IndexPath]()
    var journyType = String()
    var delegate:SelectFareInfoTVCellDelegate?
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
        
        closeView.isHidden = true
        selectBtn.layer.cornerRadius = 4
        
    }
    
    
    
    func configure(selected: Bool) {
        if selected {
            self.selectBtn.isHidden = true
            self.closeView.isHidden = false
            self.holderView.borderColor = UIColor.Buttoncolor
            self.holderView.backgroundColor = .LayoverColor
        } else {
            self.selectBtn.isHidden = false
            self.closeView.isHidden = true
            self.holderView.borderColor = UIColor.BorderColor
            self.holderView.backgroundColor = .WhiteColor
        }
    }
    
    
    
    
    @IBAction func didTapOnCloseFareBtnAction(_ sender: Any) {
        delegate?.didTapOnCloseFareBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSelectFareBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectFareBtnAction(cell: self)
    }
    
    
    
}
