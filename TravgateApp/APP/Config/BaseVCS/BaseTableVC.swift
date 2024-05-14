//
//  BaseTableVC.swift
//  Clique
//
//  Created by Codebele-03 on 03/06/21.
//

import UIKit
import MaterialComponents

class BaseTableVC: UIViewController, TabSelectTVCellDelegate, FlightSearchTVCellDelegate, FlightResultTVCellDelegate, SideMenuTitleTVCellDelegate, MenuBGTVCellDelegate, SliderTVCellDelegate, CheckBoxTVCellDelegate, FilterDepartureTVCellDelegate, LabelTVCellDelegate,DepartureTimeTVCellDelegate, ButtonTVCellDelegate, SortbyTVCellDelegate, BookingDetailsFlightDataTVCellDelegate, TDetailsLoginTVCellDelegate, AddDeatilsOfTravellerTVCellDelegate, ContactInformationTVCellDelegate, UsePromoCodesTVCellDelegate, LoginTVCellDelegate, ResetPasswordTVCellDelegate, SignupTVCellDelegate, EditProfileTVCellDelegate, HotelSearchTVCellDelegate, AddRoomsGuestsTVCellDelegate, NewDepartureTimeTVCellDelegate, VisaTVCellDelegate, AutoPaymentTVCellDelegate, TripsTVCellDelegate, YourRecentSearchesTVCellDelegate, RoomsTVcellDelegate, RegisterSelectionLoginTableViewCellDelegate, AddonTVCellDelegate, TravellerEconomyTVCellDelegate, HolidayPackagesTVCellDelegate, CruisePackegesTVCellDelegate, CruiseContactdetailsTVCellDelegate, HolidayContactdetailsTVCellDelegate, BCFlightDetailsTVCellDelegate, NewBookingConfirmedTVCellDelegate, HeaderTableViewCellDelegate, QuickLinkTableViewCellDelegate, FlightUpcomingTVCellDelegate, LoginDetailsTableViewCellDelegate, GuestTVCellDelegate, ContactUsTVCellDelegate, HotelImagesTVCellDelegate, AddDeatilsOfGuestTVCellDelegate, FareRulesTVCellDelegate, PrimaryContactInfoTVCellDelegate, OperatorsCheckBoxTVCellDelegate, AddonTableViewCellDelegate, PriceSummaryTVCellDelegate, AcceptCookiesTVCellDelegate, SelectMealTVCellDelegate, NewSpecialAssistanceTVCellDelegate, SelectFareTVCellDelegate, PaymentTypeTVCellDelegate, SelectFareInfoTVCellDelegate, BookTransfersTVCellDelegate, TransfersInf0TVCellDelegate, StarRatingTVCellDelegate, TFlighDetailsTVCellDelegate, TContactDetailsTVCellDelegate, SportsSearchTVCellDelegate, SportInfoTVCellDelegate, InsurenceSearchTVCellDelegate, InsurancePlaneTVCellDelegate {
    
    
    
    
    @IBOutlet weak var commonScrollView: UITableView!
    @IBOutlet weak var commonTableView: UITableView!
    @IBOutlet weak var commonTVTopConstraint: NSLayoutConstraint!
    
    var loaderVC: LoderVC?
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
    func didTapOnHolidaysbtnAction(cell: TabSelectTVCell) {}
    func didTapOnTransfersbtnAction(cell: TabSelectTVCell) {}
    func didTapOnSportsbtnAction(cell: TabSelectTVCell) {}
    func didTapOnCruisebtnAction(cell: TabSelectTVCell) {}
    func didTapOnAutopaybtnAction(cell: TabSelectTVCell) {}
    func didTapOnInsurencebtnAction(cell:TabSelectTVCell) {}
    
