//
//  CategoryCell.swift
//  ProductHunt
//
//  Created by Никита on 09.07.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
