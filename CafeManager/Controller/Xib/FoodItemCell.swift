//
//  FoodItemCell.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-29.
//

import UIKit
import Kingfisher

class FoodItemCell: UITableViewCell {
    
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodDescription: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var viewOfferContainer: UIView!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var switchIsActive: UISwitch!
    
    var rowIndex: Int = 0
    var delegate: FoodItemCellActions?
    
    class var reuseIdentifier: String {
        return "foodItemReuseIdentifier"
    }
    
    class var nibName: String {
        return "FoodItemCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onFoodStatusChanged(_ sender: UISwitch) {
        self.delegate?.onFoodItemStatusChanged(status: sender.isOn, index: self.rowIndex)
    }
    
    func configureCell(foodItem: FoodItem, index: Int) {
        self.rowIndex = index
        if foodItem.discount == 0 {
            viewOfferContainer.isHidden = true
        } else {
            viewOfferContainer.isHidden = false
            lblDiscount.text = "\(foodItem.discount)% OFF"
        }
        
        switchIsActive.isOn = foodItem.isActive
        
        imgFood.kf.setImage(with: URL(string: foodItem.foodImgRes))
        lblFoodName.text = foodItem.foodName
        lblFoodDescription.text = foodItem.foodDescription
        lblFoodPrice.text = "\(foodItem.discountedPrice.lkrString)"
    }
    
}

protocol FoodItemCellActions {
    func onFoodItemStatusChanged(status: Bool, index: Int)
}
