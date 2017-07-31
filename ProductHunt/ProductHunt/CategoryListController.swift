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
    let networkClient = NetworkClient()
    var categories = [Category]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString.init(string: "Идет обновление...")
        refreshControl.addTarget(self,
                                 action: #selector(CategoryListController.refresh(sender:)),
                                 for: UIControlEvents.valueChanged)
        fetchCategories()
    }
    
    // MARK: - Helper methods
    
    func refresh(sender:AnyObject) {
        fetchCategories()
    }
    
    func fetchCategories() {
        self.networkClient.obtainCategories { (response) in
            switch response.result {
                
            case .success(let value):
                guard let categories = Category.getArray(from: value) else { return }
                self.categories = categories
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            case .failure(let error):
                let alertController = UIAlertController.init(title: "Error",
                                                             message: error.localizedDescription,
                                                             preferredStyle: UIAlertControllerStyle.alert)
                let actionOK = UIAlertAction.init(title: "OK",
                                                  style: UIAlertActionStyle.default,
                                                  handler: nil)
                alertController.addAction(actionOK)
                DispatchQueue.main.async(execute: {
                    self.present(alertController, animated: true, completion: nil)
                })
            }
        }
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier,
                                                 for: indexPath) as! CategoryCell
        cell.textLabel?.text = self.categories[indexPath.row].name
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         guard let productListController = navigationController?.viewControllers.first as? ProductListController else {return}
        
        productListController.categoryButtonItem.title = self.categories[indexPath.row].name
        navigationController?.popViewController(animated: true)
    }
}





