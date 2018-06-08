//
//  ViewController.swift
//  Login Task
//
//  Created by Aakash patel on 07/06/18.
//  Copyright © 2018 aakash patel. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldUsername : UITextField!
    @IBOutlet weak var textFieldPassword : UITextField!
    
    let utility = Utility()
    let ApicallModel = ApiCallModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login Task"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    //MARK: Action_Login
    @IBAction func Action_Login(sender : Any)
    {
        self.view.endEditing(true)
        var flagforblankTxtfield = false
        for subview in view.subviews {
            
            if let txtField = subview as? UITextField {
                let validUser = utility.validateTxtfield(value: (txtField.text)!, alertmsg: txtField.placeholder!)
                if !validUser{
                    flagforblankTxtfield = true
                    break
                }

            }
        }

        if flagforblankTxtfield{
            return
        }
        
        ApicallModel.loginApi(username: textFieldUsername.text!, password: textFieldPassword.text!) { response in
            let statusCheck = (response as AnyObject).object(forKey:"errorCode") as! String
            
            if (statusCheck == "00"){
                
                let realm = try! Realm()
                let datamodel = DataModel()
                let resultForDelete = realm.objects(DataModel.self)
                try! realm.write {
                        realm.delete(resultForDelete)
                }
                
                datamodel.TokenString = "ashdkjsadhksahdjksahdasd"
                realm.beginWrite()
                realm.add(datamodel)
                try! realm.commitWrite()
                
                self.performSegue(withIdentifier: "segueHome", sender: nil)


            }else{
                let msg = (response as AnyObject).object(forKey:"errorMessage") as! String
                self.utility.showAlert(message: msg)
                
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

