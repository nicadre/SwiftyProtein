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


	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

		let scnView = self.view as! SCNView

		scnView.scene = ProteinScene(atomsList: atomList, connectsList: connectList)

		scnView.backgroundColor = UIColor.fromRGB(0xeeeeee)
		scnView.autoenablesDefaultLighting = true
		scnView.allowsCameraControl = true
	}
}
