//
//  CruiseItineraryTVCell.swift
//  Travgate
//
//  Created by FCI on 27/02/24.
//

import UIKit

class CruiseItineraryTVCell: TableViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var packegeImagesCV: UICollectionView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var itineraryTV: UITableView!
    
    
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
        
        self.bannerImage.sd_setImage(with: URL(string: MySingleton.shared.cruiseDetails?.cruise_data?.image_url ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))

        
        updateHeight()
    }
    
    func updateHeight() {
        tvHeight.constant = 3 * 185
    }
    
    func setupUI() {
        setupCV()
        setupTV()
    }
    
}


extension CruiseItineraryTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
        
        let nib = UINib(nibName: "HolidaysImagesCVCell", bundle: nil)
        packegeImagesCV.register(nib, forCellWithReuseIdentifier: "cell")
        packegeImagesCV.delegate = self
        packegeImagesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 130)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        packegeImagesCV.collectionViewLayout = layout
        packegeImagesCV.bounces = false
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HolidaysImagesCVCell {
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
        }
    
    
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            
        }
    
    
}


extension CruiseItineraryTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        itineraryTV.register(UINib(nibName: "CruiseAddItineraryTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        itineraryTV.delegate = self
        itineraryTV.dataSource = self
        itineraryTV.tableFooterView = UIView()
        itineraryTV.showsHorizontalScrollIndicator = false
        itineraryTV.separatorStyle = .singleLine
        itineraryTV.isScrollEnabled = false
        itineraryTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CruiseAddItineraryTVCell {
            
            cell.selectionStyle = .none
            cell.daylbl.text = "Day \(indexPath.row)"
            
            c = cell
            
        }
        return c
    }
    
}