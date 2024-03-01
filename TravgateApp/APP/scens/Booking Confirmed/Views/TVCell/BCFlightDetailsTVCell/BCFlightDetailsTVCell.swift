//
//  BCFlightDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import UIKit
import SDWebImage

protocol BCFlightDetailsTVCellDelegate {
    func didTapOnViewVoucherBtnAction(cell:BCFlightDetailsTVCell)
}

class BCFlightDetailsTVCell: TableViewCell {
    
    
    @IBOutlet weak var flightDetaillsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var delegate:BCFlightDetailsTVCellDelegate?
    var bookingFlightDetails = [Booking_itinerary_summary]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        bookingFlightDetails = cellInfo?.moreData as? [Booking_itinerary_summary] ?? []
        tvHeight.constant = CGFloat(bookingFlightDetails.count * 133)
        flightDetaillsTV.reloadData()
    }
    
    func setupUI() {
        setupTV()
    }
    
    @IBAction func didTapOnViewVoucher(_ sender: Any) {
        delegate?.didTapOnViewVoucherBtnAction(cell: self)
    }
    
    
}



extension BCFlightDetailsTVCell: UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        let nib = UINib(nibName: "FlightResultSummeryTVCell", bundle: nil)
        flightDetaillsTV.register(nib, forCellReuseIdentifier: "cell")
        flightDetaillsTV.delegate = self
        flightDetaillsTV.dataSource = self
        flightDetaillsTV.tableFooterView = UIView()
        flightDetaillsTV.separatorStyle = .singleLine
        flightDetaillsTV.isScrollEnabled = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingFlightDetails.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FlightResultSummeryTVCell {
            cell.selectionStyle = .none
            
            let data = bookingFlightDetails[indexPath.row]
            //  cell.showLayover()
            
            //            cell.img.sd_setImage(with: URL(string: data.airline_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            //
            //            cell.airlineNamelbl.text = data.airline_name ?? ""
            //            cell.flightNolbl.text = "(\(data.airline_code ?? "")-\(data.flight_number ?? ""))"
            //            cell.durationlbl.text = data.duration ?? ""
            //            cell.economylbl.text = data.cabin_class ?? ""
            //
            //            cell.fromTimelbl.text = data.departure_time ?? ""
            //            cell.fromCitylbl.text = data.from_airport_name ?? ""
            //            cell.fromdatelbl.text = MySingleton.shared.convertDateFormat(inputDate: data.departure_date ?? "", f1: "yyyy-MM-dd", f2: "dd MMM yyyy")
            //
            //
            //            cell.toTimelbl.text = data.arrival_time ?? ""
            //            cell.tocitylbl.text = data.to_airport_name ?? ""
            //            cell.todatelbl.text = MySingleton.shared.convertDateFormat(inputDate: data.arrival_date ?? "", f1: "yyyy-MM-dd", f2: "dd MMM yyyy")
            //
            //            cell.fromTerminallbl.text = "Terminal \(data.origin_terminal ?? "")"
            //            cell.toTerminallbl.text = "Terminal \(data.destination_terminal ?? "")"
            //
            
            
            //    cell.layoverTimelbl.text = "Layover At \(data.to_airport_name ?? "") (\(data.to_airport_code ?? "")) \(data.layover ?? "")"
            
            //            if indexPath.row != 0 {
            //                cell.hideLayover()
            //            }
            
            //     cell.hideLayover()
            //            if tableView.isLast(for: indexPath) == true {
            //                cell.hideLayover()
            //            }
            
            
            
           // let data = flightsummery[indexPath.row]
            
//            cell.flightDetailsTapBtn.addTarget(self, action: #selector(didTapFlightDetailsPopupBrtnBtnAction(_:)), for: .touchUpInside)
            cell.fromCityTimelbl.text = data.origin?.time
            cell.fromCityNamelbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
            cell.toCityTimelbl.text = data.destination?.time
            cell.toCityNamelbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
            cell.hourslbl.text = data.duration
            cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stop"
            cell.inNolbl.text = "\(data.operator_code ?? "") \(data.flight_number ?? "")"
            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            cell.classlbl.text = data.cabin_class ?? ""
            
            
         //   self.cityslbl.text = "\(data.origin?.city ?? "") - \(data.destination?.city ?? "")"
            
            
            if flightDetaillsTV.isLast(for: indexPath) {
                cell.ul.isHidden = true
            }
            
            
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    
}
