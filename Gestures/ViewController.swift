//
//  ViewController.swift
//  Gestures
//
//  Created by Matthew Nielsen on 2/19/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

// This tutorial was very helpful: http://www.raywenderlich.com/76020/using-uigesturerecognizer-with-swift-tutorial
// NOTE: swipe gesture not possible in combination with pan gesture
// NOTE: placing constraints on the rectangle while panning could get it stuck if the user resizes it

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func incrementCurrentColor() {
        currentColor! = (currentColor! + 1) % (colors.count - 1)
    }
    
    func rectangleOnScreen(rectangle: UIView) -> Bool {
        var screenWidth = UIScreen.mainScreen().bounds.size.width
        var screenHeight = UIScreen.mainScreen().bounds.size.height
        
        if rectangle.frame.maxX > screenWidth || rectangle.frame.maxY > screenHeight || rectangle.frame.minX < 0 || rectangle.frame.minY < 0 {
            return false
        } else {
            return true
        }
    }
    
    @IBAction func longPress(recognizer: UILongPressGestureRecognizer) {
        println("Long Press Gesture")
        
        if recognizer.state == .Ended {
            recognizer.view!.transform = CGAffineTransformRotate(recognizer.view!.transform, CGFloat(M_PI / 2))
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
        
        // get the center point of the rectangle before moving it
        let oldCenter = recognizer.view!.center
        
        // move the rectangle
        let translation = recognizer.translationInView(self.view)
        recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        
        // don't make the translation if the new center puts it outside of the screen
        if !rectangleOnScreen(recognizer.view!) {
            recognizer.view!.center = oldCenter
        }
        
        // set the translation
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
    
}
