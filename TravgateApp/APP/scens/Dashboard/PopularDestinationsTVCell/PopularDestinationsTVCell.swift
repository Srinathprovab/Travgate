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
    
    
    var itemCount = Int()
    var autoScrollTimer: Timer?
    var flightlist = [TopFlightDetails]()
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
        flightlist = MySingleton.shared.topFlightDetails
        itemCount = flightlist.count
        // startAutoScroll()
        selectDestCV.reloadData()
    }
    
    
    
    
    func setupcitySelectCV() {
        
        
        let nib = UINib(nibName: "SelectCityCVCell", bundle: nil)
        citySelectCV.register(nib, forCellWithReuseIdentifier: "cell1")
        citySelectCV.delegate = self
        citySelectCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100 , height: 34)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        citySelectCV.collectionViewLayout = layout
        
        citySelectCV.showsHorizontalScrollIndicator = false
        citySelectCV.bounces = false
        
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
            return flightlist.count
        }else {
            return flightlist.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        
        if collectionView == citySelectCV {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? SelectCityCVCell {
                
                cell.titlelbl.text = flightlist[indexPath.row].to_city_name
                
                commonCell = cell
            }
        }else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? SelectDestCVCell {
                
                cell.titlelbl.text = flightlist[indexPath.row].to_city_name
               // cell.img.sd_setImage(with: URL(string:  flightlist[indexPath.row].topFlightImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                
                
                if flightlist[indexPath.row].topFlightImg == nil || flightlist[indexPath.row].topFlightImg?.isEmpty == true {
                    cell.img.image = UIImage(named: "noimage")
                }else {
                    // Assuming mg is a UIImageView instance
                    cell.img.sd_setImage(with: URL(string: flightlist[indexPath.row].topFlightImg ?? ""),
                                         placeholderImage: UIImage(named: "placeholder.png"),
                                         completed: { (image, error, cacheType, imageURL) in
                        
                        if let error = error {
                            // Handle error, image couldn't be loaded
                            print("Error loading image: \(error.localizedDescription)")
                            // Set your placeholder image or default image here
                            cell.img.image = UIImage(named: "noimage1")
                        }
                    })
                }
                
                commonCell = cell
            }
        }
        return commonCell
    }
    
    
}


// MARK: - Auto Scrolling
extension PopularDestinationsTVCell {
    
    
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
        
        let currentIndexPaths = selectDestCV.indexPathsForVisibleItems.sorted()
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
        
        selectDestCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
}
