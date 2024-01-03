//
//  SpecialOffersTVCell.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import UIKit

class SpecialOffersTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var offerCV: UICollectionView!
    
    var offerlist = [Deail_code_list]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupofferCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        offerlist = MySingleton.shared.deail_code_list
        offerCV.reloadData()
    }
    
    
    
    func setupofferCV() {
        
        
        let nib = UINib(nibName: "SpecialOffersCVCell", bundle: nil)
        offerCV.register(nib, forCellWithReuseIdentifier: "cell1")
        offerCV.delegate = self
        offerCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 168)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        // layout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        offerCV.collectionViewLayout = layout
        
        offerCV.showsHorizontalScrollIndicator = false
        offerCV.bounces = false
        
    }
    
}



extension SpecialOffersTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? SpecialOffersCVCell {
            
          //  cell.titlelbl.text = offerlist[indexPath.row].room_type
            cell.codelbl.text = offerlist[indexPath.row].promo_code
            cell.img.sd_setImage(with: URL(string:  offerlist[indexPath.row].topDealImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
}
