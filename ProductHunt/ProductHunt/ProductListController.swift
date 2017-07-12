//
//  ProductListController.swift
//  ProductHunt
//
//  Created by Никита on 06.07.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ProductListController: UITableViewController {
    
    @IBOutlet weak var categoryButtonItem: UIBarButtonItem!
    
    let categoryCellIdentifier = "ProductCell"
    var posts = [Post]()
    var activityIndicator = UIActivityIndicatorView.init(frame:  CGRect.init(x: UIScreen.main.bounds.width/2 - 50, y: UIScreen.main.bounds.height/2 - 50, width: 100, height: 100))
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.activityIndicator.activityIndicatorViewStyle = .gray
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        
        self.refreshControl?.addTarget(self, action: #selector(ProductListController.refresh(sender:)), for: .valueChanged)
        
        let params = ["access_token":"591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff",
                      "search[category]": self.categoryButtonItem.title!.lowercased(),
                      "sort_by":"created_at",
                      "order":"desc"]
        
        Alamofire.request("https://api.producthunt.com/v1/posts?", parameters: params).validate().responseJSON { (responseJSON) in
            switch responseJSON.result {
                
            case .success(let value):
                print(value)
                guard let posts = Post.getArray(from: value) else { return }
                self.posts = posts
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                    self.activityIndicator.stopAnimating()
                })
                
            case .failure(let error):
                print(error)
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func refresh(sender:AnyObject) {
        
        let params = ["access_token":"591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff",
                      "search[category]":self.categoryButtonItem.title!.lowercased(),
                      "sort_by":"created_at",
                      "order":"desc"]
        
        Alamofire.request("https://api.producthunt.com/v1/posts?", parameters: params).validate().responseJSON { (responseJSON) in
            switch responseJSON.result {
                
            case .success(let value):
                print(value)
                guard let posts = Post.getArray(from: value) else { return }
                self.posts = posts
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
                
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier, for: indexPath) as! ProductCell
        
        let post = self.posts[indexPath.row]
        let url = URL.init(string: post.thumbnailImageURL!)
        //let data = NSData.init(contentsOf: url!)
        
        cell.thambnailImageView.sd_setShowActivityIndicatorView(true)
        cell.thambnailImageView.sd_setIndicatorStyle(.gray)
        cell.thambnailImageView.sd_setImage(with: url)
        
        //cell.thambnailImageView.image = UIImage.init(data: data! as Data)
        cell.nameLabel.text = post.name
        cell.captionLabel.text = post.tagline
        let upvotesCount = post.votesCount ?? 0
        cell.upvotesLabel.text = "Upvotes " + String.init(stringInterpolationSegment: upvotesCount)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productPageController = ProductPageController()
        productPageController.post = self.posts[indexPath.row]
        navigationController?.pushViewController(productPageController, animated: true)
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

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
