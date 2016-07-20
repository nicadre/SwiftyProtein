//
//  PopOverController.swift
//  SwiftyProtein
//
//  Created by Leo LAPILLONNE on 7/20/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {
    
    @IBOutlet weak var atomTypeLabel: UILabel!
    
    var atomType: String = ""
    
    override func viewDidLoad() {
        self.atomTypeLabel.text = "Type: \(atomType)"
        
        
    }
}
