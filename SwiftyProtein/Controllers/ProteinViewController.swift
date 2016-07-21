//
//  ProteinViewController.swift
//  SwiftyProtein
//
//  Created by Nicolas Chevalier on 19/07/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import UIKit
import SceneKit
import SWXMLHash

class ProteinViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var infoAtomLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!

    var proteinName: String!
	var atomList: [Int : Atom]!
	var connectList: [Connect]!
    var xml: XMLIndexer?

    @IBAction func displayInfo(sender: UIButton) {
        
        if UIApplication.sharedApplication().networkActivityIndicatorVisible == false {
            
            APIRequester.sharedInstance.requestInfoLigand(self.proteinName) { response in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let status = response.response?.statusCode {
                        if case 200..<300 = status {
                            self.xml = SWXMLHash.parse(response.data!)
                            
                            self.performSegueWithIdentifier("popOverInfo", sender: self)
                        } else {
                            let alert = UIAlertController(title: "Load error", message: "Can't get ligand informations. Please retry later.", preferredStyle: .Alert)
                            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                            alert.addAction(action)
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                    }
                    else {
                        let alert = UIAlertController(title: "Load error", message: "Can't get ligand informations. Please retry later.", preferredStyle: .Alert)
                        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    
                }
            }
            
        }
        
    }

	@IBAction func shareAction(sender: UIButton) {

		let scnView = self.view as! SCNView

		let objects = ["This \(proteinName) is awesome!", scnView.snapshot()]
		let activityVC = UIActivityViewController(activityItems: objects, applicationActivities: nil)
		
		activityVC.popoverPresentationController?.sourceView = sender
		self.presentViewController(activityVC, animated: true, completion: nil)
	
	}

	override func viewDidLoad() {

		super.viewDidLoad()

		navigationItem.title = proteinName
		infoAtomLabel.text = ""

		let tap = UITapGestureRecognizer(target: self, action: #selector(ProteinViewController.onTap))

		let scnView = self.view as! SCNView

		scnView.addGestureRecognizer(tap)


	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

		let scnView = self.view as! SCNView

		scnView.scene = ProteinScene(atomsList: atomList, connectsList: connectList)

		scnView.backgroundColor = UIColor.fromRGB(0xeeeeee)
		scnView.autoenablesDefaultLighting = true
		scnView.allowsCameraControl = true
	}
    
	func onTap(gesture: UITapGestureRecognizer) {
		let scnView = self.view as! SCNView

		let p = gesture.locationInView(view)
		let atoms = scnView.hitTest(p, options: nil)

		if atoms.count > 0 {
			let result = atoms[0]
			if let atom = result.node as? AtomNode {
                self.infoAtomLabel.text = "Type: \(atom.atom.type) - Id: \(atom.atom.id)"
                self.infoAtomLabel.sizeToFit()
            } else {
                infoAtomLabel.text = ""
            }
        }  else {
            infoAtomLabel.text = ""
        }
	}
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popOverInfo" {
            if let popoverViewController = segue.destinationViewController as? PopOverViewController {
                popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
                popoverViewController.popoverPresentationController!.delegate = self
                
                popoverViewController.popoverPresentationController?.sourceRect = CGRectMake(infoButton.frame.width / 2, infoButton.frame.height + 2, 0, 0)
                
                let ligand = self.xml!["describeHet"]["ligandInfo"]["ligand"]
                
                if let chemicalID = ligand.element?.attributes["chemicalID"] {
                    popoverViewController.chemicalId = chemicalID
                }
                if let type = ligand.element?.attributes["type"] {
                    popoverViewController.type = type
                }
                if let weight = ligand.element?.attributes["molecularWeight"] {
                    popoverViewController.weight = weight
                }
                if let chemicalName = ligand["chemicalName"].element?.text {
                    popoverViewController.chemicalName = chemicalName
                }
                if let formula = ligand["formula"].element?.text {
                    popoverViewController.formula = formula
                }
                
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

}
