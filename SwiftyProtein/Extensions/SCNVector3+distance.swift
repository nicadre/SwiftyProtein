//
//  SCNVector3+distance.swift
//  SwiftyProtein
//
//  Created by Nicolas Chevalier on 19/07/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import SceneKit

extension SCNVector3 {

	func distance(receiver:SCNVector3) -> Float{
		let xd = receiver.x - self.x
		let yd = receiver.y - self.y
		let zd = receiver.z - self.z
		let distance = Float(sqrt(xd * xd + yd * yd + zd * zd))

		if (distance < 0){
			return (distance * -1)
		} else {
			return (distance)
		}
	}
}