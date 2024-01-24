//
//  NewDepartureTimeTVCell.swift
//  TravgateApp
//
//  Created by FCI on 24/01/24.
//

import UIKit


protocol NewDepartureTimeTVCellDelegate {
    func didSelectDepartureTime(cell:DepartureTimeCVCell)
    func didDeSelectDepartureTime(cell:DepartureTimeCVCell)
    func didTapOnDropDownBtnAction(cell:NewDepartureTimeTVCell)
}

class NewDepartureTimeTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var departureTimeCVHolderView: UIView!
    @IBOutlet weak var departureTimeCV: UICollectionView!
    
    
    
    var delegate:NewDepartureTimeTVCellDelegate?
    var selectedIndices = [IndexPath]()
    var timeImages = ["mor1","mor2","mor3","mor4"]
    var titleTimeArray = ["from 12AM","from 6AM","from 12PM","from 6PM"]
    var subtitleTimeArray = ["to 6AM","to 12PM","to 6PM","to 12AM"]
    var selectBool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        departureTimeCV.reloadData()
    }
    
    @IBAction func didTapOnDropDownBtnAction(_ sender: Any) {
        selectBool.toggle()
        if selectBool {
            departureTimeCVHolderView.isHidden = false
        }else {
            departureTimeCVHolderView.isHidden = true
        }
        
        delegate?.didTapOnDropDownBtnAction(cell: self)
    }
}



extension NewDepartureTimeTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
      
        let nib = UINib(nibName: "DepartureTimeCVCell", bundle: nil)
        departureTimeCV.register(nib, forCellWithReuseIdentifier: "cell")
        departureTimeCV.delegate = self
        departureTimeCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 55)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        departureTimeCV.collectionViewLayout = layout
        departureTimeCV.allowsMultipleSelection = true
        departureTimeCV.isScrollEnabled = false
        departureTimeCV.bounces = false
        
        departureTimeCVHolderView.isHidden = true
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DepartureTimeCVCell {
            
            cell.titlelbl.text = titleTimeArray[indexPath.row]
            cell.subtitlelbl.text = subtitleTimeArray[indexPath.row]
            
            
            
            // Check if this indexPath is in the selectedIndices array
            if selectedIndices.contains(indexPath) {
                cell.titlelbl.textColor = .WhiteColor
                cell.subtitlelbl.textColor = .WhiteColor
                cell.holderView.backgroundColor = .AppBtnColor
            } else {
                cell.titlelbl.textColor = .AppLabelColor
                cell.subtitlelbl.textColor = .AppLabelColor
                cell.holderView.backgroundColor = .WhiteColor
            }
            
            
            cell.filterTitle = cellInfo?.title ?? ""
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DepartureTimeCVCell {
            
            if !selectedIndices.contains(indexPath) {
                selectedIndices.append(indexPath)
                cell.titlelbl.textColor = .WhiteColor
                cell.subtitlelbl.textColor = .WhiteColor
                cell.holderView.backgroundColor = .AppBtnColor
                
            }
            
            delegate?.didSelectDepartureTime(cell: cell)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DepartureTimeCVCell {
            
            if let index = selectedIndices.firstIndex(of: indexPath) {
                selectedIndices.remove(at: index)
                cell.titlelbl.textColor = .AppLabelColor
                cell.subtitlelbl.textColor = .AppLabelColor
                cell.holderView.backgroundColor = .WhiteColor
                
            }
            
            
            delegate?.didDeSelectDepartureTime(cell: cell)
        }
    }
    
    
    
}


extension NewDepartureTimeTVCell {
    
    func showSelectedFlightsFilterValues(cell:DepartureTimeCVCell,indexPath:IndexPath) {
        
        
        // Check the section title to determine which filter to apply
        switch titlelbl.text {
            
            
        case "Departure Time":
            if !filterModel.departureTime.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if filterModel.departureTime.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.titlelbl.textColor = .WhiteColor
                        cell.subtitlelbl.textColor = .WhiteColor
                        cell.holderView.backgroundColor = .AppBtnColor
                        self.selectedIndices.append(indexPath)
                        self.departureTimeCV.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.titlelbl.textColor = .AppLabelColor
                        cell.subtitlelbl.textColor = .AppLabelColor
                        cell.holderView.backgroundColor = .WhiteColor
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.titlelbl.textColor = .AppLabelColor
                    cell.subtitlelbl.textColor = .AppLabelColor
                    cell.holderView.backgroundColor = .WhiteColor
                }
            }
            
            
            
        case "Arrival Time":
            if !filterModel.arrivalTime.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if filterModel.arrivalTime.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.titlelbl.textColor = .WhiteColor
                        cell.subtitlelbl.textColor = .WhiteColor
                        cell.holderView.backgroundColor = .AppBtnColor
                        self.selectedIndices.append(indexPath)
                        self.departureTimeCV.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.titlelbl.textColor = .AppLabelColor
                        cell.subtitlelbl.textColor = .AppLabelColor
                        cell.holderView.backgroundColor = .WhiteColor
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.titlelbl.textColor = .AppLabelColor
                    cell.subtitlelbl.textColor = .AppLabelColor
                    cell.holderView.backgroundColor = .WhiteColor
                }
            }
            
            
        default:
            break
        }
    }
}
