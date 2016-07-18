//
//  LoginViewController.swift
//  SwiftyProtein
//
//  Created by Nicolas CHEVALIER on 7/13/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var touchIDButton: UIButton!

    override func viewDidLoad() {
		super.viewDidLoad()
        
        if /* touch id isn't available*/ true {
            touchIDButton.enabled = false
            touchIDButton.setImage(UIImage(named: "TouchID Disable"), forState: UIControlState.Normal)
            touchIDButton.sizeToFit()
        }
        
		// Do any additional setup after loading the view, typically from a nib.
	}
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (touchIDButton.enabled == false) {
            
            // display alert view
            let alert = UIAlertController(title: "Touch ID error", message: "Touch ID not available", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Destructive, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    @IBAction func touchIDButtonAction(sender: UIButton) {
    
        // Ask for touch id
        // perform segue
    
    }

}