    func didTapOnAdvanceOption(cell: FlightSearchTVCell) {}
    func didTapOnClassBtnAction(cell:FlightSearchTVCell){}
    func donedatePicker(cell:FlightSearchTVCell) {}
    func cancelDatePicker(cell:FlightSearchTVCell) {}
    func didTapOnSwipeCityBtnAction(cell: FlightSearchTVCell) {}
    func didTapOnHideReturnDateBtnAction(cell:FlightSearchTVCell) {}
    func didTapOnFlightSearchBtnAction(cell:FlightSearchTVCell) {}
    func didTapOnReturnDateBtnAction(cell:FlightSearchTVCell) {}
    func didTapOnAirlineTimeBtnAction(cell:FlightSearchTVCell){}
    
    func didTapFlightDetailsPopupBrtnBtnAction(cell:FlightResultTVCell){}
    func didTapOnFlightDetails(cell: FlightResultTVCell) {}
    func didTapOnBookNowBtnAction(cell: FlightResultTVCell) {}
    func didTapOnMoreSimilarFlightBtnAction(cell:FlightResultTVCell){}
    func didTapOnReturnDateBtnAction(cell:FlightResultTVCell) {}
    func didTapOnSelectFareBtnAction(cell:FlightResultTVCell) {}
    func didTaponCell(cell: SideMenuTitleTVCell) {}
    func didTapOnLoginBtn(cell: MenuBGTVCell) {}
    func didTapOnEditProfileBtn(cell: MenuBGTVCell) {}
    
    
    func didTapOnLowtoHighBtn(cell: SortbyTVCell) {}
    func didTapOnHightoLowBtn(cell: SortbyTVCell) {}
    func btnAction(cell: ButtonTVCell) {}
    func didTapOnDualBtn1(cell: ButtonTVCell) {}
    func didTapOnDualBtn2(cell: ButtonTVCell) {}
    
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
    func didTapOnRestPasswordBackBtnAction(cell:ResetPasswordTVCell){}
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
    func didTapOnHotelSearchBtnAction(cell:HotelSearchTVCell) {}
    
    func closeBtnAction(cell: AddRoomsGuestsTVCell) {}
    func adultsIncrementButtonAction(cell:AddRoomsGuestsTVCell){}
    func adultsDecrementBtnAction(cell:AddRoomsGuestsTVCell){}
    func childrenIncrementButtonAction(cell:AddRoomsGuestsTVCell){}
    func childrenDecrementBtnAction(cell:AddRoomsGuestsTVCell){}
    func didTapOnDropDownBtnAction(cell:NewDepartureTimeTVCell) {}
    
    func didTapOnSubmitEnquiryBtnAction(cell: VisaTVCell) {}
    func didTapOnPassengersBtnAction(cell:VisaTVCell) {}
    func didTapOnNationalityBtnAction(cell:VisaTVCell){}
    func donedatePicker(cell:VisaTVCell){}
    func cancelDatePicker(cell:VisaTVCell){}
    
    func didTapOnPaynowBtnAction(cell: AutoPaymentTVCell) {}
    func didTapOnTripsBtnAction(cell: TripsTVCell) {}
    func didTapOnCloserecentSearchBtnAction(cell: YourRecentSearchesCVCell) {}
    func didTapOnSearchRecentFlightsBtnAction(cell: YourRecentSearchesCVCell) {}
    func didTapOnSelectCountryCodeList(cell:HotelSearchTVCell){}
    
    func didTapOnRoomsBtn(cell: RoomsTVcell) {}
    func didTapOnHotelsDetailsBtn(cell: RoomsTVcell) {}
    func didTapOnAmenitiesBtn(cell: RoomsTVcell) {}
    func didTapOnCancellationPolicyBtnAction(cell: NewRoomDetailsTVCell) {}
    func didTapOnSelectRoomBtnAction(cell: NewRoomDetailsTVCell) {}
    func didTapOnAddonServiceBtnAction(cell: AddonTVCell) {}
    
    func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {}
    func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {}
    
    func didTapOnCruisePackageBtnAction(cell: CruisePackegesTVCell) {}
    func didTapOnSubmitEnquiryBtnAction(cell:CruiseContactdetailsTVCell){}
    func didTapOnRequestCallBackBtnAction(cell:CruiseContactdetailsTVCell){}
    func didTapOnAddPeopleBtnAction(cell:CruiseContactdetailsTVCell){}
    func donedatePicker(cell:CruiseContactdetailsTVCell){}
    func cancelDatePicker(cell:CruiseContactdetailsTVCell){}
    
