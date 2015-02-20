//
//  ViewController.swift
//  Gestures
//
//  Created by Matthew Nielsen on 2/19/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var colors: [UIColor]!
    var currentColor: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colors = [
            UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 128 / 255.0, alpha: 1),
            UIColor(red: 255 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1),
            UIColor(red: 0 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1),
            UIColor(red: 51 / 255.0, green: 51 / 255.0, blue: 51 / 255.0, alpha: 1),
            UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1),
            UIColor(red: 0 / 255.0, green: 128 / 255.0, blue: 64 / 255.0, alpha: 1)
        ]
        
        currentColor = 0
    }
    
    func incrementCurrentColor() {
        currentColor! = (currentColor! + 1) % (colors.count - 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func longPress(recognizer: UILongPressGestureRecognizer) {
        println("Long Press Gesture")
        
        if recognizer.state == .Ended {
            recognizer.view!.transform = CGAffineTransformRotate(recognizer.view!.transform, 1)
        }
    }
    
    @IBAction func tap(recognizer: UITapGestureRecognizer) {
        println("Tap Gesture")
        
        incrementCurrentColor()
        recognizer.view!.backgroundColor = colors[currentColor!]
    }
    
    @IBAction func pinch(recognizer: UIPinchGestureRecognizer) {
        println("Pinch Gesture")
        
        recognizer.view!.transform = CGAffineTransformScale(recognizer.view!.transform, recognizer.scale, recognizer.scale)
        recognizer.scale = 1
    }
    
    @IBAction func rotate(recognizer: UIRotationGestureRecognizer) {
        println("Rotate Gesture")
        
        recognizer.view!.transform = CGAffineTransformRotate(recognizer.view!.transform, recognizer.rotation)
        recognizer.rotation = 0
    }
    
    @IBAction func pan(recognizer: UIPanGestureRecognizer) {
        println("Pan (Drag) Gesture")
        
        let translation = recognizer.translationInView(self.view)
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
    
}

