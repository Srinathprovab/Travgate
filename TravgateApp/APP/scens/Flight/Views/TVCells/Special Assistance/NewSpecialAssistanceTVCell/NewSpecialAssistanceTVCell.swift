//
//  NewSpecialAssistanceTVCell.swift
//  Travgate
//
//  Created by FCI on 19/04/24.
//

import UIKit
import DropDown


protocol NewSpecialAssistanceTVCellDelegate {
    func didTapOnCheckBoxBtnAction(cell:NewSpecialAssistanceTVCell)
    func didTapOnServiceBtnAction(cell:NewSpecialAssistanceTVCell)
    func textViewDidChange(textView:UITextView)
}

class NewSpecialAssistanceTVCell: TableViewCell, AddAssistanceTVCellDelegate, UITextViewDelegate {
    
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var checkimg: UIImageView!
    @IBOutlet weak var servicelbl: UILabel!
    @IBOutlet weak var reducedMobilityView: UIView!
    @IBOutlet weak var genericRequestView: UIView!
    @IBOutlet weak var assistanceTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var messageTextView: UITextView!

    
    var placeHolder = String()
    var firstnameArray = [String]()
    var serviceDropDown = DropDown()
    var checkbool = false
    var delegate:NewSpecialAssistanceTVCellDelegate?
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
        serviceView.isHidden = true
        reducedMobilityView.isHidden = true
        genericRequestView.isHidden = true
        setupdescView()
        setupServicedropDown()
        setupTV()
        
    }
    
    override func updateUI() {
       
        firstnameArray = travelerArray.compactMap({$0.firstName})
        updateHeight()
    }
    
    
    func setupdescView() {
        
        messageTextView.layer.cornerRadius = 6
        messageTextView.clipsToBounds = true
        messageTextView.layer.borderWidth = 1
        messageTextView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        messageTextView.text = ""
        messageTextView.delegate = self
        messageTextView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        messageTextView.setPlaceholder(ph: placeHolder)
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder()
        delegate?.textViewDidChange(textView: textView)
    }
    
    @IBAction func didTapOnCheckBoxBtnAction(_ sender: Any) {
        checkbool.toggle()
        if checkbool {
            checkimg.image = UIImage(named: "check")
            serviceView.isHidden = false
           
        }else {
            checkimg.image = UIImage(named: "uncheck")
            serviceView.isHidden = true
            reducedMobilityView.isHidden = true
            setupUI()
        }
        
        delegate?.didTapOnCheckBoxBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnServiceBtnAction(_ sender: Any) {
        serviceDropDown.show()
    }
    
    
    func didTapOnShowAssistanceDropDownListBtnAction(cell: AddAssistanceTVCell) {
        cell.assistanceDropDown.show()
    }
    
    
    
    func updateHeight() {
        tvHeight.constant = CGFloat((firstnameArray.count * 120))
        assistanceTV.reloadData()
    }
    
}


extension NewSpecialAssistanceTVCell {
    
    //MARK: - setupVisaDestinationDropDown
    func setupServicedropDown() {
        
        self.servicelbl.text = "Select"
        serviceDropDown.dataSource = ["Reduced mobility","Generic Request"]
        serviceDropDown.direction = .bottom
        serviceDropDown.backgroundColor = .WhiteColor
        serviceDropDown.anchorView = self.serviceView
        serviceDropDown.bottomOffset = CGPoint(x: 0, y: self.serviceView.frame.size.height + 10)
        serviceDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.servicelbl.text = item
            self?.servicelbl.textColor = .TitleColor
            
            if item == "Reduced mobility" {
                self?.reducedMobilityView.isHidden = false
                self?.genericRequestView.isHidden = true
            }else {
                self?.reducedMobilityView.isHidden = true
                self?.genericRequestView.isHidden = false
            }
            
            self?.delegate?.didTapOnServiceBtnAction(cell: self!)
        }
    }
    
    
}



extension NewSpecialAssistanceTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        assistanceTV.register(UINib(nibName: "AddAssistanceTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        assistanceTV.delegate = self
        assistanceTV.dataSource = self
        assistanceTV.tableFooterView = UIView()
        assistanceTV.showsHorizontalScrollIndicator = false
        assistanceTV.separatorStyle = .singleLine
        assistanceTV.isScrollEnabled = false
        assistanceTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstnameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAssistanceTVCell {
            
            cell.selectionStyle = .none
            
            cell.delegate = self
            cell.travellerNamelbl.text = firstnameArray[indexPath.row]
            
            
            c = cell
            
        }
        return c
    }
    
}