    func didTapOnHolidayPackage(cell:HolidayPackagesTVCell){}
    func didTapOnSubmitEnquiryBtnAction(cell: HolidayContactdetailsTVCell) {}
    func didTapOnRequestCallBackBtnAction(cell: HolidayContactdetailsTVCell) {}
    func didTapOnAddPeopleBtnAction(cell: HolidayContactdetailsTVCell) {}
    func donedatePicker(cell: HolidayContactdetailsTVCell) {}
    func cancelDatePicker(cell: HolidayContactdetailsTVCell) {}
    func didTapOnViewVoucherBtnAction(cell:BCFlightDetailsTVCell){}
    func didTapOnBackBtnAction(cell: NewBookingConfirmedTVCell) {}
    
    func didTapOnFacebookLinkBtnAction(cell: HeaderTableViewCell) {}
    func didTapOnTwitterLinkBtnAction(cell: HeaderTableViewCell) {}
    func didTapOnLinkedlnLinkBtnAction(cell: HeaderTableViewCell) {}
    func didTapOnInstagramLinkBtnAction(cell: HeaderTableViewCell) {}
    func didTapOnViewVoucherBtnAction(cell: FlightUpcomingTVCell) {}
    
    func GuestRegisterNowButtonAction(cell: GuestTVCell, email: String, pass: String, phone: String, countryCode: String) {}
    func RegisterNowButtonAction(cell: LoginDetailsTableViewCell, email: String, pass: String, phone: String, countryCode: String) {}
    
