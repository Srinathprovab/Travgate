//
//  TabSelectTVCell.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit
import EasyTipView




protocol TabSelectTVCellDelegate {
    
    func didTapOnMenuBtnAction(cell:TabSelectTVCell)
    func didTapOnSelectCurrencyBtnAction(cell:TabSelectTVCell)
    func didTapOnFlightTabSelectBtnAction(cell:TabSelectTVCell)
    func didTapOnHotelTabSelect(cell:TabSelectTVCell)
    func didTapOnMoreServiceBtnAction(cell:TabSelectTVCell)
    func didTapOnClosebtnAction(cell:TabSelectTVCell)
    func didTapOnVisabtnAction(cell:TabSelectTVCell)
    func didTapOnHolidaysbtnAction(cell:TabSelectTVCell)
    func didTapOnTransfersbtnAction(cell:TabSelectTVCell)
    func didTapOnSportsbtnAction(cell:TabSelectTVCell)
    func didTapOnCruisebtnAction(cell:TabSelectTVCell)
    func didTapOnAutopaybtnAction(cell:TabSelectTVCell)
    func didTapOnInsurencebtnAction(cell:TabSelectTVCell)
}


class TabSelectTVCell: TableViewCell {
    
    
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var flightView: UIView!
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var moreserviceView: UIView!
    @IBOutlet weak var moreServiceCV: UICollectionView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    var serviceArray = ["Visa","Holidays","Transfers","Sports","Cruise","Auto pay","Insurence"]
    var serviceImgsArray = ["s1","s2","s3","sports","s5","s6","s7"]
    var delegate:TabSelectTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupmoreServiceCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        currencylbl.text = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        switch MySingleton.shared.tabselect {
            
        case "flight":
            taponflightView()
            break
            
        case "hotel":
            taponflightView()
            break
            
        case "more":
            taponflightView()
            break
            
            
        default:
            break
        }
        
//        MySingleton.shared.setupTipView(arrowPosition: .top)
//        let tipView =  EasyTipView(text: "Select Flight", preferences: MySingleton.shared.preferences)
//        tipView.show(forView: self.flightView, withinSuperview: self.contentView)
//        
        
        
    }
    
    
    
    func setupmoreServiceCV() {
        
        
        let nib = UINib(nibName: "MoreServiceCVCell", bundle: nil)
        moreServiceCV.register(nib, forCellWithReuseIdentifier: "cell1")
        moreServiceCV.delegate = self
        moreServiceCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 90)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        moreServiceCV.collectionViewLayout = layout
        moreServiceCV.isScrollEnabled = false
        
    }
    
    @IBAction func didTapOnClosebtnAction(_ sender: Any) {
        moreserviceView.isHidden = true
        delegate?.didTapOnClosebtnAction(cell: self)
    }
    
    @IBAction func didTapOnSelectCurrencyBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectCurrencyBtnAction(cell: self)
    }
    
    @IBAction func didTapOnFlightTabSelectBtnAction(_ sender: Any) {
        taponflightView()
        delegate?.didTapOnFlightTabSelectBtnAction(cell: self)
    }
    
    @IBAction func didTapOnHotelTabSelect(_ sender: Any) {
        taponhotelView()
        delegate?.didTapOnHotelTabSelect(cell: self)
    }
    
    
    @IBAction func didTapOnMenuBtnAction(_ sender: Any) {
        delegate?.didTapOnMenuBtnAction(cell: self)
    }
    
    @IBAction func didTapOnMoreServiceBtnAction(_ sender: Any) {
        // NotificationCenter.default.post(name: NSNotification.Name("moreservice"), object: nil)
        moreserviceView.isHidden = false
        taponmoreView()
        delegate?.didTapOnMoreServiceBtnAction(cell: self)
    }
    
    func taponflightView(){
        
        MySingleton.shared.tabselect = "flight"
        //        flightView.layer.borderColor = UIColor.Buttoncolor.cgColor
        //        hotelView.layer.borderColor = UIColor.BorderColor.cgColor
        //        moreView.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    func taponhotelView(){
        MySingleton.shared.tabselect = "hotel"
        //        flightView.layer.borderColor = UIColor.BorderColor.cgColor
        //        hotelView.layer.borderColor = UIColor.Buttoncolor.cgColor
        //        moreView.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    func taponmoreView(){
        MySingleton.shared.tabselect = "more"
        //        flightView.layer.borderColor = UIColor.BorderColor.cgColor
        //        hotelView.layer.borderColor = UIColor.BorderColor.cgColor
        //        moreView.layer.borderColor = UIColor.Buttoncolor.cgColor
    }
    
}



extension TabSelectTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? MoreServiceCVCell {
            cell.titlelbl.text = serviceArray[indexPath.row]
            cell.img.image = UIImage(named: serviceImgsArray[indexPath.row])?.withRenderingMode(.alwaysOriginal)
            
            
            // Check if the cell is selected and set its border color accordingly
            if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
                cell.layer.borderColor = UIColor.BooknowBtnColor.cgColor
            } else {
                cell.layer.borderColor = UIColor.BorderColor.cgColor // or any other normal border color
            }
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MoreServiceCVCell {
            cell.holderView.layer.borderColor = UIColor.Buttoncolor.cgColor
            
            switch cell.titlelbl.text {
                
            case "Visa":
                delegate?.didTapOnVisabtnAction(cell: self)
                break
                
            case "Holidays":
                delegate?.didTapOnHolidaysbtnAction(cell: self)
                break
                
            case "Transfers":
                delegate?.didTapOnTransfersbtnAction(cell: self)
                break
                
            case "Sports":
                delegate?.didTapOnSportsbtnAction(cell: self)
                break
                
            case "Cruise":
                delegate?.didTapOnCruisebtnAction(cell: self)
                break
                
            case "Auto pay":
                delegate?.didTapOnAutopaybtnAction(cell: self)
                break
                
                
            case "Insurence":
                delegate?.didTapOnInsurencebtnAction(cell: self)
                break
                
                
            default:
                break
            }
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MoreServiceCVCell {
            cell.holderView.layer.borderColor = UIColor.BorderColor.cgColor
        }
        
    }
    
    
}
