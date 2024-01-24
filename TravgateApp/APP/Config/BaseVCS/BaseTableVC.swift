//
//  BaseTableVC.swift
//  Clique
//
//  Created by Codebele-03 on 03/06/21.
//

import UIKit
import MaterialComponents

class BaseTableVC: UIViewController, TabSelectTVCellDelegate, FlightSearchTVCellDelegate, FlightResultTVCellDelegate, SideMenuTitleTVCellDelegate, MenuBGTVCellDelegate, SliderTVCellDelegate, CheckBoxTVCellDelegate, FilterDepartureTVCellDelegate, LabelTVCellDelegate, PopularFiltersTVCellDelegate,DepartureTimeTVCellDelegate, ButtonTVCellDelegate, SortbyTVCellDelegate, BookingDetailsFlightDataTVCellDelegate, TDetailsLoginTVCellDelegate, AddDeatilsOfTravellerTVCellDelegate, ContactInformationTVCellDelegate, UsePromoCodesTVCellDelegate, LoginTVCellDelegate, ResetPasswordTVCellDelegate, SignupTVCellDelegate, EditProfileTVCellDelegate, HotelSearchTVCellDelegate, AddRoomsGuestsTVCellDelegate, NewDepartureTimeTVCellDelegate {
    
    
    
    
    
    @IBOutlet weak var commonScrollView: UITableView!
    @IBOutlet weak var commonTableView: UITableView!
    @IBOutlet weak var commonTVTopConstraint: NSLayoutConstraint!
    
    
    var commonTVData = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable vertical bounce
        commonTableView.bounces = false
        
        self.modalPresentationCapturesStatusBarAppearance = true
        self.navigationController?.navigationBar.isHidden = true
        configureTableView()
        //        self.automaticallyAdjustsScrollViewInsets = false
        
