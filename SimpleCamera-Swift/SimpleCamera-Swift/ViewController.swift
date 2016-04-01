//
//  ViewController.swift
//  SimpleCamera-Swift
//
//  Created by Bronson Dupaix on 3/29/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var selectedImage: UIImageView!
    
    
    let pickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func choosePicButton(sender: UIButton) {
        
        pickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            pickerController.allowsEditing = true
            pickerController.sourceType = .Camera
            
            
            
        }else {
            
            pickerController.allowsEditing = true
            
            pickerController.sourceType = .PhotoLibrary
        }
        
        self.presentViewController(pickerController, animated: true) {
            
            }
        
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        print("did Cancel")
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        print("Have info")
        
        
        self.selectedImage?.image = image
        
        self.pickerController.dismissViewControllerAnimated(true, completion: {
            
        })
    }
}

