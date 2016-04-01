//
//  ViewController.swift
//  SimpleAccelerometer-Swift
//
//  Created by Bronson Dupaix on 3/29/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit
import CoreMotion
import QuartzCore

class ViewController: UIViewController {
    
    
    var maxX : CGFloat = 320;
    var maxY : CGFloat = 320;
    let boxSize : CGFloat = 30.0
    let startPoint = CGPointMake(50, 50)
    var prevBox = UIView()
    
    var boxes = [UIView]()
    
    
    
    
    var animator:UIDynamicAnimator? = nil
    
    let gravity = UIGravityBehavior()
    
    let collider = UICollisionBehavior()
    
    
    
    let itemBehavior = UIDynamicItemBehavior()
    
    let imageView = UIView()
    
    // For getting device motion updates
    let motionQueue = NSOperationQueue.mainQueue()
    
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAnimatorStuff()
        generateBoxes()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        NSLog("Starting gravity")
        
        motionManager.startDeviceMotionUpdatesToQueue(motionQueue, withHandler:gravityUpdated)
    }
    
    override func viewDidDisappear(animated: Bool)  {
        super.viewDidDisappear(animated)
        NSLog("Stopping gravity")
        motionManager.stopDeviceMotionUpdates()
    }
    
    
    func randomColor() -> UIColor {
        
        let red : CGFloat = CGFloat(arc4random() % 256) / 256
        
        let green : CGFloat = CGFloat(arc4random() % 256) / 256
        
        let blue : CGFloat = CGFloat(arc4random() % 256) / 256
        
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1);
    }
    
    func doesNotCollide(testRect: CGRect) -> Bool {
        
        for box : UIView in boxes {
            
            let viewRect = box.frame
            
            
            if(CGRectIntersectsRect(testRect, viewRect)) {
                return false
            }
        }
        return true
    }
    
    func randomFrame() -> CGRect {
        
        var guess = CGRectMake(9, 9, 9, 9)
        
        repeat {
            
            let guessX = CGFloat(arc4random()) % maxX
            
            let guessY = CGFloat(arc4random()) % maxY
            
            guess = CGRectMake(guessX, guessY, boxSize, boxSize)
            
        } while(!doesNotCollide(guess))
        
        return guess
    }
    
    func addBox(location: CGRect, color: UIColor) -> UIView {
        
        let newBox = UIView(frame: location)
        
        newBox.backgroundColor = color
        
        view.addSubview(newBox)
        
        addBoxToBehaviors(newBox)
        
        boxes.append(newBox)
        
        let imageName = "waffle"
        
        let image = UIImage(named: imageName)
        
        let imageView = UIImageView(image: image!)
        
        imageView.frame.size = CGSize(width: 30, height: 30)
        
        newBox.addSubview(imageView)
        
        newBox.layer.masksToBounds = true
        
        newBox.layer.cornerRadius = 15
        
        return newBox
    }
    
    
    func generateBoxes() {
        for i in 0...50 {
            
            let frame = randomFrame()
            
            let color = randomColor()
            
            let newBox = addBox(frame, color: color)
            
        }
    }
    
    
    
    
    //----------------- UIDynamicAllocator
    
    
    
    func createAnimatorStuff() {
        
        
        animator = UIDynamicAnimator(referenceView:self.view);
        
        gravity.gravityDirection = CGVectorMake(0, 0.8)
        animator?.addBehavior(gravity);
        
        // We're bouncin' off the walls
        collider.translatesReferenceBoundsIntoBoundary = true
        
        animator?.addBehavior(collider)
        
        itemBehavior.friction = 0.2
        itemBehavior.elasticity = 0.8
    
        
        animator?.addBehavior(itemBehavior)
    }
    
    func addBoxToBehaviors(box: UIView) {
        gravity.addItem(box)
        collider.addItem(box)
        itemBehavior.addItem(box)
        itemBehavior.angularVelocityForItem(box)
    }
    
    //----------------- Core Motion
    
    func gravityUpdated(motion: CMDeviceMotion?, error: NSError?) {
        
        
        let grav : CMAcceleration = motion!.gravity;
        
        let x = CGFloat(grav.x)
        
        let y = CGFloat(grav.y)
        
        var p = CGPointMake(x,y)
        
        if (error != nil) {
            NSLog("\(error)")
        }
        
        // Have to correct for orientation.
        let orientation = UIApplication.sharedApplication().statusBarOrientation;
        
        if(orientation == UIInterfaceOrientation.LandscapeLeft) {
            let t = p.x
            p.x = 0 - p.y
            p.y = t
        } else if (orientation == UIInterfaceOrientation.LandscapeRight) {
            let t = p.x
            p.x = p.y
            p.y = 0 - t
        } else if (orientation == UIInterfaceOrientation.PortraitUpsideDown) {
            p.x *= -1
            p.y *= -1
        }
        
        let v = CGVectorMake(p.x, 0 - p.y);
        gravity.gravityDirection = v;
    }

}

