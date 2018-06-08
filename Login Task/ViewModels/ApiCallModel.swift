//
//  ViewModel.swift
//  Login Task
//
//  Created by Aakash patel on 07/06/18.
//  Copyright © 2018 aakash patel. All rights reserved.
//

import UIKit
import Alamofire
import KRProgressHUD

class ApiCallModel: NSObject {
    
    
    //MARK: Login_Api
    func loginApi(username : String, password : String, completion: @escaping (NSDictionary) -> Void){
        let parameters: Parameters = [
            "username": username,
            "password": password,
            
            ]
        
        let Url = (url as String) + "login"
        KRProgressHUD.show()
        
        Alamofire.request(Url,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers:nil)
            .validate()
            .responseJSON { response in
                
                if let json = response.result.value {
                    completion(json as! NSDictionary)
                }
                KRProgressHUD.dismiss()
        }
    }
    
}
