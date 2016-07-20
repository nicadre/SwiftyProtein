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
        performSegueWithIdentifier("popOverInfo", sender: self)
    }

	override func viewDidLoad() {

		super.viewDidLoad()

		navigationItem.title = proteinName

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
            let popoverViewController = segue.destinationViewController 
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            
            popoverViewController.popoverPresentationController?.sourceRect = CGRectMake(infoButton.frame.width / 2, infoButton.frame.height + 2, 0, 0)
            
            if UIApplication.sharedApplication().networkActivityIndicatorVisible == false {
                
                APIRequester.sharedInstance.requestInfoLigand(self.proteinName) { response in
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.xml = SWXMLHash.parse(response.data!)
                        
                        print(self.xml!["describeHet"]["ligandInfo"]["ligand"]["formula"].element?.text)
                    }
                }
                
            }

        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

}
