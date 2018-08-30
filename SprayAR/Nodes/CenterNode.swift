//
//  CenterNode.swift
//  SprayAR
//
//  Created by Ilia on 24/06/2018.
//  Copyright © 2018 Ilia Stukalov. All rights reserved.
//

import UIKit
import SceneKit

//Node which is represent center of the screen placed on a surface
class CenterNode: SCNNode {
    
    //Color of node, which corresponds with spray color
    var color: UIColor = UIColor.white {
        didSet{
            //Recreate frame of node
            self.childNodes[0].removeFromParentNode()
            self.addChildNode(generateFrame())
        }
    }
    
    //Radius of cilindric frame
    var radius: CGFloat = 0.01 {
        didSet{
            //Recreate frame of node
            self.childNodes[0].removeFromParentNode()
            self.addChildNode(generateFrame())
        }
    }
    
    override init() {
        super.init()
        self.addChildNode(generateFrame())
    }
    
    //We need to know if this node is placed on vertical surface or horizontal
    var vertical:Bool = false
    
    //Main function which is used to create or change node geometry and color
    func generateFrame() -> SCNNode{
        //Create representation of node which is tube with almost 0 heght
        let tube = SCNTube(innerRadius: radius-0.001, outerRadius: radius, height: 0.0001)
        //Generate material for this node
        let material = SCNMaterial()
        //Set material color based on selected color
        material.diffuse.contents = color
        //Set material to the tube
        tube.firstMaterial = material
        //Return created frame
        return SCNNode(geometry: tube)
    }
    
    //Change orientation of node to vertical
    func makeItVertical(){
        //Chande transfrom of the node to rotate it by 90 degrees
        self.transform = SCNMatrix4MakeRotation( Float.pi / 2, 1, 0, 0)
    }
    
    //Change orientation of node to horizontal
    func makeItHorizontal(){
        //Chande transfrom of the node to rotate it by 90 degrees
        self.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
