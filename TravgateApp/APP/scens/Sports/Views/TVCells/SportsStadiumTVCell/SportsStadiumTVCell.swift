//
//  SportsStadiumTVCell.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

class SportsStadiumTVCell: TableViewCell {
    
    @IBOutlet weak var ticketsCV: UICollectionView!
    
    var ticketsASrray = ["All","1 Ticket","2 Ticket","3 Ticket","4 Ticket","5+ Ticket"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        setupCV()
    }
    
}



extension SportsStadiumTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func setupCV() {
        
        let nib = UINib(nibName: "TicketCVCell", bundle: nil)
        ticketsCV.register(nib, forCellWithReuseIdentifier: "cell")
        ticketsCV.delegate = self
        ticketsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
       // layout.itemSize = CGSize(width: 90, height: 30)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        ticketsCV.collectionViewLayout = layout
        ticketsCV.bounces = false
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ticketsASrray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TicketCVCell {
            
            cell.titlelbl.text = ticketsASrray[indexPath.row]
            
            if indexPath.row == 0 {
                cell.holderView.backgroundColor = .Buttoncolor
                cell.titlelbl.textColor = .WhiteColor
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TicketCVCell {
            cell.holderView.backgroundColor = .Buttoncolor
            cell.titlelbl.textColor = .WhiteColor
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TicketCVCell {
            cell.holderView.backgroundColor = HexColor("#DFDFDF")
            cell.titlelbl.textColor = .TitleColor
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let label = UILabel(frame: CGRect.zero)
            label.text = ticketsASrray[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width + 10, height: 30)
        }

    
}
