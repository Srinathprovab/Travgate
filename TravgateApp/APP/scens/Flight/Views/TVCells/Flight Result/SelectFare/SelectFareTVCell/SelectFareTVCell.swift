//
//  SelectFareTVCell.swift
//  Travgate
//
//  Created by FCI on 22/04/24.
//

import UIKit

class SelectFareTVCell: TableViewCell {
    
    
    @IBOutlet weak var depBtn: UIButton!
    @IBOutlet weak var retBtn: UIButton!
    @IBOutlet weak var selectdeplbl: UILabel!
    @IBOutlet weak var selectFareTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    
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
        tapOnDep()
        setupTV()
    }
    
    override func updateUI() {
        
        setupBtn(btn: depBtn, title1: "Kuwait-Cairo")
        setupBtn(btn: retBtn, title1: "Cairo-Kuwait")
        
        updateHeight()
    }
    
    func updateHeight() {
        tvHeight.constant = 153 * 10
        selectFareTV.reloadData()
    }
    
    
    func setupBtn(btn:UIButton,title1:String) {
        btn.setTitle(title1, for: .normal)
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
    @IBAction func didTapOnDepartureBtnAction(_ sender: Any) {
        tapOnDep()
    }
    
    func tapOnDep() {
        depBtn.backgroundColor = UIColor.Buttoncolor
        depBtn.setTitleColor(.WhiteColor, for: .normal)
        retBtn.backgroundColor = UIColor.WhiteColor
        retBtn.setTitleColor(.TitleColor, for: .normal)
        selectdeplbl.text = "Select Fare for departure "
    }
    
    
    @IBAction func didTapOnReturnBtnAction(_ sender: Any) {
        taponReturn()
    }
    
    func taponReturn() {
        depBtn.backgroundColor = UIColor.WhiteColor
        depBtn.setTitleColor(.TitleColor, for: .normal)
        retBtn.backgroundColor = UIColor.Buttoncolor
        retBtn.setTitleColor(.WhiteColor, for: .normal)
        selectdeplbl.text = "Select Fare for Return"
    }
    
    
}



extension SelectFareTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        selectFareTV.register(UINib(nibName: "SelectFareInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        selectFareTV.delegate = self
        selectFareTV.dataSource = self
        selectFareTV.tableFooterView = UIView()
        selectFareTV.showsHorizontalScrollIndicator = false
        selectFareTV.separatorStyle = .singleLine
        selectFareTV.isScrollEnabled = false
        selectFareTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelectFareInfoTVCell {
            
            cell.selectionStyle = .none
            
            
            c = cell
            
        }
        return c
    }
    
}
