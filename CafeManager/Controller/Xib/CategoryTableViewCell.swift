//
//  CategoryTableViewCell.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-29.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCategoryName: UILabel!
    
    class var reuseIdentifier: String {
        return "categoryTableCellReuseIdentifier"
    }
    
    class var nibName: String {
        return "CategoryTableViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(category: FoodCategory) {
        lblCategoryName.text = category.categoryName
    }
    
}
