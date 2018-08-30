//
//  ARDelegate.swift
//  SprayAR
//
//  Created by Ilia on 24/06/2018.
//  Copyright © 2018 Ilia Stukalov. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

//Extension of ViewController which response to ARSCNViewDelegate protocol
extension ViewController: ARSCNViewDelegate {
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        let alert = UIAlertController(title: "We can't launch your AR experience", message: "Please check your camera and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            //Lets try again
            self.setupAR()
        }))
        self.present(alert, animated: false, completion: nil)
    }
    
    func renderer(_ renderer: SCNSceneRenderer,
                  didAdd node: SCNNode,
                  for anchor: ARAnchor) {
        DispatchQueue.main.async {
            if let anchor = anchor as? CenterAnchor {
                // Get position from anchor
                let position = self.getPosition(anchor: anchor)
                
                //Change center node position and rotation based on anchor
                self.centerPoint.position = position
                self.centerPoint.rotation = node.rotation
                //Rotate center node based on it's current rotation and anchor
                if anchor.type == ARHitTestResult.ResultType.estimatedVerticalPlane{
                    if self.centerPoint.vertical == false{
                        self.centerPoint.vertical = true
                        self.centerPoint.makeItVertical()
                    }
                }else if anchor.type == ARHitTestResult.ResultType.estimatedHorizontalPlane{
                    if self.centerPoint.vertical == true{
                        self.centerPoint.vertical = false
                        self.centerPoint.makeItHorizontal()
                    }
                }
                //Update PressLabel with new hints
                if self.centerPoint.parent != self.sceneView.scene.rootNode {
                    self.pressLabel.text = "Press screen to draw"
                    UIView.animate(withDuration: 0.2, animations: {
                        self.pressLabel.alpha = 1.0
                    })
                    self.sceneView.scene.rootNode.addChildNode(self.centerPoint)
                }
                //If user hold finger on screen we need to add paint
                if self.touched == true && self.centerPoint.parent == self.sceneView.scene.rootNode{
                    self.placePaint(anchor: anchor)
                }
            }
        }
    }
    
    internal func renderer(_ renderer: SCNSceneRenderer,
                           updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            //Get place in ar which correspond with center of the screen
            let hitTestResults = self.sceneView.hitTest(self.viewCenter, types: [.estimatedHorizontalPlane, .estimatedVerticalPlane] )
            guard let hitTestResult = hitTestResults.first else { return }
            //Create CenterAnchor using previously generated hitTestResult
            let anchor = CenterAnchor(transform: hitTestResult.worldTransform, type: hitTestResult.type)
            //Add this anchor to scene
            self.sceneView.session.add(anchor: anchor)
        }
    }
    
    //Change center node position according to center of the screen
    fileprivate func moveCenterNode(newPosition: SCNVector3){
        self.centerPoint.position = newPosition
    }
    
    //Helper which is used to get node position from the given anchor
    fileprivate func getPosition(anchor:CenterAnchor) -> SCNVector3 {
        return SCNVector3(anchor.transform.columns.3.x , anchor.transform.columns.3.y, anchor.transform.columns.3.z)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Now user start drawning
        self.touched = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Now user finish drawning
        self.touched = false
    }
    
    
    //Function used to draw by anchor
    func placePaint(anchor: CenterAnchor) {
        //We need to hide label with hints
        if pressLabel.alpha > 0.0 {
            UIView.animate(withDuration: 0.2, animations: {
                self.pressLabel.alpha = 0.0
            })
        }
        //Create paint
        let p = Paint(radius: self.centerPoint.radius, color: self.centerPoint.color)
        p.position = self.getPosition(anchor: anchor)
        p.transform = self.centerPoint.transform
        //Rotate paint according to center node rotation
        p.rotation = self.centerPoint.rotation
        //Add paint to scene
        self.sceneView.scene.rootNode.addChildNode(p)
        //Append paint to all other paintings
        self.paintings.append(p)
    }

}
