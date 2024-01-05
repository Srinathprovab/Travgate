//
//  FlightResultTVCell.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

class FlightResultTVCell: TableViewCell {
    
    
    @IBOutlet weak var summeryTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    
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
        
        tvheight.constant = CGFloat((cellInfo?.characterLimit ?? 0) * 133)
        summeryTV.reloadData()
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
        return cellInfo?.characterLimit ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FlightResultSummeryTVCell {
            
            //            cell.selectionStyle = .none
            //            let data = summery1[indexPath.row]
            //
            //
            //            cell.fromCityTimelbl.text = data.origin?.time
            //            cell.fromCityNamelbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
            //            cell.toCityTimelbl.text = data.destination?.time
            //            cell.toCityNamelbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
            //            cell.hourslbl.text = data.duration
            //            cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stops"
            //   cell.inNolbl.text = "(\(data.operator_code ?? "")-\(data.operator_name ?? ""))"
            //    cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            
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
