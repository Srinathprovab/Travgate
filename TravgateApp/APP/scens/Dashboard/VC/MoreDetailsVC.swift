//
//  MoreDetailsVC.swift
//  Travgate
//
//  Created by FCI on 07/03/24.
//

import UIKit

class MoreDetailsVC: BaseTableVC, MoreDetailsViewModelDelegate {
   
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    var titleString = String()
    static var newInstance: MoreDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MoreDetailsVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         
        holderView.isHidden = true
        callAPI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.moredetailsvm = MoreDetailsViewModel(self)
    }
    
    
    
    func setupUI() {
        commonTableView.registerTVCells(["MoreDetailsTVCell"])
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        titlelbl.text = MySingleton.shared.moreDetailsData?.page_title ?? ""
        MySingleton.shared.tablerow.append(TableRow(cellType:.MoreDetailsTVCell))
       
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
}


extension MoreDetailsVC {
    
    func callAPI() {
        
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        BASE_URL = ""
        switch titleString {
        case "About Us":
            MySingleton.shared.moredetailsvm?.CALL_GET_MORE_DETAILS_API(dictParam: [:],
                                                                        urlStr: "https://provab.net/travgate/pro_new/mobile/index.php/general/cms?id=1")
            break
            
        case "Terms & Conditions":
            MySingleton.shared.moredetailsvm?.CALL_GET_MORE_DETAILS_API(dictParam: [:],
                                                                        urlStr: "https://provab.net/travgate/pro_new/mobile/index.php/general/cms?id=3")
            break
            
            
        case "Privacy Policy":
            MySingleton.shared.moredetailsvm?.CALL_GET_MORE_DETAILS_API(dictParam: [:],
                                                                        urlStr: "https://provab.net/travgate/pro_new/mobile/index.php/general/cms?id=4")
            break
            
       
            
        default:
            break
        }
    }
    
    
    
    func moreDetails(response: MoreDetailsModel) {
        BASE_URL = BASE_URL1
        MySingleton.shared.moreDetailsData = response.data
        holderView.isHidden = false
        hideLoadera()
        
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
}


