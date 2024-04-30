//
//  ItineraryTVCell.swift
//  TravgateApp
//
//  Created by FCI on 06/01/24.
//

import UIKit

class ItineraryTVCell: TableViewCell {
    
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var additinararyTV: UITableView!
    
    
    
    var depFind = Int()
    var fdetais = [ItinearyFlightDetails]()
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
        
        depFind = Int(cellInfo?.title ?? "") ?? 0
        fdetais = cellInfo?.moreData as! [ItinearyFlightDetails]
        
        tvHeight.constant = CGFloat((fdetais.count * 222))
        additinararyTV.reloadData()
    }
    
    
    func setupUI() {
        
        setupTV()
    }
    
    
    func setupTV() {
        additinararyTV.register(UINib(nibName: "AddItineraryTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        additinararyTV.delegate = self
        additinararyTV.dataSource = self
        additinararyTV.tableFooterView = UIView()
        additinararyTV.showsVerticalScrollIndicator = false
        additinararyTV.separatorStyle = .none
        additinararyTV.isScrollEnabled = false
    }
    
}




extension ItineraryTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fdetais.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddItineraryTVCell {
            
            cell.selectionStyle = .none
            let data = fdetais[indexPath.row]
            cell.flightnumber.text = "\(data.flight_number ?? "")"
            cell.fromcitylbl.text = "\(data.origin?.city ?? "")"
            cell.fromdatelbl.text = "\(data.origin?.date ?? "")"
            cell.fromairportlbl.text = "\(data.origin?.airport_name ?? "")"
            cell.fromterminallbl.text = "Terminal: \(data.origin?.terminal ?? "")"
            
            cell.tocitylbl.text = "\(data.destination?.city ?? "")"
            cell.todatelbl.text = "\(data.destination?.date ?? "")"
            cell.toairportlbl.text = "\(data.destination?.airport_name ?? "")"
            cell.toterminallbl.text = "Terminal: \(data.destination?.terminal ?? "")"
            
            
            cell.operatorimg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    if indexPath.row == 0 {
                        cell.depimg.image = UIImage(named: "depflight")
                    }
                    
                }else {
                    if indexPath.row == 0 {
                        if depFind == indexPath.row {
                            cell.depimg.image = UIImage(named: "depflight")
                        }else {
                            cell.depimg.image = UIImage(named: "flight")                                    }
                    }
                }
            }
            
            cell.timelbl.text = "Layover Duration \(data.destination?.city ?? "") (\(data.destination?.loc ?? "")) \(data.layover_duration ?? "")"
            if tableView.isLast(for: indexPath) {
                cell.timeView.isHidden = true
                cell.depimg.isHidden = true
                cell.imgwidth.constant = 0
                cell.imgleft.constant = 0
            }
            
            
            
            
            if let convertedString = MySingleton.shared.convertToPC(input: data.weight_Allowance ?? "") {
                cell.worklbl.text = convertedString
            } else {
                print("Invalid input format")
            }
            
            cell.luggagelbl.text = data.cabin_baggage ?? ""
            
           
            
            c = cell
        }
        
        
        return c
    }
    
    
    
}
