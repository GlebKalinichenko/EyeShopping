//
//  ViewController.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 12.02.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    var planes: NSMutableDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }
    
    func setupScene() {
        // Set the view's delegate
        sceneView.delegate = self
        
        // A dictionary of all the current planes being rendered in the scene
        planes = NSMutableDictionary()
        
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints] 
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    func setupSession() {
        var config = ARWorldTrackingConfiguration()
        config.planeDetection = ARWorldTrackingConfiguration.PlaneDetection.horizontal
        sceneView.session.run(config)
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSession()
        // Create a session configuration
        //let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        //sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    /**
     Called when a new node has been mapped to the given anchor.
     
     @param renderer The renderer that will render the scene.
     @param node The node that maps to the anchor.
     @param anchor The added anchor.
     */
    /*- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
    return;
    }
    
    // When a new plane is detected we create a new SceneKit plane to visualize it in 3D
    Plane *plane = [[Plane alloc] initWithAnchor: (ARPlaneAnchor *)anchor];
    [self.planes setObject:plane forKey:anchor.identifier];
    [node addChildNode:plane];
    }*/
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        /*if let arPlaneAnchor = anchor as? [ARPlaneAnchor] {
            var plane = Plane()
            plane.initWithAnchor(anchor: anchor as! ARPlaneAnchor)
            planes?.setObject(plane, forKey: anchor.identifier as NSCopying)
            node.addChildNode(plane)
        }*/
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        /*if let plane: Plane = planes?.object(forKey: anchor.identifier) as! Plane {
            plane.updatePlane(anchor: anchor as! ARPlaneAnchor)
        }*/
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        planes?.removeObject(forKey: anchor.identifier)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
