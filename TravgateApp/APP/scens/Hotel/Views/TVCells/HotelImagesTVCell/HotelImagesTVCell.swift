//
//  HotelImagesTVCell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

protocol HotelImagesTVCellDelegate {
    func didTapOnMoreBtnAction(cell:HotelImagesTVCell)
}

class HotelImagesTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelImg: UIImageView!
    @IBOutlet weak var imagesCV: UICollectionView!
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var locNamelbl: UILabel!
    @IBOutlet weak var autoScrollImagesCV: UICollectionView!
    
    
    var itemCount = Int()
    var autoScrollTimer: Timer?
    var hotelImagesArray = [String]()
    var delegate:HotelImagesTVCellDelegate?
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
        super.prepareForReuse()
        stopAutoScroll()
    }
    
    
    override func updateUI() {
        
        hotelImg.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
                print("Error loading image: \(error.localizedDescription)")
                // Check if the error is due to a 404 Not Found response
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    // Set placeholder image for 404 error
                    self.hotelImg.image = UIImage(named: "noimage")
                } else {
                    // Set placeholder image for other errors
                    self.hotelImg.image = UIImage(named: "noimage")
                }
            }
        })
        
        
        
        hotelNamelbl.text = cellInfo?.title ?? ""
        locNamelbl.text = cellInfo?.subTitle ?? ""
        
        itemCount = imagesArray.count
//        startAutoScroll()
//        
//        autoScrollImagesCV.reloadData()
        imagesCV.reloadData()
    }
    
    func setupUI() {
        contentView.backgroundColor = HexColor("#E6E8E7")
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: UIColor.lightGray.withAlphaComponent(0.4), cornerRadius: 10)
        
       
        hotelImg.layer.cornerRadius = 8
        hotelImg.clipsToBounds = true
        hotelImg.contentMode = .scaleToFill
        
        setupCV()
      //  setupSCrollImagesCV()
    }
    
    
    
    func setupSCrollImagesCV() {
        let nib = UINib(nibName: "HotelImagesCVCell", bundle: nil)
        autoScrollImagesCV.register(nib, forCellWithReuseIdentifier: "cell1")
        autoScrollImagesCV.delegate = self
        autoScrollImagesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 180)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        // layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        autoScrollImagesCV.collectionViewLayout = layout
        autoScrollImagesCV.backgroundColor = .clear
        autoScrollImagesCV.layer.cornerRadius = 4
        autoScrollImagesCV.clipsToBounds = true
        autoScrollImagesCV.showsHorizontalScrollIndicator = false
        
    }
    
    
    
//    func setupCV() {
//        let nib = UINib(nibName: "HotelImagesCVCell", bundle: nil)
//        imagesCV.register(nib, forCellWithReuseIdentifier: "cell")
//        
//        let nib1 = UINib(nibName: "ButtonCollectionViewCell", bundle: nil)
//        imagesCV.register(nib1, forCellWithReuseIdentifier: "buttonCell")
//        
//        
//        imagesCV.delegate = self
//        imagesCV.dataSource = self
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 82, height: 80)
//       
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 6
//        layout.minimumLineSpacing = 6
//        // layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        imagesCV.collectionViewLayout = layout
//        imagesCV.backgroundColor = .clear
//        imagesCV.layer.cornerRadius = 4
//        imagesCV.clipsToBounds = true
//        imagesCV.showsHorizontalScrollIndicator = false
//        imagesCV.bounces = false
//        
//    }
    
    
    func setupCV() {
        let nib = UINib(nibName: "HotelImagesCVCell", bundle: nil)
        imagesCV.register(nib, forCellWithReuseIdentifier: "cell")
        
        let nib1 = UINib(nibName: "ButtonCollectionViewCell", bundle: nil)
        imagesCV.register(nib1, forCellWithReuseIdentifier: "buttonCell")
        
        
        imagesCV.delegate = self
        imagesCV.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        
        // Calculate the cell width dynamically based on the collection view width
        let collectionViewWidth = imagesCV.frame.width
        let cellWidth = (collectionViewWidth - 6 * 3) / 4 // Assuming 4 cells with 6 spacing in between
        layout.itemSize = CGSize(width: cellWidth, height: 80)
        
        imagesCV.collectionViewLayout = layout
        imagesCV.backgroundColor = .clear
        imagesCV.layer.cornerRadius = 4
        imagesCV.clipsToBounds = true
        imagesCV.showsHorizontalScrollIndicator = false
        imagesCV.bounces = false
    }

    
}




extension HotelImagesTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // If there are more than 4 images, return 5 (4 images + 1 button)
        return min(imagesArray.count, 3) + (imagesArray.count > 3 ? 1 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < 3 { // For the first 4 images
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HotelImagesCVCell
            cell.hotelImg.sd_setImage(with: URL(string: imagesArray[indexPath.row].img ?? ""), placeholderImage: UIImage(named: "placeholder"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                    print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        cell.hotelImg.image = UIImage(named: "noimage")
                    } else {
                        // Set placeholder image for other errors
                        cell.hotelImg.image = UIImage(named: "noimage")
                    }
                }
            })
            return cell
        } else { // For the button cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! ButtonCollectionViewCell
            // Set the thumbnail image for the button
            cell.moreBtn.setImage(UIImage(named: "thumbImage"), for: .normal)
            cell.img.sd_setImage(with: URL(string: imagesArray[3].img ?? ""), placeholderImage: UIImage(named: "placeholder"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                    print("Error loading image: \(error.localizedDescription)")
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
            cell.moreBtn.backgroundColor = .black.withAlphaComponent(0.5)
            cell.moreBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < 3 {
            self.hotelImg.sd_setImage(with: URL(string: imagesArray[indexPath.row].img ?? ""), placeholderImage: UIImage(named: "placeholder"))
        } else {
            // Handle button tap action if needed
            buttonTapped()
        }
    }
    
    @objc func buttonTapped() {
        delegate?.didTapOnMoreBtnAction(cell: self)
    }
}




extension HotelImagesTVCell {
    
    
    // MARK: - Auto Scrolling
    
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
        
        let currentIndexPaths = autoScrollImagesCV.indexPathsForVisibleItems.sorted()
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
        
        autoScrollImagesCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    
}
