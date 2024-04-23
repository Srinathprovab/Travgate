//
//  SelectFareTVCell.swift
//  Travgate
//
//  Created by FCI on 22/04/24.
//

import UIKit

struct SelectFare {
    let fareName: String?
    let cabinClass: String?
    let RefundableType: String?
    let Baggage: String?
    let Price: String?
    let selectedBool:Bool?
    let journyType:String?
}


protocol SelectFareTVCellDelegate {
    func didTapOnSelectFareBtnAction(cell:SelectFareTVCell)
    func didTapOnCloseFareBtnAction(cell:SelectFareTVCell)
}

class SelectFareTVCell: TableViewCell, SelectFareInfoTVCellDelegate {
    
    
    @IBOutlet weak var depBtn: UIButton!
    @IBOutlet weak var retBtn: UIButton!
    @IBOutlet weak var selectdeplbl: UILabel!
    @IBOutlet weak var selectFareTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var selectedFares: [SelectFare] = []
    var btnTapString = String()
    var showFareSelectedBool = false
    var delegate:SelectFareTVCellDelegate?
    
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
        
       
        
        if selectedFares.count == 2 {
            depBtn.isUserInteractionEnabled = false
            retBtn.isUserInteractionEnabled = false
            showFareSelectedBool = true
            
            updateHeight(count: selectedFares.count)
        }
        
        if selectedFares.count == 0 {
            depBtn.isUserInteractionEnabled = true
            retBtn.isUserInteractionEnabled = true
            showFareSelectedBool = false
            
            updateHeight(count: 10)
        }
    }
    
    func updateHeight(count:Int) {
        tvHeight.constant = CGFloat(170 * count)
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
        selectdeplbl.text = "Select Fare for departure"
        btnTapString = "departure"
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
        btnTapString = "return"
    }
    
    
    
    func didTapOnCloseFareBtnAction(cell: SelectFareInfoTVCell) {
        // Update cell UI
        cell.selectBtn.isHidden = false
        cell.closeView.isHidden = true
        cell.holderView.borderColor = UIColor.BorderColor
        cell.holderView.backgroundColor = .WhiteColor
        
        // Access the content of the cell
        guard let indexPath = selectFareTV.indexPath(for: cell) else { return }
        
        // Check if the index is valid
        guard indexPath.row < selectedFares.count else { return }
        
        // Remove the corresponding SelectFare object from the selectedFares array
        selectedFares.remove(at: indexPath.row)
        
        
        
        
       
        
        delegate?.didTapOnCloseFareBtnAction(cell: self)
    }
    
    
    
    func didTapOnSelectFareBtnAction(cell: SelectFareInfoTVCell) {
        // Update cell UI
        cell.selectBtn.isHidden = true
        cell.closeView.isHidden = false
        cell.holderView.borderColor = UIColor.Buttoncolor
        cell.holderView.backgroundColor = .LayoverColor
        
        // Access the content of the cell
        guard let indexPath = selectFareTV.indexPath(for: cell) else { return }
        
        // Create a SelectFare object using the content from the cell
        let fare = SelectFare(fareName: cell.fareNamelbl.text,
                              cabinClass: cell.classlbl.text,
                              RefundableType: cell.refundTypelbl.text,
                              Baggage: cell.baggagelbl.text,
                              Price: cell.pricelbl.text,
                              selectedBool: true,
                              journyType: btnTapString) // Set the selectedBool as per your logic
        
        // Save the SelectFare object to the array
        selectedFares.append(fare)
        
        if selectedFares.count <= 1 {
            if btnTapString == "departure" {
                taponReturn()
            }
            if btnTapString == "return" {
                tapOnDep()
            }
            
        }
        
        if selectedFares.count == 2 {
            depBtn.isUserInteractionEnabled = false
            retBtn.isUserInteractionEnabled = false
            showFareSelectedBool = true
            
            updateHeight(count: selectedFares.count)
        }
        
        
        delegate?.didTapOnSelectFareBtnAction(cell: self)
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
        
        if showFareSelectedBool == false {
            return 10
        }else {
            return selectedFares.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        
        
        if showFareSelectedBool == false {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelectFareInfoTVCell {
                
                cell.selectionStyle = .none
                cell.delegate = self
                
                c = cell
                
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelectFareInfoTVCell {
                
                cell.selectionStyle = .none
                cell.delegate = self
                
                
                cell.selectBtn.isHidden = true
                cell.closeView.isHidden = false
                cell.holderView.borderColor = UIColor.Buttoncolor
                cell.holderView.backgroundColor = .LayoverColor
                
                c = cell
                
            }
        }
        return c
    }
    
}
