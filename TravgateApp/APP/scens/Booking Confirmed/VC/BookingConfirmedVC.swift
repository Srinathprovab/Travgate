//
//  BookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit
//import FreshchatSDK

class BookingConfirmedVC: BaseTableVC, VocherDetailsViewModelDelegate {
    
    
    
    static var newInstance: BookingConfirmedVC? {
        let storyboard = UIStoryboard(name: Storyboard.Calender.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingConfirmedVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        
        if callapibool == true {
            callAPI()
        }
        
    }
    
    
    func callAPI() {
        BASE_URL = ""
        callGetFlightVoucherAPI()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewModel = VocherDetailsViewModel(self)
    }
    
    func setupUI() {
        
        
        commonTableView.registerTVCells(["ImportentInfoTableViewCell",
                                         "NewBookingConfirmedTVCell",
                                         "HeaderTableViewCell",
                                         "EmptyTVCell",
                                         "LabelTVCell",
                                         "ButtonTVCell",
                                         "BCFlightDetailsTVCell",
                                         "BookedTravelDetailsTVCell"])
        
    }
    
    
    //MARK: - didTapOnViewVoucherBtnAction
    override func didTapOnViewVoucherBtnAction(cell:BCFlightDetailsTVCell){
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.gotoLoadWebViewVC(str: vocherpdf, keystr: "voucher")
        }
    }
    
    
    //MARK: - didTapOnBackBtnAction
    override func didTapOnBackBtnAction(cell: NewBookingConfirmedTVCell) {
        BASE_URL = BASE_URL1
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    func gotoLoadWebViewVC(str:String,keystr:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = str
        vc.keystr = keystr
        present(vc, animated: true)
    }
    
    
   //MARK: - HeaderTableViewCell Delegate Methodes
    override func didTapOnFacebookLinkBtnAction(cell: HeaderTableViewCell) {
        gotoLoadWebViewVC(str: social_linksArray[0].url_link ?? "", keystr: "link")
    }
    
    override func didTapOnTwitterLinkBtnAction(cell: HeaderTableViewCell) {
        gotoLoadWebViewVC(str: social_linksArray[1].url_link ?? "", keystr: "link")
    }
    
    override func didTapOnLinkedlnLinkBtnAction(cell: HeaderTableViewCell) {
        gotoLoadWebViewVC(str: social_linksArray[2].url_link ?? "", keystr: "link")
    }
    
    override func didTapOnInstagramLinkBtnAction(cell: HeaderTableViewCell) {
        gotoLoadWebViewVC(str: social_linksArray[4].url_link ?? "", keystr: "link")
    }
    
    
    
    
}


//MARK: - Flight Voucher Deatails
extension BookingConfirmedVC {
    func callGetFlightVoucherAPI() {
        viewModel?.Call_Get_voucher_Details_API(dictParam: [:], url: urlString)
    }
    
    
    
    func vocherdetails(response: VocherModel) {
        BASE_URL = BASE_URL1
        
        social_linksArray = response.data?.social_links ?? []
        bottom_text_info = response.data?.bottom_text_info ?? []
        vocherpdf = response.data?.voucher_pdf ?? ""
        bookedjurnycitys = "\(response.data?.booking_details?[0].journey_from ?? "")-\(response.data?.booking_details?[0].journey_to ?? "")"
        
        response.data?.booking_details?.forEach({ i in
            bookedDate = i.booked_date ?? ""
            bookingsource = i.booking_source ?? ""
            bookingId = i.booked_by_id ?? ""
            pnrNo = i.pnr ?? ""
            
        })
        
        response.data?.booking_details?.forEach({ j in
            bookingitinerarydetails = j.booking_itinerary_summary ?? []
            Customerdetails = j.customer_details ?? []
            
            
            j.booking_transaction_details?.forEach({ i in
                
                bookingRefrence = i.app_reference ?? ""
                bookingStatus = i.status ?? ""
                
                print("bookedDate    \(bookedDate)")
                print("pnrNo      \(pnrNo)")
                print("bookingRefrence   \(bookingRefrence)")
                print("bookingId    \(bookingId)")
                
                DispatchQueue.main.async {
                    self.setupTV()
                }
                
            })
        })
        
    }
    
    
    func setupTV() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:bookingId,
                                 subTitle: bookingRefrence,
                                 key: "flight",
                                 buttonTitle: bookedDate,
                                 tempText: pnrNo,
                                 cellType:.NewBookingConfirmedTVCell))
        
        tablerow.append(TableRow(title:"\(bookedjurnycitys)",key: "bc",cellType:.LabelTVCell))
        tablerow.append(TableRow(moreData: bookingitinerarydetails,cellType:.BCFlightDetailsTVCell))
        tablerow.append(TableRow(title:"Passenger Details",key: "bc",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Lead Passenger",key:"BC",moreData:Customerdetails,cellType:.BookedTravelDetailsTVCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Important Information",key: "bc",cellType:.LabelTVCell))
        tablerow.append(TableRow(cellType:.ImportentInfoTableViewCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"",cellType:.HeaderTableViewCell))
        tablerow.append(TableRow(height:35,cellType:.EmptyTVCell))
        tablerow.append(TableRow(height:60,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
}



extension BookingConfirmedVC {
    
    
    
    // Function to download and save the PDF
    func downloadAndSavePDF(showpdfurl:String) {
        let urlString = showpdfurl
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Download Error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid Response: \(response.debugDescription)")
                    return
                }
                
                if let pdfData = data {
                    self.savePdfToDocumentDirectory(pdfData: pdfData, fileName: "\(Date())")
                }
            }
            task.resume()
        } else {
            print("Invalid URL: \(urlString)")
        }
    }
    
    // Function to save PDF data to the app's document directory
    func savePdfToDocumentDirectory(pdfData: Data, fileName: String) {
        do {
            let resourceDocPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
            let pdfName = "Babsafar-\(fileName).pdf"
            let destinationURL = resourceDocPath.appendingPathComponent(pdfName)
            try pdfData.write(to: destinationURL)
            
            
        } catch {
            print("Error saving PDF to Document Directory: \(error)")
        }
    }
    
    
    
}



extension BookingConfirmedVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
    }
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            callAPI()
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
