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
    @IBOutlet weak var webview: WKWebView!
    
    
    static var newInstance: LoadWebViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Calender.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoadWebViewVC
        return vc
    }
    
    
    var urlString = String()
   
  
    
    
    override func viewWillAppear(_ animated: Bool) {
        //loderBool = false
        
     
        if let url1 = URL(string: urlString) {
            webview.load(URLRequest(url: url1))
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    
    func setupUI() {
        
       
        
        holderView.backgroundColor = .WhiteColor
       
        webview.navigationDelegate = self
        webview.isUserInteractionEnabled = true
        
    }
    
   
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
}


extension LoadWebViewVC {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let response = navigationResponse.response as? HTTPURLResponse {
            print(response)
           
        }
        decisionHandler(.allow)
    }
    
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
       
        debugPrint("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("didFail")
    }

    
}
