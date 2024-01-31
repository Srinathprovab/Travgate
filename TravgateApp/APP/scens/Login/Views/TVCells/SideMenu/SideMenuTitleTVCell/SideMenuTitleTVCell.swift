//
//  SideMenuTitleTVCell.swift
//  BabSafar
//
//  Created by FCI on 20/02/23.
//

import UIKit

protocol SideMenuTitleTVCellDelegate {
    func didTaponCell(cell: SideMenuTitleTVCell)
}


class SideMenuTitleTVCell: TableViewCell {

    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var menuOptionImg: UIImageView!
    @IBOutlet weak var menuTitlelbl: UILabel!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    var delegate: SideMenuTitleTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        menuOptionImg.isHidden = false
        holderView.backgroundColor = .WhiteColor
        imgWidth.constant = 22
    }
    
    override func updateUI() {
        menuTitlelbl.text = cellInfo?.title ?? ""
        menuOptionImg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal)
        
        if cellInfo?.key == "products" {
            menuOptionImg.isHidden = true
            holderView.backgroundColor = HexColor("#E6E8E7")
            setuplabels(lbl: menuTitlelbl, text: cellInfo?.title ?? "", textcolor: .TitleColor, font: .OpenSansRegular(size: 16), align: .left)
            imgWidth.constant = 0

        } else if cellInfo?.key == "logout" {
            arrowImage.isHidden = true
        }else if cellInfo?.key == "deleteacc" {
            arrowImage.isHidden = true
            menuOptionImg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal).withTintColor(.BooknowBtnColor)
        }
    }
    
    
    func setupUI(){
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: menuTitlelbl, text: "", textcolor: .TitleColor, font: .OpenSansRegular(size: 16), align: .left)
        imgWidth.constant = 22
    }
    
    
    @IBAction func sideMenuButtonAction(_ sender: Any) {
        delegate?.didTaponCell(cell: self)
    }
    
    //MARK: - INITIAL SETUP LABELS
    func setuplabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont,align:NSTextAlignment) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
        lbl.textAlignment = align
    }
    
}
