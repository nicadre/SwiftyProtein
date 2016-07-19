//
//  ProteinScene.swift
//  SwiftyProtein
//
//  Created by Nicolas Chevalier on 19/07/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import SceneKit

class ProteinScene: SCNScene {

	let atomsList: [Int : Atom]
	let connectsList: [Connect]

	private var middleSCNVector3 =  SCNVector3()

	init(atomsList: [Int : Atom], connectsList: [Connect]) {

		self.atomsList = atomsList
		self.connectsList = connectsList
		super.init()

		initCamera()


		print(atomsList.count)
		for (_, atom) in atomsList {
			createAtom(atom)
		}
		for connect in connectsList {
			let atomSource = atomsList[connect.origin]

			for destination in connect.destinations {

				let atomDestination = atomsList[destination]

				connectAtoms(atomSource!, atomDest: atomDestination!)

			}
		}

	}

	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func initCamera() {
		let node = SCNNode()
		node.camera = SCNCamera()
		self.rootNode.addChildNode(node)

		let middleView = middleVector()
		node.position = SCNVector3(x:  middleView.x, y: middleView.y, z: middleView.z + 25)
	}

	func middleVector() -> SCNVector3 {
		self.atomsList.forEach { (_, atom) in
			var middle = self.middleSCNVector3
			middle.x = (middle.x + atom.x)/2
			middle.y = (middle.y + atom.y)/2
			middle.z = (middle.z + atom.z)/2
			self.middleSCNVector3 = middle
		}
		return (self.middleSCNVector3)
	}

	func createAtom(atom: Atom) {
		let sphere = SCNSphere(radius: 0.5)
		let node = SCNNode(geometry: sphere)
		sphere.firstMaterial?.diffuse.contents = atom.color
		node.position = SCNVector3(x: atom.x, y: atom.y, z: atom.z)
		self.rootNode.addChildNode(node)
	}

	func connectAtoms(atomSource: Atom, atomDest: Atom) {

		let node = SCNNode()

		let source = SCNVector3(x: atomSource.x, y: atomSource.y, z: atomSource.z)
		let destination = SCNVector3(x: atomDest.x, y: atomDest.y, z: atomDest.z)
		let  height = source.distance(destination)

		node.position = source

		let nodeDestination = SCNNode()

		nodeDestination.position = destination
		self.rootNode.addChildNode(nodeDestination)

		let zAlign = SCNNode()
		zAlign.eulerAngles.x = Float(M_PI_2)

		let cyl = SCNCylinder(radius: 0.2, height: CGFloat(height))
		cyl.radialSegmentCount = 42
		cyl.firstMaterial?.diffuse.contents = UIColor.fromRGB(0xAAAAAA)

		let nodeCyl = SCNNode(geometry: cyl)
		nodeCyl.position.y = -height / 2
		zAlign.addChildNode(nodeCyl)
		node.addChildNode(zAlign)
		node.constraints = [SCNLookAtConstraint(target: nodeDestination)]

		self.rootNode.addChildNode(node)
	}

}
