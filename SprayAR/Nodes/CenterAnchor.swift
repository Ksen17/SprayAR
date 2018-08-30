//
//  CenterAnchor.swift
//  SprayAR
//
//  Created by Ilia on 24/06/2018.
//  Copyright © 2018 Ilia Stukalov. All rights reserved.
//

import UIKit
import ARKit

//This anchor is used to track center node and paints
class CenterAnchor: ARAnchor {
    //We need type to check if this anchor represent point on vertical or horizontal surface
    var type: ARHitTestResult.ResultType = ARHitTestResult.ResultType.estimatedHorizontalPlane
    
    init(transform: matrix_float4x4, type: ARHitTestResult.ResultType) {
        super.init(transform: transform)
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
