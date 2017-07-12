//
//  ProductCell.swift
//  ProductHunt
//
//  Created by Никита on 07.07.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var thambnailImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var upvotesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
