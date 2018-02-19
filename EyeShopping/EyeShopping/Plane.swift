//
//  Plane.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.02.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class Plane: SCNNode {
    var anchor: ARPlaneAnchor?
    var planeGeometry: SCNPlane?
    
    func initWithAnchor(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        var material = SCNMaterial()
        var image = UIImage(named: "tron_grid")
        
        material.diffuse.contents = image
        planeGeometry?.materials = [material]
        
        var planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(Float(-M_PI / 2.0), 1.0, 0.0, 0.0)

        setTextureScale()
        addChildNode(planeNode)
    }
    
    func updatePlane(anchor: ARPlaneAnchor) {
        planeGeometry?.width = CGFloat(anchor.extent.x)
        planeGeometry?.height = CGFloat(anchor.extent.z)
        
        position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        setTextureScale()
    }
    
    func setTextureScale() {
        var width = planeGeometry?.width
        var height = planeGeometry?.height
        
        var material = planeGeometry?.materials.first
        material?.diffuse.contentsTransform = SCNMatrix4MakeScale(Float(width!), Float(height!), 1);
        material?.diffuse.wrapS = SCNWrapMode.repeat
        material?.diffuse.wrapT = SCNWrapMode.repeat
    }
    
    
}
