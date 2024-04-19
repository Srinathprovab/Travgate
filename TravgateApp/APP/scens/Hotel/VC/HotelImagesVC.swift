//
//  HotelImagesVC.swift
//  Travgate
//
//  Created by FCI on 18/03/24.
//

import UIKit

class HotelImagesVC: UIViewController {
    
    
    @IBOutlet weak var imagesCV: UICollectionView!
    
    
    static var newInstance: HotelImagesVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelImagesVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupCV()
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {callapibool = false
        dismiss(animated: true)
    }
    
}


extension HotelImagesVC :UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func setupCV() {
        let nib = UINib(nibName: "HotelImagesCVCell", bundle: nil)
        imagesCV.register(nib, forCellWithReuseIdentifier: "cell")
        
        
        imagesCV.delegate = self
        imagesCV.dataSource = self

        let layout = UICollectionViewFlowLayout()
        let numberOfItemsPerRow: CGFloat = 2 // Adjust this value as needed
        let spacing: CGFloat = 6 // Adjust the spacing between items as needed
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacing)
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / numberOfItemsPerRow
        layout.itemSize = CGSize(width: itemWidth, height: 160) // Adjust the height as needed
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        imagesCV.collectionViewLayout = layout

        
        imagesCV.backgroundColor = .clear
        imagesCV.showsVerticalScrollIndicator = false
        imagesCV.bounces = false
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imagesArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelImagesCVCell {
            cell.hotelImg.sd_setImage(with: URL(string: imagesArray[indexPath.row].img ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            commonCell = cell
        }
        
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HotelImagesCVCell {
            gotoSelectedHotelImageVC(imgString: imagesArray[indexPath.row].img ?? "")
        }
    }
 
    
    func gotoSelectedHotelImageVC(imgString:String) {
        guard let vc = SelectedHotelImageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.imageurlString = imgString
        vc.isvcfrom = "hotel"
        self.present(vc, animated: false)
    }
    
}
