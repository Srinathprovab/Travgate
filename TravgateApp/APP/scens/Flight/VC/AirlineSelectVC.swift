//
//  AirlineSelectVC.swift
//  Travgate
//
//  Created by FCI on 08/03/24.
//

import UIKit

class AirlineSelectVC: UIViewController, AirlineListViewModelDelegate, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var searchTextfieldHolderView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var airlineTV: UITableView!
    
    static var newInstance: AirlineSelectVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AirlineSelectVC
        return vc
    }
    
    
    var keyStr = String()
    var filtered:[Airline_list] = []
    var airlineList:[Airline_list] = []
    var airlinevm: AirlineListViewModel?
    var tablerow = [TableRow]()
    var titleStr = String()
    var payload = [String:Any]()
    var isSearchBool = false
    var searchText = String()
    var celltag = Int()
    var tokey = String()
    var airlineNamesArray = [String]()
    var airlineCodesArray = [String]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        callGetAirlineListAPI(str: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        airlinevm = AirlineListViewModel(self)
    }
    
    
    
    func setupUI() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        searchTF.placeholder = "search airline"
        
        
        // searchTF.becomeFirstResponder()
        searchTF.backgroundColor = .clear
        searchTF.setLeftPaddingPoints(20)
        searchTF.font = UIFont.OpenSansRegular(size: 16)
        searchTF.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        
        
        airlineTV.register(UINib(nibName: "LabelTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        airlineTV.delegate = self
        airlineTV.dataSource = self
        
    }
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}



extension AirlineSelectVC {
    
    
    @objc func searchTextChanged(_ sender: UITextField) {
        searchText = sender.text ?? ""
        
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
        
        callGetAirlineListAPI(str: searchText)
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filtered.removeAll()
        filtered = self.airlineList.filter { thing in
            return "\(thing.airline_name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        airlineTV.reloadData()
    }
    
}


extension AirlineSelectVC {
    
    
    func callGetAirlineListAPI(str:String) {
        payload.removeAll()
        payload["filter"] = str
        airlinevm?.CALL_GET_AIRLINE_LIST_API(dictParam: payload)
    }
    
    
    func airlinelist(response: AirlineListModel) {
        
        airlineList = response.airline_list ?? []
        
        airlineNamesArray.removeAll()
        airlineCodesArray.removeAll()
        
        airlineNamesArray.append("ALL")
        airlineCodesArray.append("ALL")
        airlineList.forEach { i in
            airlineNamesArray.append(i.airline_name ?? "")
            airlineCodesArray.append(i.airline_code ?? "")
        }
        
        DispatchQueue.main.async {
            self.airlineTV.reloadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airlineNamesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? LabelTVCell {
            
            
            
            cell.titlelbl.textColor = .AppLabelColor
            cell.titlelbl.font = .OpenSansMedium(size: 16)
            cell.titlelbl.textAlignment = .left
            cell.titlelbl.text = airlineNamesArray[indexPath.row]
            cell.airlinecode = airlineCodesArray[indexPath.row]
            
            
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? LabelTVCell {
            
            defaults.set(cell.titlelbl.text, forKey: UserDefaultsKeys.fcariername)
            defaults.set(cell.airlinecode, forKey: UserDefaultsKeys.fcariercode)
            
            dismiss(animated: false)
            NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        }
    }
    
}



