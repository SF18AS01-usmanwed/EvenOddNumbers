//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Ousmane Ouedraogo on 3/21/19.
//  Copyright © 2019 Ousmane Ouedraogo. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    var menuItem: MenuItem!

    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      addToOrderButton.layer.cornerRadius = 5.0
      updateUI()
        // Do any additional setup after loading the view.
    }
    func updateUI() {
            titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        detailTextLabel.text = menuItem.detailText
        MenuController.shared.fetchImage(url: menuItem.imageURL)
            { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
            self.imageView.image = image
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addToOrderButtonTapped(_ sender: UIButton) {
            UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform =
            CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.addToOrderButton.transform =
            CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        MenuController.shared.order.menuItems.append(menuItem)
    }
}
