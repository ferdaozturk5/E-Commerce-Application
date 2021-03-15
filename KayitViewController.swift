//
//  KayitViewController.swift
//  FinalProject
//
//  Created by Ferda Öztürk on 3.02.2021.
//

import UIKit
import Alamofire
import SCLAlertView
import PMSuperButton

class KayitViewController: UIViewController{
    
    var user : [UserRegistry]? = []

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtMail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func btnKaydol(_ sender: PMSuperButton) {
        
        let name = txtName.text!
        let surname = txtSurname.text!
        let phone = txtPhone.text!
        let mail = txtMail.text!
        let parola = txtPassword.text!
        
        if name != "" && surname != "" && phone != "" && mail != "" && parola != "" {
            
            let params = ["ref" : "5380f5dbcc3b1021f93ab24c3a1aac24", "userName": name, "userSurname" : surname ,"userPhone" : phone, "userMail" : mail, "userPass" : parola]
            //http:/jsonbulut.com/json/userRegister.php?ref=5380f5dbcc3b1021f93ab24c3a1aac24&user Name=demo&userSurname=demo&userPhone=05333333333&userMail=ali@ali.com&user Pass=123456
            let url = "http://jsonbulut.com/json/userRegister.php"
            AF.request(url, method: .get, parameters: params).responseJSON { (res) in
                
                if ( res.response?.statusCode == 200 ){
                    let str = String(decoding: res.data!, as: UTF8.self)
                    print(str)
                    let userRegis = try? JSONDecoder().decode(UserRegistry.self, from: res.data!)
                    let status = userRegis?.user[0].durum
                    let message = userRegis?.user[0].mesaj
                    
                    if( status == true ){
                        let userID = userRegis!.user[0].kullaniciID
                        UserDefaults.standard.setValue(userID, forKey: "userID")
                        SCLAlertView().showSuccess("İşlem başarılı!", subTitle: "Kaydınız başarıyla sağlandı")
                        self.performSegue(withIdentifier: "products", sender: nil)
                        print("Succesful registration")}
                    else {
                        SCLAlertView().showError("Hay aksi!", subTitle: message!)
                    }
                }
            }
        }
        else{SCLAlertView().showError("Eksik alan!", subTitle: "Lütfen bilgileri eksiksiz doldurun.")}

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
