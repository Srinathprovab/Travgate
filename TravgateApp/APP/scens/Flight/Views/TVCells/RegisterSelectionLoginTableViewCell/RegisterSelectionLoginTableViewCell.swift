//
//  RegisterSelectionLoginTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23.
//

import UIKit

protocol RegisterSelectionLoginTableViewCellDelegate {
    func didTapOnguestButton(cell: RegisterSelectionLoginTableViewCell)
    func registerButton(cell: RegisterSelectionLoginTableViewCell)
    func loginButton(cell: RegisterSelectionLoginTableViewCell)
}

class RegisterSelectionLoginTableViewCell: TableViewCell {
    
    @IBOutlet weak var guestRadioImage: UIImageView!
    @IBOutlet weak var registerRadioImage: UIImageView!
    @IBOutlet weak var loginRadioImage: UIImageView!
    var delegate: RegisterSelectionLoginTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func guestButtonAction(_ sender: Any) {
        delegate?.didTapOnguestButton(cell: self)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        delegate?.registerButton(cell: self)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        delegate?.loginButton(cell: self)
    }
    
}
