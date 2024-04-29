//
//  BookingDetailsFlightDataTVCell.swift
//  TravgateApp
//
//  Created by FCI on 09/01/24.
//

import UIKit


protocol BookingDetailsFlightDataTVCellDelegate {
    func didTapOnFlightDetails(cell:BookingDetailsFlightDataTVCell)
}

class BookingDetailsFlightDataTVCell: TableViewCell {
    
    
    @IBOutlet weak var summeryTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var detailsbtn: UIButton!
    
    
    
    var selectedResult = String()
    var farerulesrefKey = String()
    var farerulesrefContent = String()
    
    var delegate:BookingDetailsFlightDataTVCellDelegate?
    var flightsummery = [Summary]()
    var flightlist :FlightList?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func setupUI() {
        detailsbtn.layer.cornerRadius = 4
        detailsbtn.clipsToBounds = true
        setupTV()
    }
    
    override func updateUI() {
        
        flightsummery = cellInfo?.data1 as! [Summary]
        
        tvheight.constant = CGFloat((flightsummery.count ) * 133)
        summeryTV.reloadData()
        
    }
    
    
    
    @IBAction func didTapOnFlightDetails(_ sender: Any) {
        delegate?.didTapOnFlightDetails(cell: self)
    }
    
    
}


extension BookingDetailsFlightDataTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        summeryTV.register(UINib(nibName: "FlightResultSummeryTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        summeryTV.delegate = self
        summeryTV.dataSource = self
        summeryTV.tableFooterView = UIView()
        summeryTV.showsHorizontalScrollIndicator = false
        summeryTV.separatorStyle = .singleLine
        summeryTV.isScrollEnabled = false
        summeryTV.separatorStyle = .none
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightsummery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FlightResultSummeryTVCell {
            
            cell.selectionStyle = .none
            let data = flightsummery[indexPath.row]
            
            
            cell.fromCityTimelbl.text = data.origin?.time
            cell.fromCityNamelbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
            cell.toCityTimelbl.text = data.destination?.time
            cell.toCityNamelbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
            cell.hourslbl.text = data.duration
            cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stop"
            cell.inNolbl.text = "\(data.operator_code ?? "") \(data.flight_number ?? "")"
            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            cell.classlbl.text = data.fclass?.name
            
            cell.baggageView.isHidden = true
            
            if summeryTV.isLast(for: indexPath) {
                cell.ul.isHidden = true
            }
            
            
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //delegate?.didTaponRoundTripCell(cell: self)
    }
    
}

