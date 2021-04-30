//
//  SampleViewController.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-29.
//

import UIKit

class SampleViewController: UIViewController {
    
    var tabBar: UITabBarController?
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tabChanged(_ sender: UISegmentedControl) {
        self.tabBar?.selectedIndex = sender.selectedSegmentIndex
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarVC = segue.destination as? UITabBarController else {
            return
            
        }
        self.tabBar = tabBarVC
        self.tabBar?.tabBar.isHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
