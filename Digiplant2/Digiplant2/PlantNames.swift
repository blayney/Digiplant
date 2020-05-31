//
//  PlantNames.swift
//  Digiplant2
//
//  Created by Will Blayney on 31/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class PlantNames: UITableViewCell {
    var cellTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization Code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    func setCellContent(text: String) {

        let cellTitleLabel = UILabel(frame: CGRect(x: 45,y: 2,width: 100,height: 20))
        cellTitleLabel.textAlignment = NSTextAlignment.left
        cellTitleLabel.text = text
        cellTitleLabel.font = UIFont(name: "Swiss721BT-Roman", size: 16)
        self.addSubview(cellTitleLabel)

        self.cellTitleLabel = cellTitleLabel

    }

    
}
