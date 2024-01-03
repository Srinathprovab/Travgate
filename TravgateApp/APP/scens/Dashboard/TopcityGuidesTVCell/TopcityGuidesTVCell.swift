//
//  TopcityGuidesTVCell.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class TopcityGuidesTVCell: TableViewCell {
    
    
    @IBOutlet weak var topcitysCV: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setuptopcitysCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func setuptopcitysCV() {
        
        
        let nib = UINib(nibName: "TopcityGuidesCVCell", bundle: nil)
        topcitysCV.register(nib, forCellWithReuseIdentifier: "cell1")
        topcitysCV.delegate = self
        topcitysCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 214)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        // layout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        topcitysCV.collectionViewLayout = layout
        
        topcitysCV.showsHorizontalScrollIndicator = false
        topcitysCV.bounces = false
        
    }
    
}



extension TopcityGuidesTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? TopcityGuidesCVCell {
            commonCell = cell
        }
        return commonCell
    }
    
    
}
