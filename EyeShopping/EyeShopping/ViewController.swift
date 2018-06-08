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
import Vision

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    @IBOutlet var sceneView: ARSCNView!
    var planes: NSMutableDictionary?
    var detectedDataAnchor: ARAnchor?
    var processing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }
    
    func setupScene() {
        // Set the view's delegate
        sceneView.delegate = self
        
        // Set the session's delegate
        sceneView.session.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
    }
    
    func setupSession() {
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Set plane horizontal
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSession()
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
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        // If this is our anchor, create a node
        if self.detectedDataAnchor?.identifier == anchor.identifier {
            
            // Create a 3D Cup to display
            guard let virtualObjectScene = SCNScene(named: "cup.scn", inDirectory: "Models.scnassets/cup") else {
                return nil
            }
            
            let wrapperNode = SCNNode()
            
            for child in virtualObjectScene.rootNode.childNodes {
                child.geometry?.firstMaterial?.lightingModel = .physicallyBased
                child.movabilityHint = .movable
                wrapperNode.addChildNode(child)
            }
            
            // Set its position based off the anchor
            wrapperNode.transform = SCNMatrix4(anchor.transform)
            
            return wrapperNode
        }
        
        return nil
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        
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
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Only run one Vision request at a time
        if self.processing {
            return
        }
        
        self.processing = true
        
        // Create a Barcode Detection Request
        let request = VNDetectBarcodesRequest { (request, error) in
            
            // Get the first result out of the results, if there are any
            if let results = request.results, let result = results.first as? VNBarcodeObservation {
                var typeObject = result.payloadStringValue
                
                // Get the bounding box for the bar code and find the center
                var rect = result.boundingBox
                
                // Flip coordinates
                rect = rect.applying(CGAffineTransform(scaleX: 1, y: -1))
                rect = rect.applying(CGAffineTransform(translationX: 0, y: 1))
                
                // Get center
                let center = CGPoint(x: rect.midX, y: rect.midY)
                
                // Go back to the main thread
                DispatchQueue.main.async {
                    
                    // Perform a hit test on the ARFrame to find a surface
                    let hitTestResults = frame.hitTest(center, types: [.featurePoint/*, .estimatedHorizontalPlane, .existingPlane, .existingPlaneUsingExtent*/] )
                    
                    // If we have a result, process it
                    if let hitTestResult = hitTestResults.first {
                        
                        // If we already have an anchor, update the position of the attached node
                        if let detectedDataAnchor = self.detectedDataAnchor,
                            let node = self.sceneView.node(for: detectedDataAnchor) {
                            node.transform = SCNMatrix4(hitTestResult.worldTransform)
                            
                        } else {
                            // Create an anchor. The node will be created in delegate methods
                            self.detectedDataAnchor = ARAnchor(transform: hitTestResult.worldTransform)
                            self.sceneView.session.add(anchor: self.detectedDataAnchor!)
                        }
                    }
                    
                    // Set processing flag off
                    self.processing = false
                }
                
            } else {
                // Set processing flag off
                self.processing = false
            }
        }
        
        // Process the request in the background
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                // Set it to recognize QR code only
                request.symbologies = [.QR]
                
                // Create a request handler using the captured image from the ARFrame
                let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: frame.capturedImage,
                                                                options: [:])
                // Process the request
                try imageRequestHandler.perform([request])
            } catch {
                
            }
        }
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

