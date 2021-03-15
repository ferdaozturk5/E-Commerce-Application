//
//  GirisViewController.swift
//  FinalProject
//
//  Created by Ferda Öztürk on 1.02.2021.
//

import UIKit
import Alamofire
import SCLAlertView
import PMSuperButton

class GirisViewController: UIViewController {

    @IBOutlet weak var txtMail: UITextField!
    @IBOutlet weak var txtParola: UITextField!
    @IBAction func btnGiris(_ sender: PMSuperButton) {
        
        let email = txtMail.text!
        let parola = txtParola.text!
        
        let params = ["ref" : "5380f5dbcc3b1021f93ab24c3a1aac24", "userEmail" : email, "userPass" : parola, "face" : "no"]
        //http:/jsonbulut.com/json/userLogin.php?ref=5380f5dbcc3b1021f93ab24c3a1aac24&userEm ail=ali@ali.com&userPass=12345&face=no
        let url = "http://jsonbulut.com/json/userLogin.php"
        
        if email != "" && parola != "" {
            AF.request(url, method: .get, parameters: params).responseJSON { (res) in
                if ( res.response?.statusCode == 200 ){
                    
                    print(res.data!)
                    let userLogin = try? JSONDecoder().decode(UserLogin.self, from: res.data!)
                    
                    let status = userLogin?.user[0].durum
                    let message = userLogin?.user[0].mesaj
                    if( status == true ){
                        
                        let userID = userLogin?.user[0].bilgiler?.userID
                        UserDefaults.standard.setValue(userID, forKey: "userID")
                        SCLAlertView().showSuccess("İşlem başarılı!", subTitle: message!)
                        self.performSegue(withIdentifier: "products", sender: nil)
                        print("Succesful login")
                    }else{
                        SCLAlertView().showError("Hay aksi!", subTitle: message!)
                    }
                }
            }
        }
        else{SCLAlertView().showError("Eksik alan!", subTitle: "Email veya parola boş bırakılamaz.")}
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    }
    


