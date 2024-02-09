//
//  NationalityVC.swift
//  HolidaysCenter
//
//  Created by FCI on 19/05/23.
//

import UIKit

class NationalityVC: BaseTableVC, AirlineListViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var searchTextfieldHolderView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    
    
    var airlinecodeArray = [String]()
    var airlineNameArray = [String]()
    
    var hotelFilterd:[Country_list]  = []
    var filtered:[All_country_code_list] = []
    var airlinelist:[Airline_list] = []
    var vm: AirlineListViewModel?
    var tablerow = [TableRow]()
    var titleStr = String()
    var payload = [String:Any]()
    var isSearchBool = Bool()
    var searchText = String()
    
    static var newInstance: NationalityVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? NationalityVC
        return vc
    }
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        
        callAPI()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = AirlineListViewModel(self)
    }
    
    
    func setupUI() {
        
        
        searchImg.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        searchTF.becomeFirstResponder()
        searchTF.backgroundColor = .clear
        searchTF.setLeftPaddingPoints(40)
        searchTF.font = UIFont.LatoRegular(size: 16)
        commonTableView.backgroundColor = .WhiteColor
        searchTF.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        commonTableView.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        commonTableView.separatorStyle = .singleLine
        commonTableView.separatorColor = .lightGray
        
    }
    
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    @objc func searchTextChanged(_ sender: UITextField) {
        searchText = sender.text ?? ""
        
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
        
    }
    
    
    
    func filterContentForSearchText(_ searchText: String) {
        
        filtered.removeAll()
        filtered = MySingleton.shared.clist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        //loadData(list: filtered)
        
        commonTableView.reloadData()
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}

extension NationalityVC {
    
    
    func callAPI() {
        //vm?.CALL_GET_AIRLINE_LIST_API(dictParam: [:])
        
        
        airlineNameArray.removeAll()
        airlinecodeArray.removeAll()
        
        airlineNameArray.append("ALL")
        airlinecodeArray.append("ALL")
        MySingleton.shared.clist.forEach { i in
            airlineNameArray.append(i.name ?? "")
            airlinecodeArray.append(i.country_code ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    func airlinelist(response: AirlineListModel) {
        airlinelist.removeAll()
        airlineNameArray.removeAll()
        airlinecodeArray.removeAll()
        
        airlinelist = response.airline_list ?? []
        loadData(list: airlinelist)
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    func loadData(list:[Airline_list]) {
        airlineNameArray.removeAll()
        airlinecodeArray.removeAll()
        
        airlineNameArray.append("ALL")
        airlinecodeArray.append("ALL")
        list.forEach { i in
            airlineNameArray.append(i.airline_name ?? "")
            airlinecodeArray.append(i.id ?? "")
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check search text & original text
        
        if( isSearchBool == true){
            return airlineNameArray.count
        }else{
            return airlineNameArray.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TitleLblTVCell {
            cell.selectionStyle = .none
            
            
            if( isSearchBool == true){
                // let dict = filtered[indexPath.row]
                cell.titlelbl.text = airlineNameArray[indexPath.row]
                cell.airlinecode = airlinecodeArray[indexPath.row]
            }else{
                //  let dict = airlinelist[indexPath.row]
                cell.titlelbl.text = airlineNameArray[indexPath.row]
                cell.airlinecode = airlinecodeArray[indexPath.row]
            }
            
            ccell = cell
        }
        return ccell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? TitleLblTVCell {
            
            defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.hnationality)
            defaults.set(cell.airlinecode , forKey: UserDefaultsKeys.hnationalitycode)
            
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        self.dismiss(animated: true)
    }
    
    
}
