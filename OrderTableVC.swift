//
//  OrderTableVC.swift
//  FinalProject
//
//  Created by Ferda Öztürk on 10.02.2021.
//

import UIKit
import Alamofire
import SCLAlertView

class OrderTableVC: UITableViewController {

    @IBOutlet weak var load: UIActivityIndicatorView!
    var userOrder: [OrderListElement]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customerId = UserDefaults.standard.string(forKey: "userID")
        let params = ["ref":"5380f5dbcc3b1021f93ab24c3a1aac24", "musterilerID" : customerId]
        let url = "http://jsonbulut.com/json/orderList.php"
        load.startAnimating()
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            if(res.response?.statusCode == 200){
                
                let str = String(decoding: res.data!, as: UTF8.self)
                print(str)
                
                let orderA = try? JSONDecoder().decode(OrderList.self, from: res.data!)
                if(orderA?.orderList![0] != nil){
                    self.userOrder = orderA?.orderList![0]
                    self.tableView.reloadData()
                    self.load.stopAnimating()
                    self.load.alpha = 0
                    self.load.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                }
                else{
                    SCLAlertView().showError("Hay aksi!", subTitle: "Bir şeyler ters gitti.")
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userOrder!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ordercell", for: indexPath) as! CustomCell
        
        if userOrder?[indexPath.row] != nil {
            let item = userOrder![indexPath.row]
            if item.urunAdi != nil{
                
                cell.pTitle.text = item.urunAdi
                let url = URL(string: item.normal!)
                let data = try! Data(contentsOf: url!)
                cell.pImage.image = UIImage(data: data)
                cell.pPrice.text = item.fiyat
            }
            //cell.pTitle.text = item.urunAdi
            //let url = URL(string: item.normal!)
            //let data = try! Data(contentsOf: url!)
            //cell.pImage.image = UIImage(data: data)
            
        }

        return cell
    }
}
