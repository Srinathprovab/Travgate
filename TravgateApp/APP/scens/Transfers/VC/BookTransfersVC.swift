//
//  BookTransfersVC.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit

class BookTransfersVC: BaseTableVC {
    
    @IBOutlet weak var onewaybtn: UIButton!
    @IBOutlet weak var roundtripBtn: UIButton!
    
    
    static var newInstance: BookTransfersVC? {
        let storyboard = UIStoryboard(name: Storyboard.Transfers.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookTransfersVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    @IBAction func didTapOnOnewayBtnAction(_ sender: Any) {
        taponOnewayBtn()
    }
    
    @IBAction func didTapOnRoundtripBtnAction(_ sender: Any) {
        taponRoundtripBtnAction()
    }
    
    func taponOnewayBtn() {
        onewaybtn.backgroundColor = .Buttoncolor
        onewaybtn.setTitleColor(UIColor.WhiteColor, for: .normal)
        roundtripBtn.backgroundColor = .WhiteColor
        roundtripBtn.setTitleColor(UIColor.TitleColor, for: .normal)
        
        setupVisaTVCells(keystr: "oneway")
    }
    
    func taponRoundtripBtnAction() {
        onewaybtn.backgroundColor = .WhiteColor
        onewaybtn.setTitleColor(UIColor.TitleColor, for: .normal)
        roundtripBtn.backgroundColor = .Buttoncolor
        roundtripBtn.setTitleColor(UIColor.WhiteColor, for: .normal)
        
        setupVisaTVCells(keystr: "circle")
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    override func didTapOnSearchBtnAction(cell: BookTransfersTVCell) {
        self.didTapOnSearchBtnAction()
    }
    
    override func donedatePicker(cell: BookTransfersTVCell) {
        
        if cell.cellInfo?.key == "oneway" {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.transfercalDepDate)
            
        }else {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.transfercalDepDate)
            defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.transfercalRetDate)
        }
        
        commonTableView.reloadData()
        
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell: BookTransfersTVCell) {
        self.view.endEditing(true)
    }
    
    override func doneTimePicker(cell:BookTransfersTVCell) {
        self.view.endEditing(true)
    }
    
    override func cancelTimePicker(cell:BookTransfersTVCell) {
        self.view.endEditing(true)
    }
}



extension BookTransfersVC {
    
    
    func setupUI(){
        
        setupBtn(btn: onewaybtn)
        setupBtn(btn: roundtripBtn)
        taponOnewayBtn()
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["BookTransfersTVCell",
                                         "EmptyTVCell"])
        
        setupVisaTVCells(keystr: "oneway")
        
    }
    
    
    func setupBtn(btn:UIButton) {
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
    func setupVisaTVCells(keystr:String) {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(key:keystr,
                                                    cellType:.BookTransfersTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    func didTapOnSearchBtnAction() {
        print("didTapOnSearchBtnAction")
        
        
        MySingleton.shared.loderString = "fdetails"
        loderBool = true
        showLoadera()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [unowned self] in
            loderBool = false
            hideLoadera()
            
            gotoTransfersListVC()
        }
    }
    
    
    func gotoTransfersListVC() {
        guard let vc = TransfersListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}
