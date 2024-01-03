//
//  MoreServiceTVCell.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import UIKit

protocol MoreServiceTVCellDelegate {
    func didTapOnClosebtnAction(cell:MoreServiceTVCell)
    
    func didTapOnVisabtnAction(cell:MoreServiceTVCell)
    func didTapOnInsurancebtnAction(cell:MoreServiceTVCell)
    func didTapOnTransfersbtnAction(cell:MoreServiceTVCell)
    func didTapOnActivitiesbtnAction(cell:MoreServiceTVCell)
    func didTapOnCruisebtnAction(cell:MoreServiceTVCell)
    func didTapOnAutopaybtnAction(cell:MoreServiceTVCell)
    
}

class MoreServiceTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var moreServiceCV: UICollectionView!
    
    var serviceArray = ["Visa","Insurance","Transfers","Activities","Cruise","Auto pay"]
    var serviceImgsArray = ["s1","s2","s3","s4","s5","s6"]
    var delegate:MoreServiceTVCellDelegate?
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
        NotificationCenter.default.addObserver(self, selector: #selector(showmoreService), name: Notification.Name("moreservice"), object: nil)
    }
    
    
    @objc func showmoreService() {
        holderView.isHidden = false
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
        holderView.isHidden = true
        delegate?.didTapOnClosebtnAction(cell: self)
    }
    
    
    
}




extension MoreServiceTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? MoreServiceCVCell {
            cell.titlelbl.text = serviceArray[indexPath.row]
            cell.img.image = UIImage(named: serviceImgsArray[indexPath.row])?.withRenderingMode(.alwaysOriginal)
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MoreServiceCVCell {
            switch cell.titlelbl.text {
                
            case "Visa":
                delegate?.didTapOnVisabtnAction(cell: self)
                break
                
            case "Insurance":
                delegate?.didTapOnInsurancebtnAction(cell: self)
                break
                
            case "Transfers":
                delegate?.didTapOnTransfersbtnAction(cell: self)
                break
                
            case "Activities":
                delegate?.didTapOnActivitiesbtnAction(cell: self)
                break
                
            case "Cruise":
                delegate?.didTapOnCruisebtnAction(cell: self)
                break
                
            case "Auto pay":
                delegate?.didTapOnAutopaybtnAction(cell: self)
                break
                
                
                
            default:
                break
            }
        }
    }
    
    
}
