//
//  ViewController.swift
//  AnimateApp-Swift
//
//  Created by Bronson Dupaix on 3/28/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var centerXConstraint: NSLayoutConstraint!
    
    var isAnimating: Bool = false
    
    var newView = UIView()
    
    
    //MARK: - View LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View did load")
        
        
        let viewRect = self.view.frame
        
        let rect = CGRect(x: 0, y: 0,  width: viewRect.size.width , height: viewRect.size.height)
        
        self.newView = UIView(frame: rect)
        
        newView.backgroundColor = UIColor.blueColor()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("View did appear")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View will appear")
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("view will dissapear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("view did dissapear")
    }

    @IBAction func buttonTapped(sender: UIButton) {
        
        
        if self.isAnimating == false {
        
        button.layer.masksToBounds = true
        
        button.layer.cornerRadius = 100 
        
        animateButton()
        
        button.backgroundColor = UIColor.greenColor()
        
        
       // print(viewRect)
        
        hideRedView()
        
        
        print("Button tapped") 
        
        }
        
    }
    
    func animateButton() {
        
        print("Button animated")
        
        UIView.animateWithDuration(2, delay: 0, options: [], animations: {
            
            self.button.alpha = 0
            
            
        }) { (animated) in
        
            UIView.animateWithDuration(2, animations: {
                
                self.button.alpha = 1
            })
        
        
        }
        
    }
    
    
   func hideRedView() {
    
    self.isAnimating = true
    
    
    self.view.addSubview(newView)

    UIView.animateWithDuration(3, animations: {
        
        
        let redFrame = self.view.frame
        
        print(redFrame.size)
        
        self.newView.frame = CGRect(x: 0 , y: 0 , width: 100 , height: redFrame.height)
        
    })
        
        self.isAnimating = false
    
    }

}

