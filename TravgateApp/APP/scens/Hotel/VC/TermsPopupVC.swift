//
//  TermsPopupVC.swift
//  Travgate
//
//  Created by FCI on 14/03/24.
//

import UIKit

class TermsPopupVC: BaseTableVC {

    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    
    
    static var newInstance: TermsPopupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TermsPopupVC
        return vc
    }
    
    var titlestr = String()
    var subtitlestr = String()
    
    override func viewWillAppear(_ animated: Bool) {
        self.titlelbl.text = titlestr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
      
        closeBtn.addTarget(self, action: #selector(didTapOnCloseBtnAction(_:)), for: .touchUpInside)
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topview.layer.cornerRadius = 8
        
        commonTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        commonTableView.layer.cornerRadius = 8
        
        commonTableView.registerTVCells(["TermsPopupTVCell"])
       
        setupTVCell()
    }
    
    
    func setupTVCell() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(title:titlestr,
                                                    subTitle: subtitlestr,
                                                    cellType:.TermsPopupTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    @objc func didTapOnCloseBtnAction(_ sender:UIButton) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
}
