//
//  BookingDetailsVC.swift
//  TravgateApp
//
//  Created by FCI on 07/01/24.
//

import UIKit

class BookingDetailsVC: BaseTableVC, MPBViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    static var newInstance: BookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingDetailsVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.mpbvm = MPBViewModel(self)
    }
    
    
    
    
    func setupUI() {
        commonTableView.registerTVCells(["FareSummaryTVCell"])
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    
}



extension BookingDetailsVC {
    
    func callAPI() {
        holderView.isHidden = true
        if MySingleton.shared.callboolapi == true {
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.payload["search_id"] =  MySingleton.shared.searchid
            MySingleton.shared.payload["selectedResult"] =  MySingleton.shared.selectedResult
            MySingleton.shared.payload["booking_source"] =  MySingleton.shared.bookingsource
            MySingleton.shared.payload["traceId"] =  MySingleton.shared.traceid
            MySingleton.shared.payload["user_id"] =  defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            MySingleton.shared.mpbvm?.CALL_MOBILE_PRE_PROCESS_BOOKING_API(dictParam: MySingleton.shared.payload)
        }
    }
    
    
    func MPBDetails(response: MobilePreProcessBookingModel) {
        holderView.isHidden = false
        MySingleton.shared.mpbpriceDetails = response.pre_booking_params?.priceDetails
        
        DispatchQueue.main.async {[self] in
            setupTVCell()
        }
    }
    
    
    
    func setupTVCell() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.FareSummaryTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
}


//MARK: - addObserver
extension BookingDetailsVC {
    
    func addObserver() {
        
        if MySingleton.shared.callboolapi == true {
            callAPI()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func nointrnetreload() {
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}
