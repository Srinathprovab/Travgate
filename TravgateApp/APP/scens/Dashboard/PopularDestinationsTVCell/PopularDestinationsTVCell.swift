//
//  PopularDestinationsTVCell.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class PopularDestinationsTVCell: TableViewCell {
    
    
    @IBOutlet weak var citySelectCV: UICollectionView!
    @IBOutlet weak var selectDestCV: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupcitySelectCV()
        setupselectDestCV()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
    }
    
    
    
    
    func setupcitySelectCV() {
        
        
        let nib = UINib(nibName: "SelectCityCVCell", bundle: nil)
        citySelectCV.register(nib, forCellWithReuseIdentifier: "cell1")
        citySelectCV.delegate = self
        citySelectCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: calculateCellWidth(), height: 34)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        // layout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        citySelectCV.collectionViewLayout = layout
        
        citySelectCV.showsHorizontalScrollIndicator = false
        citySelectCV.bounces = false
        
    }
    
    func calculateCellWidth() -> CGFloat {
        // You should replace this string with the actual label text you plan to use
        let sampleText = "Dubai"
        
        let label = UILabel()
        label.text = sampleText
        label.sizeToFit()
        
        
        
        return label.frame.width + 25
    }
    
    func setupselectDestCV() {
        
        
        let nib = UINib(nibName: "SelectDestCVCell", bundle: nil)
        selectDestCV.register(nib, forCellWithReuseIdentifier: "cell2")
        selectDestCV.delegate = self
        selectDestCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 125)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        // layout.sectionInset = UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        selectDestCV.collectionViewLayout = layout
        
        selectDestCV.showsHorizontalScrollIndicator = false
        selectDestCV.bounces = false
        
    }
    
    
}



extension PopularDestinationsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == citySelectCV {
            return 10
        }else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        
        if collectionView == citySelectCV {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? SelectCityCVCell {
                
                commonCell = cell
            }
        }else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? SelectDestCVCell {
                
                commonCell = cell
            }
        }
        return commonCell
    }
    
    
    
    
    
}
