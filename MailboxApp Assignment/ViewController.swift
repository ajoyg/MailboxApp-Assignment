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
    
    
    @IBOutlet weak var inboxScrollView: UIScrollView!
    
    @IBOutlet weak var laterImageView: UIImageView!
    
    @IBOutlet weak var listIcon: UIImageView!
    
    @IBOutlet weak var archiveIcon: UIImageView!
    
    @IBOutlet weak var deleteIcon: UIImageView!
    
    @IBOutlet weak var actionView: UIView!
    
    @IBOutlet weak var menuImageView: UIImageView!
    
    var initmessageUIViewLoc: CGPoint!
    var initinboxUIViewLoc: CGPoint!
    var inboxOffset: CGFloat!
    var messageOffset: CGFloat!
    var OrigBackgroundColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // The onCustomPan: method will be defined in Step 3 below.
       // let SEpanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "onCustomPan:")
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        //view.addGestureRecognizer(SEpanGestureRecognizer)
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        
        mailBoxView.addGestureRecognizer(edgeGesture)
        
        let initMessagePosition = messageView.frame.origin
        
        initmessageUIViewLoc = messageUIView.center
        initinboxUIViewLoc = mailBoxView.center
        OrigBackgroundColor = taskView.backgroundColor
        inboxScrollView.contentSize = CGSize.init(width: 320, height: 1006)
        
        
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
        if (messageUIView.frame.origin.x == 0.0 && messageUIView.frame.origin.y == 0.0) {
            messageOffset = 0
        }
        
        if sender.state == UIGestureRecognizerState.Began {
            //print("Gesture began at: \(messageLocation)")
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            
                messageUIView.center = CGPoint(x: messageUIView.center.x+translation.x, y: messageUIView.center.y)
            
                messageOffset = initmessageUIViewLoc.x-messageUIView.center.x
//print("messageOffset: \(messageOffset)")
  //          print("Velocity: \(velocity.x)")
            
            // Move Left
                if (velocity.x < 0 && messageOffset > 0) {
                    taskView.alpha = 1
                    actionView.alpha = 0
                    if (messageOffset < 60) {
                        taskView.backgroundColor = OrigBackgroundColor
                    }
                    
                    if (messageOffset > 60)  {
                    //taskView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0, alpha: 0.8)
                        taskView.backgroundColor = UIColor(hue: 0.6, saturation: 0.8, brightness: 0.5, alpha: 0.8)
                    taskView.backgroundColor = UIColor.yellowColor()
                    
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
            
            // Move right
                if (velocity.x > 0 && messageOffset < 0) {
                    actionView.alpha = 1
                    taskView.alpha = 0
                    if (messageOffset > -60) {
                        //actionView.backgroundColor = OrigBackgroundColor
                        listIcon.alpha = 0
                    }
                    if (messageOffset < -60)  {
                        actionView.backgroundColor = UIColor(red: 0, green: 0.3, blue: 0, alpha: 1)
                        
                        //taskView.backgroundColor = UIColor(hue: 0.6, saturation: 0.5, brightness: 0.5, alpha: 0.6)
                        archiveIcon.alpha=1
                        deleteIcon.alpha=0
                    
                    }
                    if (messageOffset < -260)  {
                        actionView.backgroundColor = UIColor(red: 0.3, green: 0, blue: 0, alpha: 1)
                       
                        //taskView.backgroundColor = UIColor(hue: 0.6, saturation: 0.5, brightness: 0.5, alpha: 0.6)
                        archiveIcon.alpha=0
                        deleteIcon.alpha=1
                    
                    }
                //    print("Frame Width : \(messageUIView.frame.width)")
                //    print("Frame Origin Diff : \(messageUIView.frame.width - messageUIView.frame.origin.x)")

                    if (messageUIView.frame.width - messageUIView.frame.origin.x < 36.0) {
                        messageUIView.frame.origin = CGPoint(x: messageUIView.frame.width - 35, y: messageUIView.frame.origin.y)
                    }
                }
            // Move left after a right move
            if (velocity.x < 0 && messageOffset < 0) {
                if (messageOffset > -260 && messageOffset < -60){
                    actionView.backgroundColor = UIColor(red: 0, green: 0.3, blue: 0, alpha: 1)
                    archiveIcon.alpha=1
                    deleteIcon.alpha=0
 
                }
                
                if (messageOffset > -60) {
                    archiveIcon.alpha = 0
                    actionView.backgroundColor = OrigBackgroundColor
                }
                if (messageOffset > -36) {
                    messageUIView.frame.origin = CGPoint(x: 0.0, y: 0.0)
                }
                
            }
            

        } else if sender.state == UIGestureRecognizerState.Ended {
        //    print("MessageOffset when ended: \(messageOffset)")
        //    print("Velocity when ended : \(velocity.x)")
            
            // Move left ended
            if (velocity.x < 0 && messageOffset > 0) {
                   if (messageOffset < 60) {
                            messageUIView.center = initmessageUIViewLoc
                    }
            
                    if (messageOffset > 60) && (messageOffset < 260) {
                        if (velocity.x < 0) {
                            rescheduleImageView.alpha = 1
                            mailBoxView.alpha=0
                            listImageView.alpha = 0
                        }
                        
                    }
                    if (messageOffset > 260) {
               
                            listImageView.alpha = 1
                            mailBoxView.alpha=0
                            rescheduleImageView.alpha = 0
                       
                    }
    
    
         //   print("Gesture ended at: \(messageLocation)")
            }
            // Move right ended
            if (velocity.x > 0 && messageOffset < 0) {
                if (messageOffset > -60) {
                    messageUIView.center = initmessageUIViewLoc
                }
                if (messageOffset < -60 && messageOffset > -260) {
                    actionView.alpha = 1
                    archiveIcon.alpha = 1
                    
                }
                if (messageOffset < -260) {
                    actionView.alpha = 1
                    archiveIcon.alpha = 0
                    deleteIcon.alpha = 1
                
                }
                
            }
           // Move left ended after a right move
            if (velocity.x < 0 && messageOffset < 0) {
                if (messageOffset > -36) {
                    messageUIView.center = initmessageUIViewLoc
                }
            }
            
            
        }
    
    }
    
    
        
    
    @IBAction func onTapListView(sender: UITapGestureRecognizer) {
        print("List View Tapped");
        mailBoxView.alpha = 1
        listImageView.alpha = 0
        rescheduleImageView.alpha = 0
        messageUIView.center = initmessageUIViewLoc
        messageOffset = 0
        menuImageView.alpha = 0
        
    }
    
    func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
       
        
        // Relative change in (x,y) coordinates from where gesture began.
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            //print("Gesture began at: \(messageLocation)")
            menuImageView.alpha = 1
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            inboxOffset = initinboxUIViewLoc.x - mailBoxView.center.x
        
            mailBoxView.center = CGPoint(x: mailBoxView.center.x+translation.x, y: mailBoxView.center.y)
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            mailBoxView.alpha = 0
            listImageView.alpha = 0
            rescheduleImageView.alpha = 0
            mailBoxView.center = initinboxUIViewLoc
            //menuImageView.alpha = 1

        
        }
        
        
        
        
    }
    
    

}

