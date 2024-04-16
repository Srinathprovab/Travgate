//
//  SpecialOffersTVCell.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import UIKit

class SpecialOffersTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var offerCV: UICollectionView!
    
    
    var itemCount = Int()
    var autoScrollTimer: Timer?
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
        itemCount = offerlist.count
       // startAutoScroll()
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
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
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
            cell.img.sd_setImage(with: URL(string:  offerlist[indexPath.row].topDealImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                    print("Error loading banner image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        cell.img.image = UIImage(named: "noimage")
                    } else {
                        // Set placeholder image for other errors
                        cell.img.image = UIImage(named: "noimage")
                    }
                }
            })
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
}



// MARK: - Auto Scrolling
extension SpecialOffersTVCell {
    
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    @objc func scrollToNextItem() {
        
        
        guard itemCount > 0 else {
            return // No items in the collection view
        }
        
        let currentIndexPaths = offerCV.indexPathsForVisibleItems.sorted()
        let lastIndexPath = currentIndexPaths.last ?? IndexPath(item: 0, section: 0)
        
        var nextIndexPath: IndexPath
        
        if lastIndexPath.item == itemCount - 1 {
            nextIndexPath = IndexPath(item: 0, section: lastIndexPath.section)
        } else {
            nextIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
        }
        
        if nextIndexPath.item >= itemCount {
            nextIndexPath = IndexPath(item: 0, section: nextIndexPath.section) // Adjust the index path if it exceeds the bounds
        }
        
        offerCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
}
