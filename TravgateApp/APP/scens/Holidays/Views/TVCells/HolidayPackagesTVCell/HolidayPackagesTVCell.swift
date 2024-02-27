//
//  HolidayPackagesTVCell.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import UIKit
protocol HolidayPackagesTVCellDelegate {
    func didTapOnHolidayPackage(cell:HolidayPackagesTVCell)
}

class HolidayPackagesTVCell: TableViewCell {
    
    
    @IBOutlet weak var packageImage: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var holidaysTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var delegate:HolidayPackagesTVCellDelegate?
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
        updateHeight()
    }
    
    
    func updateHeight() {
        tvHeight.constant = 10 * 260
    }
    
    
    func setupUI() {
        setupTV()
    }
    
}



extension HolidayPackagesTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        holidaysTV.register(UINib(nibName: "HolidaysInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        holidaysTV.delegate = self
        holidaysTV.dataSource = self
        holidaysTV.tableFooterView = UIView()
        holidaysTV.showsHorizontalScrollIndicator = false
        holidaysTV.separatorStyle = .singleLine
        holidaysTV.isScrollEnabled = false
        holidaysTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HolidaysInfoTVCell {
            
            cell.selectionStyle = .none
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            delegate?.didTapOnHolidayPackage(cell: self)
    }
    
    
}