        // Do any additional setup after loading the view.
    }
    
    
    func configureTableView() {
        if commonTableView != nil {
            makeDefaultConfigurationForTable(tableView: commonTableView)
        } else {
            print("commonTableView is nil")
        }
    }
    
    func makeDefaultConfigurationForTable(tableView: UITableView) {
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
    }
    
    func serviceCall_Completed_ForNoDataLabel(noDataMessage: String? = nil, data: [Any]? = nil, centerVal:CGFloat? = nil, color: UIColor = HexColor("#182541")) {
        dealWithNoDataLabel(message: noDataMessage, data: data, centerVal: centerVal ?? 2.0, color: color)
    }
    
    func dealWithNoDataLabel(message: String?, data: [Any]?, centerVal: CGFloat = 2.0, color: UIColor = HexColor("#182541")) {
        if commonTableView == nil { return; }
        
        commonTableView.viewWithTag(100)?.removeFromSuperview()
        
        if let message = message, let data = data {
            if data.count == 0 {
                let tableSize = commonTableView.frame.size
                
                let label = UILabel(frame: CGRect(x: 15, y: 15, width: tableSize.width, height: 60))
                label.center = CGPoint(x: (tableSize.width/2), y: (tableSize.height/centerVal))
                label.tag = 100
                label.numberOfLines = 0
                
                label.textAlignment = NSTextAlignment.center
                //                label.font = UIFont.CircularStdMedium(size: 14)
                label.textColor = color
                label.text = message
                
                commonTableView.addSubview(label)
            }
        }
        
    }
    
    
    
    func didTapOnMenuBtnAction(cell: TabSelectTVCell) {}
    func didTapOnSelectCurrencyBtnAction(cell: TabSelectTVCell) {}
    func didTapOnFlightTabSelectBtnAction(cell: TabSelectTVCell) {}
    func didTapOnHotelTabSelect(cell: TabSelectTVCell) {}
    func didTapOnMoreServiceBtnAction(cell: TabSelectTVCell) {}
    func didTapOnClosebtnAction(cell: TabSelectTVCell) {}
    func didTapOnVisabtnAction(cell: TabSelectTVCell) {}
    func didTapOnInsurancebtnAction(cell: TabSelectTVCell) {}
    func didTapOnTransfersbtnAction(cell: TabSelectTVCell) {}
    func didTapOnActivitiesbtnAction(cell: TabSelectTVCell) {}
    func didTapOnCruisebtnAction(cell: TabSelectTVCell) {}
    func didTapOnAutopaybtnAction(cell: TabSelectTVCell) {}
    
    func didTapOnAdvanceOption(cell: FlightSearchTVCell) {}
    func didTapOnClassBtnAction(cell:FlightSearchTVCell){}
    func donedatePicker(cell:FlightSearchTVCell) {}
    func cancelDatePicker(cell:FlightSearchTVCell) {}
    func didTapOnSwipeCityBtnAction(cell: FlightSearchTVCell) {}
    func didTapOnHideReturnDateBtnAction(cell:FlightSearchTVCell) {}
    func didTapOnFlightSearchBtnAction(cell:FlightSearchTVCell) {}
    func didTapOnReturnDateBtnAction(cell:FlightSearchTVCell) {}
    
    func didTapOnFlightDetails(cell: FlightResultTVCell) {}
    func didTapOnBookNowBtnAction(cell: FlightResultTVCell) {}
    func didTapOnMoreSimilarFlightBtnAction(cell:FlightResultTVCell){}
    func didTaponCell(cell: SideMenuTitleTVCell) {}
    func didTapOnLoginBtn(cell: MenuBGTVCell) {}
    func didTapOnEditProfileBtn(cell: MenuBGTVCell) {}
    
    
    func didTapOnLowtoHighBtn(cell: SortbyTVCell) {}
    func didTapOnHightoLowBtn(cell: SortbyTVCell) {}
    func btnAction(cell: ButtonTVCell) {}
    func didTapOnDualBtn1(cell: ButtonTVCell) {}
    func didTapOnDualBtn2(cell: ButtonTVCell) {}
    func didTapOnOneRatingViewBtn(cell: PopularFiltersTVCell) {}
    func didTapOnTwoRatingViewBtn(cell: PopularFiltersTVCell) {}
    func didTapOnThreeatingViewBtn(cell: PopularFiltersTVCell) {}
    func didTapOnFouratingViewBtn(cell: PopularFiltersTVCell) {}
    func didTapOnFivetingViewBtn(cell: PopularFiltersTVCell) {}
    func didTapOnCloseBtn(cell: LabelTVCell) {}
    func didTapOnShowMoreBtn(cell: LabelTVCell) {}
    func didTapOnDropDownBtn(cell: FilterDepartureTVCell) {}
    func didTapOnTimeBtn(cell: FilterDepartureTVCell) {}
    func didTapOnCheckBoxDropDownBtn(cell: CheckBoxTVCell) {}
    func didTapOnShowMoreBtn(cell: CheckBoxTVCell) {}
    func didTapOnCheckBox(cell: checkOptionsTVCell) {}
    func didTapOnDeselectCheckBox(cell: checkOptionsTVCell) {}
    func didTapOnShowSliderBtn(cell: SliderTVCell) {}
    func didSelectDepartureTime(cell: DepartureTimeCVCell) {}
    func didDeSelectDepartureTime(cell: DepartureTimeCVCell) {}
    func didTapOnFlightDetails(cell: BookingDetailsFlightDataTVCell) {}
    func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {}
    
    
    func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func tfeditingChanged(tf: UITextField) {}
    func didTapOnTitleBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnMrBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnMrsBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnMissBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnSaveTravellerDetailsBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func editingMDCOutlinedTextField(tf: UITextField) {}
    func donedatePicker(cell: AddDeatilsOfTravellerTVCell) {}
    func cancelDatePicker(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnSelectNationalityBtn(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnSelectIssuingCountryBtn(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnMealPreferenceBtn(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnSpecialAssicintenceBtn(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnFlyerProgramBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    
    
    func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {}
    func editingTextField(tf: UITextField) {}
    func didTapOnDropDownBtn(cell: ContactInformationTVCell) {}
    
    func didTapOnViewAllPromoCodesBtn(cell: UsePromoCodesTVCell) {}
    func didTapOnApplyPromosCodesBtn(cell: UsePromoCodesTVCell) {}
    func editingChanged(tf: UITextField) {}
    func didTapOnCloseBtnAction(cell: LoginTVCell) {}
    func didTapOnSignUpBtnAction(cell: LoginTVCell) {}
    func didTapOnLoginBtnAction(cell: LoginTVCell) {}
    func didTapOnForgetPasswordBtnAction(cell: LoginTVCell) {}
    func didTapOnSendEmailBtnAction(cell: ResetPasswordTVCell) {}
    func didTapOnRegisterCloseBtnAction(cell: SignupTVCell) {}
    func didTapOnSignupBtnAction(cell: SignupTVCell) {}
    func didTapOnUpdateProfileBtnAction(cell: EditProfileTVCell) {}
    func didTapOnMailBtnAction(cell:EditProfileTVCell) {}
    func didTapOnFeMailBtnAction(cell:EditProfileTVCell) {}
    func donedatePicker(cell:EditProfileTVCell) {}
    func cancelDatePicker(cell:EditProfileTVCell) {}
    
    
    func donedatePicker(cell:HotelSearchTVCell) {}
    func cancelDatePicker(cell:HotelSearchTVCell) {}
    func didTapOnAddRoomsBtnAction(cell:HotelSearchTVCell) {}
    func didTapOnSelectNationlatiyBtnAction(cell:HotelSearchTVCell) {}
    func didTapOnSelectNoofNightsBtnAction(cell:HotelSearchTVCell) {}
    
    func closeBtnAction(cell: AddRoomsGuestsTVCell) {}
    func adultsIncrementButtonAction(cell:AddRoomsGuestsTVCell){}
    func adultsDecrementBtnAction(cell:AddRoomsGuestsTVCell){}
    func childrenIncrementButtonAction(cell:AddRoomsGuestsTVCell){}
    func childrenDecrementBtnAction(cell:AddRoomsGuestsTVCell){}
    func didTapOnDropDownBtnAction(cell:NewDepartureTimeTVCell) {}
    
    
}

extension BaseTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = commonTVData[indexPath.row].height
        
        if let height = height {
            return height
        }
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
extension BaseTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == commonTableView {
            return commonTVData.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell: TableViewCell!
        
        var data: TableRow?
        var commonTV = UITableView()
        
        if tableView == commonTableView {
            data = commonTVData[indexPath.row]
            commonTV = commonTableView
        }
        
        
        if let cellType = data?.cellType {
            switch cellType {
                
                //Sign & SignUp Cells
                
                
            case .EmptyTVCell:
                let cell: EmptyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .TabSelectTVCell:
                let cell: TabSelectTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .PopularDestinationsTVCell:
                let cell: PopularDestinationsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .TopcityGuidesTVCell:
                let cell: TopcityGuidesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .SpecialOffersTVCell:
                let cell: SpecialOffersTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .SelectLanguageTVCell:
                let cell: SelectLanguageTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .FlightSearchTVCell:
                let cell: FlightSearchTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .FlightResultTVCell:
                let cell: FlightResultTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TicketIssuingTimeTVCell:
                let cell: TicketIssuingTimeTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .QuickLinkTableViewCell:
                let cell: QuickLinkTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .SideMenuTitleTVCell:
                let cell: SideMenuTitleTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .MenuBGTVCell:
                let cell: MenuBGTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .ItineraryTVCell:
                let cell: ItineraryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
                
            case .SliderTVCell:
                let cell: SliderTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .CheckBoxTVCell:
                let cell: CheckBoxTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .FilterDepartureTVCell:
                let cell: FilterDepartureTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .LabelTVCell:
                let cell: LabelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .PopularFiltersTVCell:
                let cell: PopularFiltersTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .DepartureTimeTVCell:
                let cell: DepartureTimeTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .ButtonTVCell:
                let cell: ButtonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SortbyTVCell:
                let cell: SortbyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .FareBreakdownTVCell:
                let cell: FareBreakdownTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .FareSummaryTVCell:
                let cell: FareSummaryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .BookingDetailsFlightDataTVCell:
                let cell: BookingDetailsFlightDataTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .TDetailsLoginTVCell:
                let cell:  TDetailsLoginTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                
            case .AddDeatilsOfTravellerTVCell:
                let cell:  AddDeatilsOfTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TotalNoofTravellerTVCell:
                let cell:  TotalNoofTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .UsePromoCodesTVCell:
                let cell:  UsePromoCodesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .ContactInformationTVCell:
                let cell:  ContactInformationTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                
            case .BookingConfirmedTVCell:
                let cell:  BookingConfirmedTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .BookedTravelDetailsTVCell:
                let cell:  BookedTravelDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .BCFlightDetailsTVCell:
                let cell:  BCFlightDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .LoginTVCell:
                let cell:  LoginTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .ResetPasswordTVCell:
                let cell:  ResetPasswordTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SignupTVCell:
                let cell:  SignupTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .EditProfileTVCell:
                let cell:  EditProfileTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .HotelSearchTVCell:
                let cell:  HotelSearchTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AddRoomsGuestsTVCell:
                let cell: AddRoomsGuestsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .TitleLblTVCell:
                let cell: TitleLblTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .NewDepartureTimeTVCell:
                let cell: NewDepartureTimeTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            default:
                print("handle this case in getCurrentCellAt")
            }
        }
        
        commonCell.cellInfo = data
        commonCell.indexPath = indexPath
        commonCell.selectionStyle = .none
        
        return commonCell
    }
} 



extension UITableView {
    func registerTVCells(_ classNames: [String]) {
        for className in classNames {
            register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        }
    }
    
    func dequeTVCell<T: UITableViewCell>(indexPath: IndexPath, osVersion: String? = nil) -> T {
        let className = String(describing: T.self) + "\(osVersion ?? "")"
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    func dequeTVCellForFooter<T: UITableViewCell>() -> T {
        let className = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: className) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    
    
    func isLast(for indexPath: IndexPath) -> Bool {
        
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
    
}
