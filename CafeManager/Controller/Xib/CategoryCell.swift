//
//  CategoryCell.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-29.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    class var reuseIdentifier: String {
        return "categoryReuseIdentifier"
    }
    
    class var nibName: String {
        return "CategoryCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(category: FoodCategory) {
        lblCategoryName.text = category.categoryName
        if category.isSelected {
            lblCategoryName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewContainer.backgroundColor = UIColor(named: "orange")
        } else {
            lblCategoryName.textColor = UIColor(named: "dark_gray")
            viewContainer.backgroundColor = UIColor(named: "Default")
        }
    }

}
