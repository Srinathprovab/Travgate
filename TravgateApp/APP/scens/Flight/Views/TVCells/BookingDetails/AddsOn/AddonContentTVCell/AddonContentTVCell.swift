//
//  AddonContentTVCell.swift
//  Burhantrips
//
//  Created by MA1882 on 20/01/24.
//

import UIKit

class AddonContentTVCell: UITableViewCell {

    @IBOutlet weak var checkUnCheckButton: UIButton!
    @IBOutlet weak var checkIMAGE: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var priceImage: UILabel!
    @IBOutlet weak var leftICon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
//    var isChecked = true
    var originValue = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.addCornerRadiusWithShadow(color: HexColor("#000000").withAlphaComponent(0.2), borderColor: .clear, cornerRadius: 5)
//        checkButton.setImage(UIImage(named: "redcheckBox"), for: .normal)
        checkIMAGE.image = UIImage(named: "uncheck")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func checkButtonAction(_ sender: Any) {
//}
    
}
