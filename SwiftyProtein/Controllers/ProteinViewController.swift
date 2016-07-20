//
//  ProteinViewController.swift
//  SwiftyProtein
//
//  Created by Nicolas Chevalier on 19/07/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import UIKit
import SceneKit

class ProteinViewController: UIViewController {

	var proteinName: String!
	var atomList: [Int : Atom]!
	var connectList: [Connect]!

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
//			if (result.node as? AtomNode) {
//				displayInfo()
//			}
		}
	}
}
