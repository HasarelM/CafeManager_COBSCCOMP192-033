//
//  StoreViewController.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-28.
//

import UIKit

class StoreViewController: BaseViewController {

    var tabBar: UITabBarController?
    @IBOutlet weak var segTabs: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeTabs" {
            guard let tabBar = segue.destination as? UITabBarController else {
                return
            }
            self.tabBar = tabBar
            self.tabBar?.tabBar.isHidden = true
        }
    }
    
    @IBAction func onSegmentTabChanged(_ sender: UISegmentedControl) {
        self.tabBar?.selectedIndex = sender.selectedSegmentIndex
    }
}
