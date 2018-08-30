//
//  SnapViewController.swift
//  SprayAR
//
//  Created by Ilia on 29/06/2018.
//  Copyright © 2018 Ilia Stukalov. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {

    //This view used to preview snap with user drawning
    @IBOutlet var imgView: UIImageView!
    
    //This is the main button(Big white)
    @IBOutlet var shareBtn: UIButton!
    
    //Image passed from ViewController.swift
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Set passed image to preview view
        self.imgView.image = image!
        //Change corner radius of main button
        self.shareBtn.layer.cornerRadius = 10.0
    }
    
    //Used to share image
    @IBAction func share(_ sender: Any) {
        //Create new instance of UIActivityViewController wich is used to share passed UIImage
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [self.image!], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        //Finally present activityViewController
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
