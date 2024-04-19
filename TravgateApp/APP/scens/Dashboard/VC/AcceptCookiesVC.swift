//
//  AcceptCookiesVC.swift
//  Travgate
//
//  Created by FCI on 18/04/24.
//

import UIKit

class AcceptCookiesVC: BaseTableVC {
    
    
    @IBOutlet weak var topview: UIView!

    static var newInstance: AcceptCookiesVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AcceptCookiesVC
        return vc
    }
    
    var tablerow = [TableRow]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topview.layer.cornerRadius = 12
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["AcceptCookiesTVCell"])
        setupTVCells()
    }
    
    
    func setupTVCells() {
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.AcceptCookiesTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    

    override func didTapOnAcceptAllCookieBtnAction(cell: AcceptCookiesTVCell) {
        dismiss(animated: false)
    }
    
    override func didTapOnRejectCookieBtnAction(cell: AcceptCookiesTVCell) {
        dismiss(animated: false)
    }
    
    override func didTapOnPrivacyCookiesBtnAction(cell:AcceptCookiesTVCell) {
        gotoMoreDetailsVC()
    }
    
    
    func gotoMoreDetailsVC(){
        guard let vc = MoreDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleString = "Privacy Policy"
        present(vc, animated: true)
    }

}
