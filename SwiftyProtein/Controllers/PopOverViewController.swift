//
//  PopOverController.swift
//  SwiftyProtein
//
//  Created by Leo LAPILLONNE on 7/20/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {
    
    @IBOutlet weak var chemicalIdLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var chemicalNameLabel: UILabel!
    @IBOutlet weak var formulaLabel: UILabel!

    
    var chemicalId: String = ""
    var type: String = ""
    var weight: String = ""
    var chemicalName: String = ""
    var formula: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chemicalIdLabel.text = "\(chemicalId)"
        self.typeLabel.text = "\(type)"
        self.weightLabel.text = "\(weight)"
        self.chemicalNameLabel.text = "\(chemicalName)"
        self.formulaLabel.text = "\(formula)"
        
    }
}
