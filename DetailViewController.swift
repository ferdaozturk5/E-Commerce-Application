//
//  DetailViewController.swift
//  FinalProject
//
//  Created by Ferda Öztürk on 9.02.2021.
//

import UIKit
import Alamofire
import SCLAlertView
import PMSuperButton


class DetailViewController: UIViewController {

    var item: BilgilerProduct!
    var giveOrder: [OrderElement?] = []

    
    @IBOutlet weak var dTitle: UILabel!
    @IBOutlet weak var dImage: UIImageView!
    @IBOutlet weak var dDetail: UITextView!
    @IBOutlet weak var dPrice: UILabel!
    @IBAction func btnOrder(_ sender: PMSuperButton) {
        
        let productId = item.productID
        let userId  = UserDefaults.standard.string(forKey: "userID")
        print(productId)
        print("userId", userId as Any)
      
        let params = ["ref" : "5380f5dbcc3b1021f93ab24c3a1aac24", "customerId" : userId, "productId" : productId, "html" : productId]
        
        let url = "http://jsonbulut.com/json/orderForm.php"
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            if ( res.response?.statusCode == 200 ){
                
                let str = String(decoding: res.data!, as:UTF8.self)
                print(str) //data bilgisini string olarak görmek için örneğin: "Referans kodu eksik"
                
                let giveOrder = try? JSONDecoder().decode(Order.self, from: res.data!)
                
                let status = giveOrder?.order[0].durum
                let message = giveOrder?.order[0].mesaj
                
                if( status == true ){
                    SCLAlertView().showSuccess("İşlem başarılı!", subTitle: message!)
                    
                }else{
                    SCLAlertView().showError("Hay aksi!", subTitle: message!)
                }
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dTitle.text = item.productName
        dPrice.text = "\(item.price)₺"
        dDetail.text = item.bilgilerProductDescription
        let url = URL(string: item.images[0].normal)
        let data = try! Data(contentsOf: url!)
        dImage.image = UIImage(data: data)
        
    }
    
}
