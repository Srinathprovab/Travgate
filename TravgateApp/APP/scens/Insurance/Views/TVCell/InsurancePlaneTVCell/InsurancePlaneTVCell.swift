//
//  InsurancePlaneTVCell.swift
//  Travgate
//
//  Created by FCI on 11/05/24.
//

import UIKit

protocol InsurancePlaneTVCellDelegate {
    func didTapOnSelectPlanBtnAction(cell:InsurancePlaneTVCell)
    func didTapOnPremiumDetailsBtnAction(cell:InsurancePlaneTVCell)
}

class InsurancePlaneTVCell: TableViewCell {
    
    
    @IBOutlet weak var selectPlanBtn: UIButton!
    @IBOutlet weak var premiumDetailsBtn: UIButton!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var travelMaxCV: UICollectionView!
    @IBOutlet weak var travelMaxTV: UITableView!
    
    
    
    var titleArray = ["Medical Assistance (Including Covid 19) :",
                      "Personal Assistance Services :",
                      "Losses & Delays :",
                      "Personal Accident:",
                      "Personal Accident:"]
    var subtitleArray = [" 450 uSD",
                         " 24 hours assistance services including Hijacking",
                         " Loss of Ids abroad, inflight losses, baggage or flight delays",
                         " 50,000 USD",
                         " 50,000 USD"]
    var travelmaxArray = ["Worldwide Excluding USA and Canada",
                          "TRVLPLUS",
                          "TRAVEL+ USD 50,000",
                          "10 DAYS SINGLE TRIP"]
    
    var delegate:InsurancePlaneTVCellDelegate?
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
        if cellInfo?.key == "plan" {
            selectPlanBtn.isHidden = true
        }else {
            selectPlanBtn.isHidden = false
        }
        
        
        
        travelMaxTV.reloadData()
    }
    
    
    func setupUI(){
        selectPlanBtn.layer.cornerRadius = 4
        premiumDetailsBtn.layer.cornerRadius = 4
        
        MySingleton.shared.setAttributedTextnew(str1: "6.2",
                                                str2: "kwd",
                                                lbl: pricelbl,
                                                str1font: .OpenSansBold(size: 24),
                                                str2font: .OpenSansRegular(size: 12),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        setupTV()
        setupCV()
        
    }
    
    
    
    
    
    @IBAction func didTapOnSelectPlanBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectPlanBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnPremiumDetailsBtnAction(_ sender: Any) {
        delegate?.didTapOnPremiumDetailsBtnAction(cell: self)
    }
    
    
}



extension InsurancePlaneTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func setupCV() {
        
        let nib = UINib(nibName: "TravelMaxCVCell", bundle: nil)
        travelMaxCV.register(nib, forCellWithReuseIdentifier: "cell")
        travelMaxCV.delegate = self
        travelMaxCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        // layout.itemSize = CGSize(width: 90, height: 30)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        travelMaxCV.collectionViewLayout = layout
        travelMaxCV.bounces = false
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return travelmaxArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TravelMaxCVCell {
            
            cell.titlelbl.text = travelmaxArray[indexPath.row]
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = travelmaxArray[indexPath.item]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 30, height: 25)
    }
    
    
}


extension InsurancePlaneTVCell: UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        travelMaxTV.register(UINib(nibName: "TravelMaxTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        travelMaxTV.delegate = self
        travelMaxTV.dataSource = self
        travelMaxTV.tableFooterView = UIView()
        travelMaxTV.showsHorizontalScrollIndicator = false
        travelMaxTV.separatorStyle = .singleLine
        travelMaxTV.isScrollEnabled = false
        travelMaxTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TravelMaxTVCell {
            
            
            
            MySingleton.shared.setAttributedTextnew(str1: "\(titleArray[indexPath.row])",
                                                    str2: "\(subtitleArray[indexPath.row])",
                                                    lbl: cell.titlelbl,
                                                    str1font: .OpenSansMedium(size: 14),
                                                    str2font: .OpenSansRegular(size: 14),
                                                    str1Color: .TitleColor,
                                                    str2Color: .SubtitleColor)
            
            
            
            
            
            c = cell
            
        }
        return c
    }
    
}
