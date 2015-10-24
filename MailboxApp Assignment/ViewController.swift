//
//  ViewController.swift
//  MailboxApp Assignment
//
//  Created by Ajay Gopalkrishna on 10/21/15.
//  Copyright © 2015 Ajay Gopalkrishna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var messageUIView: UIView!
    
    @IBOutlet weak var messageView: UIImageView!
    
    @IBOutlet weak var rescheduleImageView: UIImageView!
    
    @IBOutlet weak var mailBoxView: UIView!
    
    @IBOutlet weak var listImageView: UIImageView!
    
    
    @IBOutlet weak var laterImageView: UIImageView!
    
    @IBOutlet weak var listIcon: UIImageView!
    
    var initmessageUIViewLoc: CGPoint!
    var messageOffset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // The onCustomPan: method will be defined in Step 3 below.
       // let SEpanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "onCustomPan:")
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        //view.addGestureRecognizer(SEpanGestureRecognizer)
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        
        messageUIView.addGestureRecognizer(edgeGesture)
        
        let initMessagePosition = messageView.frame.origin
        
        initmessageUIViewLoc = messageUIView.center
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func onCustomPan(sender: UIPanGestureRecognizer) {
    
        // Absolute (x,y) coordinates in parent view
        let messageLocation = sender.locationInView(messageView)
        
        // Relative change in (x,y) coordinates from where gesture began.
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(messageLocation)")
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            messageUIView.center = CGPoint(x: messageUIView.center.x+translation.x, y: messageUIView.center.y)
            messageOffset = initmessageUIViewLoc.x-messageUIView.center.x
                if velocity.x < 0 {
                    
                    if (messageOffset > 60)  {
                    //taskView.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 0.5)
                    taskView.backgroundColor = UIColor.yellowColor()
                    //taskView.backgroundColor = UIColor(hue: 0.6, saturation: 0.5, brightness: 0.5, alpha: 0.6)
                        listIcon.alpha=0
                        laterImageView.alpha=1
                    
                    }
                    if (messageOffset > 260)  {
                        //taskView.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 0.5)
                        taskView.backgroundColor = UIColor.brownColor()
                        //taskView.backgroundColor = UIColor(hue: 0.6, saturation: 0.5, brightness: 0.5, alpha: 0.6)
                        listIcon.alpha=1
                        laterImageView.alpha=0
                        
                    }
                    
                }
            
                if velocity.x > 0 {
                
                    messageOffset = -1 * messageOffset
                
                    if (messageOffset > 60)  {
                        //taskView.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 0.5)
                        taskView.backgroundColor = UIColor.brownColor()
                        //taskView.backgroundColor = UIColor(hue: 0.6, saturation: 0.5, brightness: 0.5, alpha: 0.6)
                        listIcon.alpha=1
                        laterImageView.alpha=0
                    
                    }
                    if (messageOffset > 260)  {
                        //taskView.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 0.5)
                        taskView.backgroundColor = UIColor.yellowColor()
                        //taskView.backgroundColor = UIColor(hue: 0.6, saturation: 0.5, brightness: 0.5, alpha: 0.6)
                        listIcon.alpha=0
                        laterImageView.alpha=1
                    
                    }
                
            }
            
            print("Translation: \(translation.x)")
            print("messageOffset: \(initmessageUIViewLoc.x-messageUIView.center.x)")

        } else if sender.state == UIGestureRecognizerState.Ended {
                    if (messageOffset < 60) {
                            messageUIView.center = initmessageUIViewLoc
                    }
            print("MessageOffset when ended: \(messageOffset)")
                    if (messageOffset > 60) && (messageOffset < 260) {
                        if velocity.x < 0 {
                            rescheduleImageView.alpha = 1
                            mailBoxView.alpha=0
                            listImageView.alpha = 0
                        }
                        if velocity.x > 0 {
                            listImageView.alpha = 1
                            mailBoxView.alpha=0
                            rescheduleImageView.alpha = 0
                            
                        }
                        
                    }
                    if (messageOffset > 260) {
                        
                        if velocity.x < 0 {
                
                            listImageView.alpha = 1
                            mailBoxView.alpha=0
                            rescheduleImageView.alpha = 0
                        }
                        if velocity.x > 0 {
                            rescheduleImageView.alpha = 1
                            mailBoxView.alpha=0
                            listImageView.alpha = 0
                            
                        }
                
                    }
    
    
            print("Gesture ended at: \(messageLocation)")
        }
    
    
    }
    
    @IBAction func onTapRescheduleView(sender: UITapGestureRecognizer) {
         print("Reschedule View Tapped");
        mailBoxView.alpha = 1
        rescheduleImageView.alpha = 0

    }
    
    @IBAction func onTapListView(sender: UITapGestureRecognizer) {
        print("List View Tapped");
        mailBoxView.alpha = 1
        listImageView.alpha = 0
        messageUIView.center = initmessageUIViewLoc
    }
    
    

}

