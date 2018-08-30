//
//  ViewController.swift
//  SprayAR
//
//  Created by Ilia on 24/06/2018.
//  Copyright © 2018 Ilia Stukalov. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    //Main AR view
    @IBOutlet var sceneView: ARSCNView!
    
    //Label with instruction
    @IBOutlet var pressLabel: UILabel!

    //Menu which allow user to control settings
    @IBOutlet var settingsMenu: SettingsView!
    
    //We need to track if settings menu is open
    var settingsIsOpen:Bool = false
    
    //We need to know whne drawning should start and finish so we track touches begin and ended
    var touched:Bool = false
    
    //All paintings wich user made
    var paintings:[Paint] = []
    
    //Center of the screen
    var viewCenter: CGPoint {
        let viewBounds = view.bounds
        return CGPoint(x: viewBounds.width / 2.0, y: viewBounds.height / 2.0)
    }
    
    //Node represents center of the screen on the surface
    var centerPoint: CenterNode = CenterNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        settingsMenu.delegate = self
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Configure pressLabel
        self.pressLabel.layer.cornerRadius = 10.0
        self.pressLabel.alpha = 1.0
        //And ask user to look for wall
        self.pressLabel.text = "Looking for a surface"
        
        self.setupAR()
        //Hide navigation bar
        self.navigationController?.isNavigationBarHidden = true
        //When view is loaded settingsMenu must be hidden
        self.settingsMenu.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupAR(){
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        //Set planes detection
        configuration.planeDetection = [.horizontal, .vertical]
        
        // Run the view's session
        sceneView.session.run(configuration)
        
    }
    
    @IBAction func openSettings(_ sender: Any) {
        if settingsIsOpen == true{
            //We should close settings
            self.closeSettingsMenu()
        }else{
            //We should open settings
            self.openSettingsMenu()
        }
    }
    
    //Snap user drawning and then share it
    @IBAction func snap(_ sender: Any) {
        //Firstly we need to hide center node
        self.centerPoint.isHidden = true
        //Snapshot ar experince
        let img = self.sceneView.snapshot()
        //After snapshot center node must be shown again
        self.centerPoint.isHidden = false
        //Get main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //Get viewcontroller which will be used to share image
        let controller = storyboard.instantiateViewController(withIdentifier: "ShareVC") as! SnapViewController
        //Pass image
        controller.image = img
        //Go to previously created viewcintroller
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //Remove last added painting
    @IBAction func back(_ sender: Any) {
        if self.paintings.count < 1 { return }
        let p = self.paintings[self.paintings.count-1]
        p.removeFromParentNode()
        self.paintings.removeLast()
    }
    
    //Delete all
    @IBAction func trash(_ sender: Any) {
        if self.paintings.count < 1 { return }
        for p in self.paintings {
            p.removeFromParentNode()
        }
        self.paintings = []
        
    }
    
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
}
