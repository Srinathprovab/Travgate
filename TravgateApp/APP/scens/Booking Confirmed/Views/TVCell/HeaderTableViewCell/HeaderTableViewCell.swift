//
//  HeaderTableViewCell.swift
//  Travgate
//
//  Created by FCI on 01/03/24.
//

import UIKit
protocol HeaderTableViewCellDelegate {
    func didTapOnFacebookLinkBtnAction(cell:HeaderTableViewCell)
    func didTapOnTwitterLinkBtnAction(cell:HeaderTableViewCell)
    func didTapOnLinkedlnLinkBtnAction(cell:HeaderTableViewCell)
    func didTapOnInstagramLinkBtnAction(cell:HeaderTableViewCell)
}

class HeaderTableViewCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var copyrightlbl: UILabel!
    
    
    var delegate:HeaderTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        titlelbl.text = bottom_text_info[0].bottom_text?.htmlToString
        copyrightlbl.text = bottom_text_info[0].copy_right_text
    }
    
    
    
    @IBAction func didTapOnFacebookLinkBtnAction(_ sender: Any) {
        delegate?.didTapOnFacebookLinkBtnAction(cell: self)
    }
    
    @IBAction func didTapOnTwitterLinkBtnAction(_ sender: Any) {
        delegate?.didTapOnTwitterLinkBtnAction(cell: self)
    }
    
    @IBAction func didTapOnLinkedlnLinkBtnAction(_ sender: Any) {
        delegate?.didTapOnLinkedlnLinkBtnAction(cell: self)
    }
    
    @IBAction func didTapOnInstagramLinkBtnAction(_ sender: Any) {
        delegate?.didTapOnInstagramLinkBtnAction(cell: self)
    }
    
    
}
