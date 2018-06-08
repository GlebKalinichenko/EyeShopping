//
//  DirectViewController.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 08.06.2018.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Vision

class DirectViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    @IBOutlet weak var sceneView: ARSCNView!
    var planes: NSMutableDictionary?
    var detectedDataAnchor: ARAnchor?
    var movedObject: SCNNode?;
    var initialHitTestResult: ARHitTestResult?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToSceneView()
        addPanGestureToSceneView()
        addScaleGestureToSceneView()
    }
    
    func setupScene() {
        // Set the view's delegate
        sceneView.delegate = self
        
        // Set the session's delegate
        sceneView.session.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
    }
    @IBAction func menuClicked(_ sender: Any) {
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
        setupScene()
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
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DirectViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addPanGestureToSceneView() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DirectViewController.moveObject(withGestureRecognizer:)))
        panGestureRecognizer.maximumNumberOfTouches = 1
        panGestureRecognizer.minimumNumberOfTouches = 1
        self.sceneView.addGestureRecognizer(panGestureRecognizer);
    }
    
    func addScaleGestureToSceneView() {
        let tapGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(DirectViewController.scaleObject(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func moveObject(withGestureRecognizer recognizer: UIPanGestureRecognizer) {
        moveAndDragARObject(withGestureRecognizer: recognizer)
    }
    
    @objc func scaleObject(withGestureRecognizer recognizer: UIPinchGestureRecognizer) {
        scaleARObject(withGestureRecognizer: recognizer)
    }
    
    func scaleARObject(withGestureRecognizer recognizer: UIPinchGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizerState.began) {
            var tapPoint = recognizer.location(ofTouch: 1, in: sceneView)
            var result = sceneView.hitTest(tapPoint, options: nil)
            if (result.count == 0) {
                tapPoint = recognizer.location(ofTouch: 0, in: sceneView)
                result = sceneView.hitTest(tapPoint, options: nil)
                if (result.count == 0) {
                    return;
                }
            }
            
            var hitResult = result.first;
            
            guard let newHitResult = hitResult else {return}
            self.movedObject = newHitResult.node.parent
        }
        
        if (recognizer.state == UIGestureRecognizerState.changed) {
            guard let newMovedObject = movedObject else {return}
            
            var pinchScaleX = recognizer.scale * CGFloat(newMovedObject.scale.x);
            var pinchScaleY = recognizer.scale * CGFloat(newMovedObject.scale.y);
            var pinchScaleZ = recognizer.scale * CGFloat(newMovedObject.scale.z);
            movedObject?.scale = SCNVector3Make(Float(pinchScaleX), Float(pinchScaleY), Float(pinchScaleZ));
        
            recognizer.scale = 1;
        }
        if (recognizer.state == UIGestureRecognizerState.ended) {
            self.movedObject = nil;
        }
    }
    
    func moveAndDragARObject(withGestureRecognizer recognizer: UIPanGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizerState.began) {
            var tapPoint = recognizer.location(in: sceneView)
            var result = sceneView.hitTest(tapPoint, options: nil)
            var hitResults = sceneView.hitTest(tapPoint, types: ARHitTestResult.ResultType.featurePoint)
            
            if (result.count == 0) {
                return;
            }
            var hitResult = result.first
            self.movedObject = hitResult?.node.parent
            self.initialHitTestResult = hitResults.first
        }
        if (recognizer.state == UIGestureRecognizerState.changed) {
            if ((movedObject) != nil) {
                var tapPoint = recognizer.location(in: sceneView)
                var hitResults = sceneView.hitTest(tapPoint, types: ARHitTestResult.ResultType.featurePoint)
                var result = hitResults.last
                
                SCNTransaction.begin()
                
                guard let newInitialHitResult = self.initialHitTestResult else {return}
                
                var initialMatrix = SCNMatrix4(newInitialHitResult.worldTransform)
                var initialVector = SCNVector3Make(initialMatrix.m41, initialMatrix.m42, initialMatrix.m43);
                
                guard let newResult = result else {return}
                var matrix = SCNMatrix4(newResult.worldTransform);
                var vector = SCNVector3Make(matrix.m41, matrix.m42, matrix.m43);
                
                var dx = vector.x - initialVector.x;
                var dy = vector.y - initialVector.y;
                var dz = vector.z - initialVector.z;
                
                var newPositionVector = SCNVector3Make(self.movedObject!.position.x+dx, (self.movedObject?.position.y)!+dy,
                                                       self.movedObject!.position.z+dz);
                
                movedObject?.position = newPositionVector
                
                SCNTransaction.commit()
                
                self.initialHitTestResult = newResult;
            }
        }
        if (recognizer.state == UIGestureRecognizerState.ended) {
            self.movedObject = nil;
            self.initialHitTestResult = nil;
        }
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else {
            let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
            if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
                // Create an anchor. The node will be created in delegate methods
                self.detectedDataAnchor = ARAnchor(transform: hitTestResultWithFeaturePoints.worldTransform)
                self.sceneView.session.add(anchor: self.detectedDataAnchor!)
                
                //let translation = hitTestResultWithFeaturePoints.worldTransform.transpose
                //addBox(x: translation.x, y: translation.y, z: translation.z)
            }
            return
        }
        node.removeFromParentNode()
    }
    
    func addBox(x: Float = 0, y: Float = 0, z: Float = -0.2) {
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(x, y, z)
        
        sceneView.scene.rootNode.addChildNode(boxNode)
    }

}
