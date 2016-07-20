//
//  AtomNode.swift
//  SwiftyProtein
//
//  Created by Leo LAPILLONNE on 7/20/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import SceneKit

class AtomNode: SCNNode {
    
    let atom: Atom
    
    init(atom: Atom, geometry: SCNGeometry?) {
        self.atom = atom
        super.init()
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}