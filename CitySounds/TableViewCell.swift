//
//  TableViewCell.swift
//  CitySounds
//
//  Created by Scott on 2/8/20.
//  Copyright © 2020 RiptidaL. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameCellLabel: UILabel!
    
    @IBOutlet weak var eventLocationCellLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
