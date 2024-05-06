//
//  SelectedFaresVC.swift
//  Travgate
//
//  Created by FCI on 03/05/24.
//

import UIKit

class SelectedFaresVC: BaseTableVC {
    
    @IBOutlet weak var continueBtnView: UIView!
    @IBOutlet weak var gifimg: UIImageView!
    @IBOutlet weak var kwdlbl: UILabel!
    
    
    static var newInstance: SelectedFaresVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectedFaresVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    
    func setupUI() {
        MySingleton.shared.setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""): ",
                                                str2: String(format: "%.2f", MySingleton.shared.totalselectedfareprice),
                                                lbl: kwdlbl,
                                                str1font: .OpenSansBold(size: 15),
                                                str2font: .OpenSansBold(size: 18),
                                                str1Color: .WhiteColor,
                                                str2Color: .WhiteColor)
        continueBtnView.isHidden = true
        guard let gifURL = Bundle.main.url(forResource: "pay", withExtension: "gif") else { return }
        guard let imageData = try? Data(contentsOf: gifURL) else { return }
        guard let image = UIImage.gifImageWithData(imageData) else { return }
        gifimg.image = image
        commonTableView.registerTVCells(["SelectFareTVCell",
                                         "EmptyTVCell"])
        
        
        setupTVcells1()
    }
    
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        MySingleton.shared.selectedFares.removeAll()
        self.presentingViewController?.self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOnProceeedBtnAction(_ sender: Any) {
        gotoBookingDetailsVC()
    }
    
    func gotoBookingDetailsVC() {
        MySingleton.shared.selectedFares.removeAll()
        guard let vc = BookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    override func didTapOnSelectFareBtnAction(cell:SelectFareInfoTVCell, at indexPath: IndexPath) {
        
        MySingleton.shared.setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""): ",
                                                str2: String(format: "%.2f", MySingleton.shared.totalselectedfareprice),
                                                lbl: kwdlbl,
                                                str1font: .OpenSansBold(size: 15),
                                                str2font: .OpenSansBold(size: 18),
                                                str1Color: .WhiteColor,
                                                str2Color: .WhiteColor)
        
        setupTVcells()
        
        
    }
    
    
    
    
    override func didTapOnCloseFareBtnAction(cell: SelectFareInfoTVCell, at indexPath: IndexPath) {
        // Update cell UI
        cell.selectBtn.isHidden = false
        cell.closeView.isHidden = true
        cell.holderView.borderColor = UIColor.BorderColor
        cell.holderView.backgroundColor = .WhiteColor
        
        
        MySingleton.shared.totalselectedfareprice -= cell.fareamount
        
        // Remove the corresponding SelectFare object from the selectedFares array
        // Check if the index is valid before removing the item
        if indexPath.row < MySingleton.shared.selectedFares.count {
            MySingleton.shared.selectedFares.remove(at: indexPath.row)
        } else {
            // Index is out of range, handle the error or provide a default action
            print("Error: Index out of range")
        }
        
        
        DispatchQueue.main.async {
            self.setupTVcells()
        }
        
        
        
    }
    
}



extension SelectedFaresVC {
    
    
    
    
    
    func setupTVcells1() {
        MySingleton.shared.tablerow.removeAll()
        
        continueBtnView.isHidden = true
        MySingleton.shared.tablerow.append(TableRow(title:"notselected",key: "",cellType:.SelectFareTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    func setupTVcells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        if let jtype = defaults.string(forKey: UserDefaultsKeys.journeyType), jtype == "oneway" {
            if MySingleton.shared.selectedFares.count > 0 {
                continueBtnView.isHidden = false
                MySingleton.shared.tablerow.append(TableRow(title:"selected",cellType:.SelectFareTVCell))
            }else {
                continueBtnView.isHidden = true
                MySingleton.shared.tablerow.append(TableRow(title:"notselected",cellType:.SelectFareTVCell))
            }
        }else {
            if MySingleton.shared.selectedFares.count == 1  {
                continueBtnView.isHidden = false
                MySingleton.shared.tablerow.append(TableRow(title:"selected",cellType:.SelectFareTVCell))
                
                
                //                continueBtnView.isHidden = true
                //                MySingleton.shared.tablerow.append(TableRow(title:"notselected",cellType:.SelectFareTVCell))
                
            }else
            
            if MySingleton.shared.selectedFares.count == 2  {
                continueBtnView.isHidden = false
                MySingleton.shared.tablerow.append(TableRow(title:"selected",cellType:.SelectFareTVCell))
            }else {
                continueBtnView.isHidden = true
            }
        }
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
}
