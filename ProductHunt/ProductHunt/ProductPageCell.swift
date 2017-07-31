//
//  ProductPageCell.swift
//  ProductHunt
//
//  Created by Никита on 09.07.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

class ProductPageCell: UITableViewCell {

    @IBOutlet weak var upvotesLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
