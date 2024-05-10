//
//  SportsSearchVC.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

class SportsSearchVC: BaseTableVC {
    
    
    static var newInstance: SportsSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Sports.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SportsSearchVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    //MARK: - SportsSearchTVCell delegate methode
    override func didTapOnSelectServiceBtn(cell: SportsSearchTVCell) {
        print("didTapOnSelectServiceBtn")
    }
    
    override func donedatePicker(cell: SportsSearchTVCell) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        cell.depDatelbl.text = formatter.string(from: cell.depDatePicker.date)
        cell.retDatelbl.text = formatter.string(from: cell.retDatePicker.date)
        
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell: SportsSearchTVCell) {
        self.view.endEditing(true)
    }
    
    override func didTapOnSearchSportsBtnAction(cell: SportsSearchTVCell) {
        gotoSelectSportsListVC()
    }
    
    
    func gotoSelectSportsListVC() {
        guard let vc = SelectSportsListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}



extension SportsSearchVC {
    
    
    func setupUI(){
        
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["SportsSearchTVCell",
                                         "EmptyTVCell"])
        
        setupVisaTVCells()
        
    }
    
    
    func setupBtn(btn:UIButton) {
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
    func setupVisaTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.SportsSearchTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
}
