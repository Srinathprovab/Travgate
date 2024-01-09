//
//  TDetailsLoginTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
protocol TDetailsLoginTVCellDelegate {
    func didTapOnLoginBtn(cell:TDetailsLoginTVCell)
}

class TDetailsLoginTVCell: TableViewCell {
    

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var loginImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var loginBtnView: UIView!
    @IBOutlet weak var loginlbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    var delegate:TDetailsLoginTVCellDelegate?
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
    
    
    @IBAction func didTapOnLoginBtn(_ sender: Any) {
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    
}
