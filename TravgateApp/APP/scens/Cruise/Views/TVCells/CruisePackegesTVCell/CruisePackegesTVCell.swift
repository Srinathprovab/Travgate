//
//  CruisePackegesTVCell.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import UIKit

protocol CruisePackegesTVCellDelegate {
    func didTapOnCruisePackageBtnAction(cell:CruisePackegesTVCell)
}

class CruisePackegesTVCell: TableViewCell {
    
    
    @IBOutlet weak var packageImage: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var cruisePackagesTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var cruiseKey = String()
    var delegate:CruisePackegesTVCellDelegate?
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
        titlelbl.text = MySingleton.shared.cruise?.cruise_package_text ?? ""
        updateHeight()
    }
    
    
    func updateHeight() {
        tvHeight.constant = CGFloat(MySingleton.shared.cruiseList.count * 260)
    }
    
    
    func setupUI() {
        setupTV()
    }
    
}



extension CruisePackegesTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        cruisePackagesTV.register(UINib(nibName: "HolidaysInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        cruisePackagesTV.delegate = self
        cruisePackagesTV.dataSource = self
        cruisePackagesTV.tableFooterView = UIView()
        cruisePackagesTV.showsHorizontalScrollIndicator = false
        cruisePackagesTV.separatorStyle = .singleLine
        cruisePackagesTV.isScrollEnabled = false
        cruisePackagesTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.cruiseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HolidaysInfoTVCell {
            
            cell.selectionStyle = .none
            let data = MySingleton.shared.cruiseList[indexPath.row]
            cell.titlelbl.text = data.heading ?? ""
            cell.subtitlelbl.text = data.subheading ?? ""
            cell.img.sd_setImage(with: URL(string: data.image_url ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            cell.cruiseKey = data.key ?? ""
            
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if let cell = tableView.cellForRow(at: indexPath) as? HolidaysInfoTVCell {
            self.cruiseKey = cell.cruiseKey
            delegate?.didTapOnCruisePackageBtnAction(cell: self)
        }
    }
    
    
}
