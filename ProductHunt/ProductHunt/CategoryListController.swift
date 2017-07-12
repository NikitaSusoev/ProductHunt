//
//  CategoryListController.swift
//  ProductHunt
//
//  Created by Никита on 07.07.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import Alamofire

class CategoryListController: UITableViewController {
    
    let categoryCellIdentifier = "CategoryCell"
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString.init(string: "Идет обновление...")
        refreshControl.addTarget(self, action: Selector.init(("refresh")), for: UIControlEvents.valueChanged)
        
        let params = ["access_token":"591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"]
        
        Alamofire.request("https://api.producthunt.com//v1/categories", parameters: params).validate().responseJSON { (responseJSON) in
            switch responseJSON.result {
                
            case .success(let value):
                guard let categories = Category.getArray(from: value) else { return }
                self.categories = categories
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            case .failure(let error):
                print(error)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refresh(sender:AnyObject) {

    }
    
    /*
    func refresh(sender:AnyObject) {
        refreshBegin(newtext: "Refresh",
                     refreshEnd: {(x:Int) -> () in
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
        })
    }
    
    func refreshBegin(newtext:String, refreshEnd:@escaping (Int) -> ()) {
        dispatch_async(dispatch_get_global_queue(.default, 0)) {
            println("refreshing")
            self.text = newtext
            sleep(2)
            
            dispatch_async(dispatch_get_main_queue()) {
                refreshEnd(0)
            }
        }
    }*/

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier, for: indexPath) as! CategoryCell
        cell.textLabel?.text = self.categories[indexPath.row].name
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         guard let productListController = navigationController?.viewControllers.first  as? ProductListController else {return}
        
        productListController.categoryButtonItem.title = self.categories[indexPath.row].name
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let productListController = segue.destination as? ProductListController else {return}
        productListController.category = "books"
    }
 */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
