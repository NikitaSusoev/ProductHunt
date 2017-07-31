//
//  ProductPageController.swift
//  ProductHunt
//
//  Created by Никита on 09.07.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

class ProductPageController: UITableViewController {
    
    var post: Post?
    let productPageCellIdentifier = "ProductPageIdentifier"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "ProductPageCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: productPageCellIdentifier)
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: productPageCellIdentifier,
                                                 for: indexPath) as! ProductPageCell
        let upvotesCount = self.post?.votesCount ?? 0
        let url = URL.init(string: (self.post!.thumbnailImageURL)!)
        let data = NSData.init(contentsOf: url!)
        
        cell.screenshotImageView.image = UIImage.init(data: data! as Data)
        cell.nameLabel.text = self.post?.name
        cell.captionLabel.text = self.post?.tagline
        cell.upvotesLabel.text = "Upvotes " + String.init(stringInterpolationSegment: upvotesCount)

        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //MARK: - Actions
    
    @IBAction func tabGetItButton(_ sender: Any) {
        if self.post?.websiteURL != nil && self.post?.websiteURL != "" {
            let websiteViewController = WebsiteViewController()
            websiteViewController.post = self.post
            navigationController?.pushViewController(websiteViewController, animated: true)
        
        } else {
            let alertController = UIAlertController.init(title: nil,
                                                         message: "Don't have website",
                                                         preferredStyle: .alert)
            let actionOK = UIAlertAction.init(title: "OK", style: .default, handler:nil)
            alertController.addAction(actionOK)
            present(alertController, animated: true, completion: nil)
        }
    }
}
