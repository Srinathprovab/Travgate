//
//  HotelDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

class HotelDetailsVC: BaseTableVC, HotelDetailsViewModelDelegate, TimerManagerDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var paxlbl: UILabel!
    
    
    static var newInstance: HotelDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelDetailsVC
        return vc
    }
    
    var selectedCell: NewRoomDetailsTVCell?
    var tablerow = [TableRow]()
    var viewmodel:HotelDetailsViewModel?
    var payload = [String:Any]()
    var bookingsource = String()
    var hotelid = String()
    var searchid = String()
    var hotelDetails:Hotel_details?
    var kwdprice = String()
    var img = String()
    
    
    //MARK: - Loading function
    override func viewWillAppear(_ animated: Bool) {
        selectedCellStates = [:]
        addObserver()
        
        
        if callapibool == true{
            
            holderView.isHidden = true
            callAPI()
        }
        
    }
    
    
    //MARK: - show BookNow Btn
    @objc func showBookNowBtn() {
        bookNowView.isUserInteractionEnabled = true
        bookNowView.alpha = 1
    }
    
    
    //MARK: - Loading function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = HotelDetailsViewModel(self)
        MySingleton.shared.delegate = self
        
    }
    
    
    
    //MARK: - setupUI
    func setupUI() {
        
        holderView.backgroundColor = .AppBorderColor
        self.citylbl.text = defaults.string(forKey: UserDefaultsKeys.locationcity) ?? ""
        self.datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyyy", f2: "MMM dd")) - \(MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "MMM dd"))"
        
        paxlbl.text = "Room \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1") | Adults \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "2")"
        
        
        bookNowView.backgroundColor = .AppBtnColor
        setuplabels(lbl: kwdlbl, text: "Book Now", textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .right)
        bookNowBtn.setTitle("", for: .normal)
        bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["HotelImagesTVCell","EmptyTVCell","RoomsTVcell"])
        
    }
    
    
    
    //MARK: - setuptv
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:hotelDetails?.name ?? "",
                                 subTitle: "\(hotelDetails?.address ?? "")|\(hotelDetails?.city_name ?? "")",
                                 image:img,
                                 cellType:.HotelImagesTVCell))
        
        
        tablerow.append(TableRow(title:hotelDetails?.latitude ?? "",
                                 subTitle: hotelDetails?.longitude ?? "",
                                 text: hotelDetails?.token,
                                 buttonTitle: hotelDetails?.name ?? "",
                                 moreData:roomsDetails,
                                 tempText: hotelDetails?.tokenKey,
                                 cellType:.RoomsTVcell))
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnBookNowBtn
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        
        if hotelDetailsTapBool == true {
            if selectedrRateKeyArray.isEmpty == false {
                gotoHotelBookingDetailsVC()
            }else {
                showToast(message: "Select Room")
            }
        }else {
            NotificationCenter.default.post(name: NSNotification.Name("gotoroom"), object: false)
        }
        
    }
    
    
    func gotoHotelBookingDetailsVC(){
        MySingleton.shared.callboolapi = true
        guard let vc = HotelBookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnRoomsBtn
    override func didTapOnRoomsBtn(cell: RoomsTVcell) {
        cell.key = "rooms"
        hotelDetailsTapBool = true
        cell.roomDetailsTV.reloadData()
    }
    
    
    //MARK: - didTapOnHotelsDetailsBtn
    override func didTapOnHotelsDetailsBtn(cell: RoomsTVcell) {
        cell.key = "hotels details"
        hotelDetailsTapBool = false
        cell.roomDetailsTV.reloadData()
    }
    
    
    //MARK: - didTapOnAmenitiesBtn
    override func didTapOnAmenitiesBtn(cell: RoomsTVcell) {
        cell.key = "amenities"
        hotelDetailsTapBool = false
        cell.roomDetailsTV.reloadData()
    }
    
    //MARK: - didTapOnCancellationPolicyBtnAction
    override func didTapOnCancellationPolicyBtnAction(cell:NewRoomDetailsTVCell){
        
        //        guard let vc = CancellationPolicyPopupVC.newInstance.self else {return}
        //        vc.modalPresentationStyle = .overCurrentContext
        //        vc.amount = cell.CancellationPolicyAmount
        //        vc.datetime = cell.CancellationPolicyFromDate
        //        vc.fartType = cell.fareTypeString
        //        self.present(vc, animated: false)
        
    }
    
    
    //MARK: - didTapOnSelectRoomBtnAction
    override func didTapOnSelectRoomBtnAction(cell:NewRoomDetailsTVCell){
        
        bookNowlbl.isHidden = false
        
        // Toggle the selected state
        cell.isSelectedCell.toggle()
        
        // Update the button color
        cell.updateButtonColor()
        
        // Check if a different cell was previously selected
        if let previouslySelectedCell = selectedCell {
            // Deselect the previously selected cell
            previouslySelectedCell.isSelectedCell = false
            previouslySelectedCell.updateButtonColor()
        }
        
        // Select the tapped cell
        cell.isSelectedCell = true
        cell.updateButtonColor()
        
        // Update the selectedCell reference
        selectedCell = cell
        
        bookNowView.isUserInteractionEnabled = true
        bookNowView.alpha = 1
        grandTotal = cell.pricelbl.text ?? ""
        setuplabels(lbl: bookNowlbl, text: cell.pricelbl.text ?? "" , textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .left)
        
        selectedrRateKeyArray = cell.ratekey
        
        MySingleton.shared.setAttributedTextnew(str1: "\(cell.currency )",
                                                str2: "\(cell.exactprice )",
                                                lbl: bookNowlbl,
                                                str1font: .LatoBold(size: 12),
                                                str2font: .LatoBold(size: 18),
                                                str1Color: .WhiteColor,
                                                str2Color: .WhiteColor)
        
        
        roomselected = cell.selectedRoom
        print("roomselected : \(roomselected)")
        
        
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnMoreBtnAction HotelImagesTVCell
    override func didTapOnMoreBtnAction(cell: HotelImagesTVCell) {
        
        if imagesArray.count > 0 {
            guard let vc = HotelImagesVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
    }
    
}



extension HotelDetailsVC {
    
    
    //MARK: - CALL HOTEL DETAILS API
    func callAPI() {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        payload["booking_source"] = bookingsource
        payload["hotel_id"] = hotelid
        payload["search_id"] = hsearchid
        
        viewmodel?.CALL_HOTEL_DETAILS_API(dictParam: payload)
    }
    
    func hotelDetails(response: HotelSelectedDetailsModel) {
        
        
        loderBool = false
        hideLoadera()
        
        holderView.isHidden = false
        hsearchid = response.params?.search_id ?? ""
        htoken = response.hotel_details?.token ?? ""
        htokenkey = response.hotel_details?.tokenKey ?? ""
        
        
        hotelDetails = response.hotel_details
        roomsDetails = response.hotel_details?.rooms ?? [[]]
        imagesArray = response.hotel_details?.images ?? []
        formatAmeArray = response.hotel_details?.format_ame ?? []
        formatDesc = response.hotel_details?.format_desc ?? []
        img = response.hotel_details?.image ?? ""
        
        bookNowlbl.isHidden = true
        
        DispatchQueue.main.async {[self] in
            setuptv()
        }
    }
    
}

extension HotelDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(roomtapbool), name: Notification.Name("roomtapbool"), object: nil)
        
    }
    
    @objc func roomtapbool(notify:NSNotification) {
        if let tapbool = notify.object as? Bool {
            if tapbool == true {
                kwdlbl.text = "Book Now"
            }else {
                kwdlbl.text = "Select Now"
            }
        }
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
    
    
    //MARK: - updateTimer
    func updateTimer() {
        let totalTime = MySingleton.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        
        //        MySingleton.shared.setAttributedTextnew(str1: "\(formattedTime)",
        //                                                str2: "",
        //                                                lbl: sessionTimelbl,
        //                                                str1font: .OpenSansMedium(size: 12),
        //                                                str2font: .OpenSansMedium(size: 12),
        //                                                str1Color: .BooknowBtnColor,
        //                                                str2Color: .BooknowBtnColor)
        
        
    }
    
    
    func timerDidFinish() {
        gotoPopupScreen()
    }
    
    
    func gotoPopupScreen() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
}
