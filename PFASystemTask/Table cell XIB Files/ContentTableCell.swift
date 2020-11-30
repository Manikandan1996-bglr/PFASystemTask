//
//  ContentTableCell.swift
//  PFASystemTask
//
//  Created by Velozion Mac on 03/July/2019A.
//

import UIKit

class ContentTableCell: UITableViewCell {

    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var author: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
