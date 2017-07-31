//
//  ViewController.swift
//  ProductHunt
//
//  Created by Никита on 06.07.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

class WebsiteViewController: UIViewController, UIWebViewDelegate {
    
    var post: Post?
    var activityIndicator = UIActivityIndicatorView.init(frame: CGRect.init(
        x: UIScreen.main.bounds.width/2 - 50,
        y: UIScreen.main.bounds.height/2 - 50,
        width: 100,
        height: 100))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL.init(string: (self.post?.websiteURL)!)
        let request = NSURLRequest.init(url: url!)
        let webView = UIWebView.init(frame: CGRect.init(x: 0,
                                                        y: 0,
                                                        width: UIScreen.main.bounds.width,
                                                        height: UIScreen.main.bounds.height))
        webView.delegate = self
        webView.loadRequest(request as URLRequest)
        self.view.addSubview(webView)
        
        self.activityIndicator.activityIndicatorViewStyle = .gray
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        self.view.addSubview(self.activityIndicator)
    }
    
    //MARK: - UIWebViewDelegate
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activityIndicator.stopAnimating()
    }
}

