//
//  OttuPaymentGatewayVC.swift
//  Travgate
//
//  Created by FCI on 26/03/24.
//

import UIKit
import Ottu

class OttuPaymentGatewayVC: UIViewController, OttuDelegate {
    
    
    static var newInstance: OttuPaymentGatewayVC? {
        let storyboard = UIStoryboard(name: Storyboard.Ottu.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? OttuPaymentGatewayVC
        return vc
    }
    
    
    var responseDict : [String:Any]?
    var message = ""
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        callPaymentGateway()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    
    func callPaymentGateway() {
        
        //Intiate the SDK accordingly after getting session id from the public API documentation.
        //session_id - It is generated when payment was created. See API documentation
        //merchant_id - Merchant domain. See API documentation.
        //apiKey - API Public key should be used. See API documentation.
        //lang - You can use it to change the language. We support two languages english and arabic. You can use "en" for english and "ar" for arabic.
       
       print(MySingleton.shared.sessionid)
        print(MySingleton.shared.merchantid)
        print(authorizationkey)
        
        
        let session_id = "\(MySingleton.shared.sessionid)"
        _ = Ottu.init(session_id,
                      merchant_id: "\(MySingleton.shared.merchantid)",
                      apiKey: "\(authorizationkey)",
                      lang: "en",
                      viewController: self,
                      delegate: self)
    }
    
    //The error callback is invoked when problems occur during a payment.
    //Reason will be defined in the response attribute.
    func errorCallback(message: String, response: [String : Any]?) {
        responseDict = response
        self.message = "Error"
        self.dismissed()
        
    }
    
    //Called when a customer cancels the payment.
    func cancelCallback(message: String, response: [String : Any]?) {
        responseDict = response
        self.message = "Cancel"
        self.dismissed()
    }
    
    //Called when the payment completed successfully.
    func successCallback(message: String, response: [String : Any]?) {
        responseDict = response
        print(response)
        self.message = "Success"
        self.dismissed()
    }
    
    //It is a helper function that has to return a promise object, to create the redirect_url.
    //This allows the merchant to redirect the user to the cart page and wait for a while before creating the redirect_url.
    //In case the customer changes items in the cart, the due amount will be updated accordingly, then the merchant will wait for a while until the customer does not return, then the function returns a promise object, the cart will be frozen and marked as submitted, and the redirect_url will be generated.
    func beforeRedirect() {
        
    }
    
    //After successCallback or cancelCallback or errorCallback you can show alert to the user accordingly.
    func dismissed() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            let alert = UIAlertController(title: self.message.capitalized, message: "\(String(describing: self.responseDict))", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default){ (action) in
                self.goto()
            })
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func goto(){
        
    }
    
}
