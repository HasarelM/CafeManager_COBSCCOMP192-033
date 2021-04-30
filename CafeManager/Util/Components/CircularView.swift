//
//  CircularView.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-28.
//

import Foundation
import UIKit

extension UIView {
    func generateRoundView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
    }
}
