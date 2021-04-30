//
//  RoundImage.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-27.
//

import UIKit

extension UIImageView {
    func generateRoundImage() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
}
