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
    let networkClient = NetworkClient()
    var posts = [Post]()
    var activityIndicator = UIActivityIndicatorView.init(frame: CGRect.init(
        x: UIScreen.main.bounds.width/2 - 50,
        y: UIScreen.main.bounds.height/2 - 50,
        width: 100,
        height: 100))
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.activityIndicator.activityIndicatorViewStyle = .gray
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        self.refreshControl?.addTarget(self,
                                       action: #selector(ProductListController.refresh(sender:)),
                                       for: .valueChanged)
        fetchPosts()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helper methods
    
    func fetchPosts() {
        self.networkClient.obtainPosts(withCategoryName: self.categoryButtonItem.title!.lowercased()) { (response) in
            switch response.result {
                
            case .success(let value):
                guard let posts = Post.getArray(from: value) else { return }
                self.posts = posts
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                    self.activityIndicator.stopAnimating()
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
    
    func refresh(sender:AnyObject) {
        fetchPosts()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier,
                                                 for: indexPath) as! ProductCell
        let post = self.posts[indexPath.row]
        let upvotesCount = post.votesCount ?? 0
        let url = URL.init(string: post.thumbnailImageURL!)
        
        cell.thambnailImageView.sd_setShowActivityIndicatorView(true)
        cell.thambnailImageView.sd_setIndicatorStyle(.gray)
        cell.thambnailImageView.sd_setImage(with: url)
        cell.nameLabel.text = post.name
        cell.captionLabel.text = post.tagline
        cell.upvotesLabel.text = "Upvotes " + String.init(stringInterpolationSegment: upvotesCount)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productPageController = ProductPageController()
        productPageController.post = self.posts[indexPath.row]
        navigationController?.pushViewController(productPageController, animated: true)
    }
}
