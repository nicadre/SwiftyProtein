//
//  Connect.swift
//  SwiftyProtein
//
//  Created by Nicolas Chevalier on 19/07/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import Foundation

class Connect {

	let origin: Int
	var destinations: [Int]

	init?(data: String) {

		let components: [String] = data.componentsSeparatedByString(" ").filter {$0 != ""}

		guard !components.isEmpty && components[0] == "CONECT" else {
			return nil
		}

		origin = Int(components[1])!

		destinations = []

		for i in 2..<components.count {
			destinations.append(Int(components[i])!)
		}
	}

}
