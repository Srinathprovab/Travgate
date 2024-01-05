//
//  FlightResultTVCell.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

protocol FlightResultTVCellDelegate {
    func didTapOnFlightDetails(cell:FlightResultTVCell)
    func didTapOnBookNowBtnAction(cell:FlightResultTVCell)
    func didTapOnMoreSimilarFlightBtnAction(cell:FlightResultTVCell)
}

class FlightResultTVCell: TableViewCell {
    
    
    @IBOutlet weak var summeryTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var fareTypelbl: UILabel!
    @IBOutlet weak var strikekwdlbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var moreSimilarBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    
    var newsimilarList = [[FlightList]]()
    var delegate:FlightResultTVCellDelegate?
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
        setupTV()
    }
    
    override func updateUI() {
        flightsummery = cellInfo?.data1 as! [Summary]
        flightlist = cellInfo?.moreData as? FlightList
        
        fareTypelbl.text = flightlist?.fareType ?? ""
        kwdlbl.text = "\(flightlist?.price?.api_currency ?? ""):\(flightlist?.price?.api_total_display_fare ?? 0.0)"
        strikekwdlbl.text = "\(flightlist?.price?.api_currency ?? ""):\(flightlist?.price?.api_total_display_fare_withoutmarkup ?? 0.0)"
        setAttributedString1(str1: strikekwdlbl.text ?? "")
        checkSimelarFlights()
        
        if fareTypelbl.text == "Refundable" {
            fareTypelbl.textColor = .BackBtnColor
        }else {
            fareTypelbl.textColor = .BooknowBtnColor
        }
        
        tvheight.constant = CGFloat((flightsummery.count ) * 133)
        summeryTV.reloadData()
        
        
    }
    
    
    @IBAction func didTapOnMoreSimilarFlightBtnAction(_ sender: Any) {
        delegate?.didTapOnMoreSimilarFlightBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnFlightDetails(_ sender: Any) {
        delegate?.didTapOnFlightDetails(cell: self)
    }
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
    
}





extension FlightResultTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
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
            cell.inNolbl.text = "(\(data.flight_number ?? "")"
            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            cell.classlbl.text = data.fclass?.name
            
            
            
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


//MARK: - hideSimilarlbl showSimilarlbl
extension FlightResultTVCell {
    
    
    
    func checkSimelarFlights() {
        
        if let similarList1 = cellInfo?.data as? [[FlightList]] {
            newsimilarList = similarList1
            let similarListCount = similarList1.count
            
            // Debugging: Print the count of similarList1
            print("Similar List Count: \(similarListCount)")
            
            if similarListCount > 1 {
                moreSimilarBtn.setTitle("More similar options(\(similarListCount))", for: .normal)
                showSimilarlbl()
            } else {
                hideSimilarlbl()
            }
        }else {
            hideSimilarlbl() // Handle the case when cellInfo?.data is not a valid [[J_flight_list]]
        }
        
        
    }
    
    
    
    func hideSimilarlbl(){
        bottomView.isHidden = true
    }
    
    func showSimilarlbl(){
        bottomView.isHidden = false
    }
    
    
    
    func setAttributedString1(str1:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.BackBtnColor,NSAttributedString.Key.font:UIFont.InterMedium(size: 11),NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
      
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        
        strikekwdlbl.attributedText = combination
        
    }
    
}
