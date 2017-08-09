//
//  ViewController.swift
//  Tesseract Demo
//
//  Created by Hanet on 8/7/17.
//  Copyright © 2017 Mary Alexis Solis. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController {

    fileprivate var tesseract: G8Tesseract?
    @IBOutlet weak var recognizedTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tesseract = G8Tesseract(language:"eng")
        tesseract?.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takeAPhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .rear
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadFromGalleryTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self
        imagePicker.allowsEditing  = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}

extension ViewController: G8TesseractDelegate {
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        
    }
    
    func shouldCancelImageRecognition(for tesseract: G8Tesseract!) -> Bool {
        return false
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        tesseract?.image = UIImage.init(data: UIImageJPEGRepresentation(image, 1.0)!)
        tesseract?.recognize()
        
        print("Teseeract recognized text \(String(describing: tesseract?.recognizedText))")
        recognizedTextView.text = tesseract?.recognizedText
        picker.dismiss(animated: true, completion: nil)
    }
}
