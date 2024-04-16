//
//  SelectLanguageVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SelectLanguageVC: BaseTableVC, CurrencyListViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var langView: UIView!
    @IBOutlet weak var langlbl: UILabel!
    @IBOutlet weak var langUL: UIView!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var currencyUL: UIView!
    @IBOutlet weak var currencBtn: UIButton!
    
    
    static var newInstance: SelectLanguageVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectLanguageVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        callGetCurrencyListAPI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        MySingleton.shared.currencylistvm = CurrencyListViewModel(self)
        setupUI()
        
    }
    
    
    func setupUI() {
        langView.isHidden = true
        currencyView.isHidden = true
        
        langBtn.isUserInteractionEnabled = false
        currencyView.isHidden = true
        commonTableView.registerTVCells(["SelectLanguageTVCell",
                                         "EmptyTVCell"])
        
    }
    
    
    func setuplanguageTVCell() {
        
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(title:"English",subTitle: "",key:"lang",image: "english",cellType: .SelectLanguageTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Arabic",subTitle: "",key:"lang",image: "arabic",cellType: .SelectLanguageTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    
    @IBAction func closeBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnLanguageBtn(_ sender: Any) {
        
        langlbl.textColor = .TitleColor
        langUL.backgroundColor = .WhiteColor
        
        currencylbl.textColor = .Buttoncolor
        currencyUL.backgroundColor = .Buttoncolor
        setupCurencyTVCell()
    }
    
    
    @IBAction func didTapOncurrencBtn(_ sender: Any) {
        langlbl.textColor = .TitleColor
        langUL.backgroundColor = .WhiteColor
        
        currencylbl.textColor = .Buttoncolor
        currencyUL.backgroundColor = .Buttoncolor
        setupCurencyTVCell()
    }
    
    
}




extension SelectLanguageVC {
    
    
    
    func callGetCurrencyListAPI() {
        MySingleton.shared.currencylistvm?.CALL_GET_CURRENCY_LIST_API(dictParam: [:])
    }
    
    
    func currencylist(response: CurrencyListModel) {
        MySingleton.shared.currencyListArray = response.currency_list ?? []
        
        
        DispatchQueue.main.async {
            self.setupCurencyTVCell()
        }
    }
    
    func setupCurencyTVCell() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.currencyListArray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(title:"\(i.name ?? "")",
                                                        subTitle: "\(i.code ?? "")",
                                                        key:"lang1",
                                                        cellType: .SelectLanguageTVCell))
            
        }
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.selected()
            defaults.set(cell.subTitlelbl.text, forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set(cell.type, forKey: UserDefaultsKeys.selectedCurrencyType)
            
            NotificationCenter.default.post(name: NSNotification.Name("selectedCurrency"), object: nil)
            dismiss(animated: true)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.unselected()
        }
    }
    
}