    func didTapOnRegisterNowOrLoginButtonAction(cell: RegisterSelectionLoginTableViewCell) {}
    
    
    func didTapOnAddressBtnAction(cell: ContactUsTVCell) {}
    func didTapOnMailBtnAction(cell: ContactUsTVCell) {}
    func didTapOnPhoneBtnAction(cell: ContactUsTVCell) {}
    func didTapOnSubmitBtnAction(cell: ContactUsTVCell) {}
    func textViewDidChange(textView: UITextView) {}
    func didTapOnCountryCodeBtnAction(cell: ContactUsTVCell) {}
    func didTapOnMoreBtnAction(cell: HotelImagesTVCell) {}
    
    
    func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfGuestTVCell) {}
    func didTapOnTitleBtnAction(cell: AddDeatilsOfGuestTVCell) {}
    func didTapOnMrBtnAction(cell: AddDeatilsOfGuestTVCell) {}
    func didTapOnMrsBtnAction(cell: AddDeatilsOfGuestTVCell) {}
    func didTapOnCountryCodeBtn(cell:SignupTVCell) {}
    func showContentBtnAction(cell: FareRulesTVCell) {}
    
    func didTapOnCountryCodeBtn(cell: PrimaryContactInfoTVCell) {}
    func didTapOnRegisterBtnAction(cell:PrimaryContactInfoTVCell) {}
    func didTapOnGuestBtnAction(cell:PrimaryContactInfoTVCell) {}
    func didTapOnLoginBtnAction(cell:PrimaryContactInfoTVCell) {}
    func enableContinuetoPaymentBtn(cell: OperatorsCheckBoxTVCell) {}
    
    func didSelectAddon(index: Int) {}
    func didDeselectAddon(index: Int) {}
    func didTapOnRemoveTravelInsuranceBtn(cell: PriceSummaryTVCell) {}
    func didTapOnRemovePromoCodeBtnAction(cell:PriceSummaryTVCell) {}
    func didTapOnAcceptAllCookieBtnAction(cell: AcceptCookiesTVCell) {}
    func didTapOnRejectCookieBtnAction(cell: AcceptCookiesTVCell) {}
    func didTapOnPrivacyCookiesBtnAction(cell:AcceptCookiesTVCell) {}
    func didTapOnCheckBoxBtnAction(cell: SelectMealTVCell) {}
    func didTapOnCheckBoxBtnAction(cell: NewSpecialAssistanceTVCell) {}
    func didTapOnServiceBtnAction(cell: NewSpecialAssistanceTVCell) {}
    func didTapOnSelectFareBtnAction(cell:SelectFareInfoTVCell, at indexPath: IndexPath) {}
    func didTapOnCloseFareBtnAction(cell: SelectFareInfoTVCell, at indexPath: IndexPath) {}
    func didTapOnDepartureBtnAction(cell:SelectFareTVCell) {}
    func didTapOnPayNowBtnAction(cell: PaymentTypeTVCell) {}
    func didTapOnCloseFareBtnAction(cell: SelectFareInfoTVCell) {}
    func didTapOnSelectFareBtnAction(cell: SelectFareInfoTVCell) {}
    
    func didTapOnSearchBtnAction(cell: BookTransfersTVCell) {}
    func donedatePicker(cell: BookTransfersTVCell) {}
    func cancelDatePicker(cell: BookTransfersTVCell) {}
    func doneTimePicker(cell:BookTransfersTVCell) {}
    func cancelTimePicker(cell:BookTransfersTVCell) {}
    func didTapOnBookNowBtnAction(cell: TransfersInf0TVCell) {}
    func didTapOnStarRatingCell(cell: StarRatingCVCell) {}
    func doneTimePicker(cell: TFlighDetailsTVCell) {}
    func cancelTimePicker(cell: TFlighDetailsTVCell) {}
    func didTapOnCountryCodeBtn(cell: TContactDetailsTVCell) {}
    
    func didTapOnSelectServiceBtn(cell: SportsSearchTVCell) {}
    func didTapOnSearchSportsBtnAction(cell: SportsSearchTVCell) {}
    func donedatePicker(cell: SportsSearchTVCell) {}
    func cancelDatePicker(cell: SportsSearchTVCell) {}
    func didTapOnViewTicketBtnAction(cell: SportInfoTVCell) {}
    func didTapOnInsurenceSearchBtnAction(cell: InsurenceSearchTVCell) {}
    func didTapOnWhoTravellingBtnAction(cell:InsurenceSearchTVCell) {}
    func didTapOnWithWhomTravellingBtnAction(cell:InsurenceSearchTVCell) {}
    func didTapOnTravelZoneBtnAction(cell:InsurenceSearchTVCell) {}
    func didTapOnMultiTripslblBtnAction(cell:InsurenceSearchTVCell) {}
    func donedatePicker(cell:InsurenceSearchTVCell) {}
    func cancelDatePicker(cell:InsurenceSearchTVCell) {}
    func didTapOnAddAdditionalTravellerBtnAction(cell:InsurenceSearchTVCell) {}
    func didTapOnSelectPlanBtnAction(cell: InsurancePlaneTVCell) {}
    func didTapOnPremiumDetailsBtnAction(cell: InsurancePlaneTVCell) {}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
                cell.delegate = self
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
                cell.delegate = self
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
                
                
                
            case .VisaTVCell:
                let cell: VisaTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AutoPaymentTVCell:
                let cell: AutoPaymentTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .TripsTVCell:
                let cell: TripsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .YourRecentSearchesTVCell:
                let cell:  YourRecentSearchesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .RoomsTVcell:
                let cell: RoomsTVcell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .HotelImagesTVCell:
                let cell: HotelImagesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .BaggageInfoTVCell:
                let cell: BaggageInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .FareRulesTVCell:
                let cell: FareRulesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .InternationalTravelInsuranceTVCell :
                let cell: InternationalTravelInsuranceTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .AddonTVCell :
                let cell: AddonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .TravellerEconomyTVCell :
                let cell: TravellerEconomyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .HolidayPackagesTVCell :
                let cell: HolidayPackagesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .CruisePackegesTVCell :
                let cell: CruisePackegesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .HolidayItineraryTVCell :
                let cell: HolidayItineraryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .CruiseItineraryTVCell :
                let cell: CruiseItineraryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .CruiseContactdetailsTVCell :
                let cell: CruiseContactdetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .HolidayContactdetailsTVCell :
                let cell: HolidayContactdetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .ImportentInfoTableViewCell :
                let cell:  ImportentInfoTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
                
            case .NewBookingConfirmedTVCell :
                let cell: NewBookingConfirmedTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .HeaderTableViewCell :
                let cell: HeaderTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .FRulesTVCell :
                let cell: FRulesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .ContactUsTVCell :
                let cell: ContactUsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .MoreDetailsTVCell :
                let cell: MoreDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .FlightUpcomingTVCell :
                let cell: FlightUpcomingTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .LoginDetailsTableViewCell :
                let cell: LoginDetailsTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .RegisterSelectionLoginTableViewCell :
                let cell: RegisterSelectionLoginTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .GuestTVCell :
                let cell: GuestTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .TermsPopupTVCell :
                let cell: TermsPopupTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .BookingHotelDetailsTVCell :
                let cell: BookingHotelDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .HotelBookingCancellationpolicyTVCell :
                let cell: HotelBookingCancellationpolicyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .HotelFareSummaryTVCell :
                let cell: HotelFareSummaryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .UserSpecificationTVCell :
                let cell: UserSpecificationTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .AddDeatilsOfGuestTVCell :
                let cell: AddDeatilsOfGuestTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                
            case .OperatorsCheckBoxTVCell :
                let cell: OperatorsCheckBoxTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .PrimaryContactInfoTVCell :
                let cell: PrimaryContactInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .AddonTableViewCell:
                let cell: AddonTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .PriceSummaryTVCell:
                let cell: PriceSummaryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AcceptCookiesTVCell:
                let cell: AcceptCookiesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SelectMealTVCell:
                let cell: SelectMealTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .SpecialAssistanceTVCell :
                let cell: SpecialAssistanceTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .NewSpecialAssistanceTVCell :
                let cell: NewSpecialAssistanceTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .SelectFareTVCell :
                let cell: SelectFareTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .BaggageInfoImageTVCell :
                let cell: BaggageInfoImageTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .PaymentTypeTVCell :
                let cell: PaymentTypeTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .SelectFareInfoTVCell :
                let cell: SelectFareInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .BookTransfersTVCell :
                let cell: BookTransfersTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TransfersInf0TVCell :
                let cell: TransfersInf0TVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .BDTransfersInf0TVCell :
                let cell: BDTransfersInf0TVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .TFlighDetailsTVCell :
                let cell: TFlighDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TContactDetailsTVCell :
                let cell: TContactDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TermsAgreeTVCell :
                let cell: TermsAgreeTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .SportsSearchTVCell :
                let cell: SportsSearchTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .SportInfoTVCell :
                let cell: SportInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SelectedSportInfoTVCell :
                let cell: SelectedSportInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .SportsStadiumTVCell :
                let cell: SportsStadiumTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .InsurenceSearchTVCell :
                let cell: InsurenceSearchTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .InsurancePlaneTVCell :
                let cell: InsurancePlaneTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .PremiumInfoTVCell :
                let cell: PremiumInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .MainTravelPersonTVCell :
                let cell: MainTravelPersonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
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


//MARK: Loder Child View
extension BaseTableVC {
    
    
    func setupLoaderVC() {
        // Instantiate LoderVC from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
        loaderVC = storyboard.instantiateViewController(withIdentifier: "LoderVC") as? LoderVC
        addChild(loaderVC!)
        
        // Set the frame or constraints for the child view controller's view
        loaderVC?.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        // Add the child view controller's view to the parent view controller's view
        view.addSubview(loaderVC!.view)
        
        // Notify the child view controller that it has been added
        loaderVC?.didMove(toParent: self)
    }
    
    // Function to remove the child view controller
    func removeLoader() {
        loaderVC?.willMove(toParent: nil)
        loaderVC?.view.removeFromSuperview()
        loaderVC?.removeFromParent()
    }
    
    // Function to show the loader
    func showLoadera() {
        setupLoaderVC()
    }
    
    // Function to hide the loader
    func hideLoadera() {
        removeLoader()
    }
}
