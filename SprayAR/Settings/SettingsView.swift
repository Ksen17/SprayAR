//
//  SettingsView.swift
//  SprayAR
//
//  Created by Ilia on 29/06/2018.
//  Copyright © 2018 Ilia Stukalov. All rights reserved.
//

import UIKit

//Protocol which tell delgate about changes in settings
protocol SettingsViewDelegate{
    //Tell delegate that size changed
    func sizeChanged(newSize:Float)
    //Tell delegate that color changed
    func colorSelected(newColor:UIColor)
}

class SettingsView: UIView {
    
    //Delegate which is being call when something changed
    var delegate:SettingsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeButtonsRounded(inView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.makeButtonsRounded(inView: self)
    }
    
    //Make rounded corners of all buttons in the passed view
    fileprivate func makeButtonsRounded(inView: UIView){
        //Go throw all subviews
        for v in inView.subviews {
            if v.subviews.count > 0 {
                //If subview contains other views call this function again
                makeButtonsRounded(inView: v)
            }else if v is UIButton {
                //If subview is a button make it's corners rounded
                v.layer.cornerRadius = 10
            }
        }
    }
    
    //Slider which show size of nodes
    @IBOutlet var slider: UISlider!
    
    //This fucntion got called when user select color
    @IBAction func selectColor(sender: UIButton){
        //Notify delegate that color changed
        self.delegate?.colorSelected(newColor: sender.backgroundColor!)
    }

    //This fucntion got called when user change size by moving slider
    @IBAction func sizeSelected(_ sender: UISlider) {
        //Notify delegate that size changed
        self.delegate?.sizeChanged(newSize: sender.value)
    }
}
