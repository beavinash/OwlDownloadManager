//
//  OwlTableViewCell.swift
//  DownloadManager
//
//  Created by Avinash Reddy on 3/3/19.
//  Copyright © 2019 725-1 Corporation. All rights reserved.
//

import UIKit

class OwlTableViewCell: UITableViewCell {
    
    //MARK: - Properties for UITableViewCell
    
    @IBOutlet weak var dataCellLabel: UILabel!
    
    //MARK: - Additional functions for UITableViewCell Configuration
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
