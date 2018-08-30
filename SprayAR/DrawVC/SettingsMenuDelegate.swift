//
//  SettingsMenuDelegate.swift
//  SprayAR
//
//  Created by Ilia on 29/06/2018.
//  Copyright © 2018 Ilia Stukalov. All rights reserved.
//

import UIKit

//Extension of ViewController which confroms to SettingsViewDelegate protocol
extension ViewController: SettingsViewDelegate {
    
    //Changes center node size
    func sizeChanged(newSize: Float) {
        self.centerPoint.radius = CGFloat(newSize)
    }
    
    //Changes center node color
    func colorSelected(newColor: UIColor) {
        self.centerPoint.color = newColor
        closeSettingsMenu()
    }
    
    //Used to close settings menu with animation
    func closeSettingsMenu(){
        //Block which is used to animate UIView
        UIView.animate(withDuration: 0.2, animations: {
            self.settingsMenu.alpha = 0.0
        }, completion: {
            complete in
            self.settingsIsOpen = false
            self.settingsMenu.isHidden = true
        })
    }
    
    //Used to open settings menu with animation
    func openSettingsMenu(){
        //Set slider value to curren size of center node
        settingsMenu.slider.setValue(Float(self.centerPoint.radius), animated: false)
        //Block which is used to animate UIView
        UIView.animate(withDuration: 0.2, animations: {
            self.settingsMenu.alpha = 1.0
        }, completion: {
            complete in
            self.settingsIsOpen = true
            self.settingsMenu.isHidden = false
        })
    }
    
}
