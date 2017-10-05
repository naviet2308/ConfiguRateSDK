//
//  CRProgressHUB.swift
//  ConfiguRate
//
//  Created by Viet Nguyen on 4/18/17.
//  Copyright © 2017 goappable. All rights reserved.
//

import UIKit

class CRProgressHUB: UIView{
    
    /// :nodoc:
    @IBOutlet var collectionOfViews: Array<UIImageView>!
    
    /// :nodoc:
    private var timer        : Timer!
    /// :nodoc:
    private var currentIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    
    /// Function to show CRProgressHUB the same as indicator
    ///
    /// - Parameter toView: destination view
    public func show(toView: UIView) {
        
        toView.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints                      = false
        //        self.topAnchor.constraint(equalTo: toView.topAnchor).isActive       = true
        //        self.leftAnchor.constraint(equalTo: toView.leftAnchor).isActive     = true
        //        self.rightAnchor.constraint(equalTo: toView.rightAnchor).isActive   = true
        //        self.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
        
        let views = ["toView" : toView, "view" : self]
        
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[view]-|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
        
        self.runAnimation()
    }
    
    
    /// Function to enable animation
    private func runAnimation(){
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.handleAnimation), userInfo: nil, repeats: true)
    }
    
    /// Function to disable animation
    public func stopAnimation(){
        self.removeFromSuperview()
        timer.invalidate()
        collectionOfViews.forEach { (image) in
            image.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    /// Function to handle animation
    internal func handleAnimation(){
        var scale: CGFloat = 1.5
        collectionOfViews[currentIndex].transform = CGAffineTransform(scaleX: scale, y: scale)
        let previous = currentIndex == 0 ? 4 : (currentIndex - 1)
        scale = 1
        collectionOfViews[previous].transform = CGAffineTransform(scaleX: scale, y: scale)
        currentIndex = currentIndex == 4 ? 0 : (currentIndex + 1)
    }
}
