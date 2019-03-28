//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Ousmane Ouedraogo on 3/26/19.
//  Copyright © 2019 Ousmane Ouedraogo. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    var minutes: Int!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var timaRemainingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        
    }

   
    
}
