//
//  SelectSportsListVC.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

class SelectSportsListVC: BaseTableVC {
    
    static var newInstance: SelectSportsListVC? {
        let storyboard = UIStoryboard(name: Storyboard.Sports.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectSportsListVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [unowned self] in
            loderBool = false
            hideLoadera()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        print("didTapOnFilterBtnAction")
    }
    
    @IBAction func didTapOnSortBtnAction(_ sender: Any) {
        print("didTapOnSortBtnAction")
    }
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    override func didTapOnViewTicketBtnAction(cell: SportInfoTVCell) {
        didTapOnViewTicketBtnAction()
    }
    
    
    
}



extension SelectSportsListVC {
    
    
    func setupUI(){
        
        commonTableView.registerTVCells(["SportInfoTVCell",
                                         "EmptyTVCell"])
        
        setupVisaTVCells()
        
    }
    
    
    func setupVisaTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        for _ in 0...100 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.SportInfoTVCell))
        }
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    func didTapOnViewTicketBtnAction() {
        gotoViewTicketInfoVC()
    }
    
    
    
    func gotoViewTicketInfoVC() {
        guard let vc = ViewTicketInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
