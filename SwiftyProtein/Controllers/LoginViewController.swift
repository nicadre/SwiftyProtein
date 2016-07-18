//
//  LoginViewController.swift
//  SwiftyProtein
//
//  Created by Nicolas CHEVALIER on 7/13/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var touchIDButton: UIButton!

	let context = LAContext()
	var error: NSError?

    override func viewDidLoad() {

		super.viewDidLoad()

        if context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) == false {
            touchIDButton.enabled = false
            touchIDButton.setImage(UIImage(named: "TouchID Disable"), forState: UIControlState.Normal)
            touchIDButton.sizeToFit()
        }

	}

    override func viewDidAppear(animated: Bool) {

		super.viewDidAppear(animated)

        if (touchIDButton.enabled == false) {
			let alert: UIAlertController
			if let error = error {
            	alert = UIAlertController(title: "Touch ID error", message: "Touch ID not available: \(error.localizedDescription)", preferredStyle: .Alert)
			} else {
				alert = UIAlertController(title: "Touch ID error", message: "Touch ID not available", preferredStyle: .Alert)
			}
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }

    @IBAction func touchIDButtonAction(sender: UIButton) {

		if context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
			context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Logging in with Touch ID", reply: { (success, error) in

				dispatch_async(dispatch_get_main_queue(), {

					if success {
						self.performSegueWithIdentifier("showList", sender: self)
					}

					if let error = error {
						var message: NSString

						switch(error.code) {
						case LAError.AuthenticationFailed.rawValue:
							message = "There was a problem verifying your identity."
							break
						case LAError.UserCancel.rawValue:
							message = "Logging in was canceled."
							break
						case LAError.UserFallback.rawValue:
							message = "This application require Touch ID logging."
							break
						default:
							message = "Touch ID may not be configured"
							break
						}

						let alertView = UIAlertController(title: "Error",
							message: message as String, preferredStyle:.Alert)
						let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
						alertView.addAction(okAction)
						self.presentViewController(alertView, animated: true, completion: nil)
					}

				})
			})
		}

    }

}
