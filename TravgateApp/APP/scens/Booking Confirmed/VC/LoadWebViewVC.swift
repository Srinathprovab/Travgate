//
//  LoadWebViewVC.swift
//  AlghanimTravelApp
//
//  Created by FCI on 29/09/22.
//

import UIKit
import WebKit
import SwiftyJSON

class LoadWebViewVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var webview: WKWebView!
    
    
    static var newInstance: LoadWebViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Calender.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoadWebViewVC
        return vc
    }
    
    
    var urlString = String()
    var keystr = String()
    var apicallbool = true
    var openpaymentgatewaybool = false
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    
    override func viewWillAppear(_ animated: Bool) {
        //loderBool = false
        
        activityIndicatorView.startAnimating()
        self.webview.isUserInteractionEnabled = false
        
        
        if let url1 = URL(string: urlString) {
            webview.load(URLRequest(url: url1))
        }
        
        
        
        let seconds = 60.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            if  openpaymentgatewaybool == false {
                
                
                showAlertOnWindow(title: "",message: "Somthing Went Wrong",titles: ["OK"]) { title in
                    self.gotoDashboard()
                }
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    
    func setupUI() {
        
       
        
        holderView.backgroundColor = .WhiteColor
        // Do any additional setup after loading the view.
        activityIndicatorView.center = view.center
        activityIndicatorView.color = .Buttoncolor
        view.addSubview(activityIndicatorView)
        
       
        webview.navigationDelegate = self
//        webview.isUserInteractionEnabled = true
        
        
        if keystr == "voucher" {
            titlelbl.text = "Voucher Details"
        }else {
            titlelbl.text = ""
        }
    }
    
   
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        gotoDashboard()
    }
    
    
    func gotoDashboard() {
        BASE_URL = BASE_URL1
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        present(vc, animated: true)
    }
    
}


extension LoadWebViewVC {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let response = navigationResponse.response as? HTTPURLResponse {
            print(response)
            
            if response.statusCode == 200 {
                openpaymentgatewaybool = true
            }
            
        }
        decisionHandler(.allow)
    }
    
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        openpaymentgatewaybool = true
        debugPrint("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        
        // Simulate a time-consuming operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Stop the activity indicator after 3 seconds (replace this with your actual data-fetching logic)
            self.activityIndicatorView.stopAnimating()
            self.webview.isUserInteractionEnabled = true
            
        }
//        
//        
//        let str = webView.url?.absoluteString ?? ""
//        webview.isHidden = false
//        if apicallbool == false {
//            
//            if str.containsIgnoringCase(find: "paymentcancel") || str.containsIgnoringCase(find: "CANCELED") || str.containsIgnoringCase(find: "bookingFailuer"){
//                
//                webview.isHidden = true
//                showAlertOnWindow(title: "",message: "Click Ok To Start New Search",titles: ["OK"]) { title in
//                    self.gotoDashboard()
//                }
//            }else {
//                
//                webview.isHidden = true
//                
//                if let url1 = URL(string: str) {
//                    webview.load(URLRequest(url: url1))
//                }
//                
////                if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
////                    if tabselect == "Flight" {
////                        if str.contains(find: "flight/secure_booking"){
////                            BASE_URL = ""
////                          //  callSecureBookingAPI(urlstr: str)
////                        }
////                        
////                        
////                    }else {
////                        if  str.contains(find: "payment_gateway/success"){
////                            BASE_URL = ""
////                           // callPayMentSucessAPI(urlstr: str)
////                        }
////                        
////                        
////                    }
////                }
//                
//                
//            }
//        }
//        apicallbool = false
//        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("didFail")
    }
    
    
    
    
}
extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
