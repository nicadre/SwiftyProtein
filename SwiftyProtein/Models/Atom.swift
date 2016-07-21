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
    lazy var radius: CGFloat = {
    
        switch self.type {
        case "H":
            return (1.20)
        case "C":
            return (1.70)
        case "N":
            return (1.55)
        case "O":
            return (1.52)
        case "F":
            return (1.47)
        case "Cl", "CL":
            return (1.75)
        case "Br", "BR":
            return (1.85)
        case "I":
            return (1.98)
        case "He", "HE":
            return (1.40)
        case "Ne", "NE":
            return (1.54)
        case "Ar", "AR":
            return (1.88)
        case "Xe", "XE":
            return (2.16)
        case  "Kr", "KR":
            return (2.02)
        case "P":
            return (1.80)
        case "S":
            return (1.80)
        case "Li", "LI":
            return (1.82)
        case "Na", "NA":
            return (2.10)
        case "K", "K":
            return (2.75)
        case "Mg", "MG":
            return (1.73)
        default:
            return (1.00)
        }
    }()


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
