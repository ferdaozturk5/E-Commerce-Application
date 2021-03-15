//
//  ProductTableVC.swift
//  FinalProject
//
//  Created by Ferda Öztürk on 8.02.2021.
//

import UIKit
import Alamofire

class ProductTableVC: UITableViewController {
    
    @IBOutlet weak var load: UIActivityIndicatorView!
    var arr: [BilgilerProduct]? = []
    
    @IBAction func btnMyOrders(_ sender: UIBarButtonItem) {
    
        performSegue(withIdentifier: "orderlist", sender: arr)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load.startAnimating()
        navigationController?.navigationBar.barTintColor = UIColor(red: 76 / 255, green: 59 / 255, blue: 166 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 182 / 255, green: 193 / 255, blue: 240 / 255, alpha: 1)

        let params = ["ref":"5380f5dbcc3b1021f93ab24c3a1aac24", "start" : "0"]
        let url = "http://jsonbulut.com/json/product.php"
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            
            if(res.response?.statusCode == 200){
                
                let str = String(decoding: res.data!, as: UTF8.self)
                print(str)
                
                let product = try? JSONDecoder().decode(Products.self, from: res.data!)
                let status = product?.products[0].durum
                let message = product?.products[0].mesaj
                if(status == true){
                    self.arr = product?.products[0].bilgiler
                    self.tableView.reloadData()
                    self.load.stopAnimating()
                    self.load.alpha = 0
                    self.load.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                }
                else{
                    print(message!)
                }
                
            }
            
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let item = arr![indexPath.row]
        cell.pTitle.text = item.productName
        cell.pPrice.text = "\(item.price)₺"
        cell.pDetail.text = item.brief
        
        let url = URL(string: item.images[0].normal)
        let data = try! Data(contentsOf: url!)
        cell.pImage.image = UIImage(data: data)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = arr![indexPath.row]
        performSegue(withIdentifier: "detail", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detail"){
            let vc = segue.destination as! DetailViewController
            vc.item = (sender as! BilgilerProduct)
        }
    }
    

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation


}
