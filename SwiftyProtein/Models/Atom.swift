//
//  Atom.swift
//  SwiftyProtein
//
//  Created by Nicolas Chevalier on 19/07/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import UIKit

class Atom {

	let id: Int
	let type: String
	let x: Float
	let y: Float
	let z: Float
	let color: UIColor


	init?(atom: String) {

		let components: [String] = atom.componentsSeparatedByString(" ").filter {$0 != ""}

		guard !components.isEmpty && components[0] == "ATOM" else {
			return nil
		}

		id = Int(components[1])!
		type = components[11]
		x = Float(components[6])!
		y = Float(components[7])!
		z = Float(components[8])!
		color = Atom.getAtomCPKColor(self.type)

	}

	static func getAtomCPKColor(type: String) -> UIColor {
		switch type {
		case "H":
			return (UIColor.whiteColor())
		case "C":
			return (UIColor.blackColor())
		case "N":
			return (UIColor.blueColor())
		case "O":
			return (UIColor.redColor())
		case "F", "Cl", "CL":
			return (UIColor.greenColor())
		case "Br", "BR":
			return (UIColor.fromRGB(0x992200))
		case "I":
			return (UIColor.fromRGB(0x6600bb))
		case "He", "Ne", "Ar", "Xe", "Kr", "HE", "NE", "AR", "XE", "KR":
			return (UIColor.fromRGB(0x00ffff))
		case "P":
			return (UIColor.fromRGB(0xff9900))
		case "S":
			return (UIColor.fromRGB(0xdddd00))
		case "B":
			return (UIColor.fromRGB(0xffaa77))
		case "Li", "Na", "K", "Rb", "Cs", "Fr", "LI", "NA", "K", "RB", "CS", "FR":
			return (UIColor.fromRGB(0x7700ff))
		case "Be", "Mg", "Ca", "Sr", "Ba", "Ra", "BE", "MG", "CA", "SR", "BA", "RA":
			return (UIColor.fromRGB(0x007700))
		case "Ti", "TI":
			return (UIColor.fromRGB(0x999999))
		case "Fe", "FE":
			return (UIColor.fromRGB(0xdd7700))
		default:
			return (UIColor.fromRGB(0xdd77ff))
		}
	}

}
