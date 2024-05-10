//
//  SportInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

protocol SportInfoTVCellDelegate {
    func didTapOnViewTicketBtnAction(cell:SportInfoTVCell)
}

class SportInfoTVCell: TableViewCell {
    
    
    @IBOutlet weak var sportimg2: UIImageView!
    @IBOutlet weak var sportimg1: UIImageView!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var sportcitylbl: UILabel!
    @IBOutlet weak var viewTicketBtn: UIButton!
    
    
    var delegate:SportInfoTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
    }
    
    
    func setupUI() {
        viewTicketBtn.layer.cornerRadius = 4
    }
    
    
    @IBAction func didTapOnViewTicketBtnAction(_ sender: Any) {
        delegate?.didTapOnViewTicketBtnAction(cell: self)
    }
    
}
