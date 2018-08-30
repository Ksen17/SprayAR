//
//  Paint.swift
//  SprayAR
//
//  Created by Ilia on 29/06/2018.
//  Copyright © 2018 Ilia Stukalov. All rights reserved.
//

import UIKit
import SceneKit

//Paintings which are placed by user
class Paint: CenterNode {
    
    init(radius: CGFloat, color: UIColor){
        super.init()
        self.radius = radius
        self.color = color
        self.addChildNode(generateFrame())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateFrame() -> SCNNode {
        //Create representation of node which is cylinder with almost 0 heght
        let cylinder = SCNCylinder(radius: self.radius, height: 0.0001)
        //Generate material for this node
        let material = SCNMaterial()
        //Set material color based on selected color
        material.diffuse.contents = color
        //Set material to the cylinder
        cylinder.firstMaterial = material
        //Return created frame
        return SCNNode(geometry: cylinder)
    }
    
}
