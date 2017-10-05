//
//  ConfiguRateButton.swift
//  ConfiguRateSDK
//
//  Created by Viet Anh on 4/20/17.
//  Copyright © 2017 goappable. All rights reserved.
//

import UIKit

/// :nodoc:
let frameworkBundle = Bundle(for: ConfiguRateButton.self)

/// This class to initialize & handle button ConfiguRate
public class ConfiguRateButton: UIButton{
    
    /// :nodoc:
    private weak var target: UIViewController?
    /// :nodoc:
    private var virtualId = ""
    /// :nodoc:
    private var udid      = ""
    
    /// :nodoc:
    //    private let socket = SocketIOClient(socketURL: URL(string: "https://dev-api.configurateapp.com")!)
    /// :nodoc:
    //private let socket = SocketIOClient(socketURL: URL(string: "https://api-beta.configurateapp.com")!)
    private let socket = SocketIOClient(socketURL: URL(string: "https://api-store.configurateapp.com")!)
    /// :nodoc:
    //    private let socket = SocketIOClient(socketURL: URL(string: "https://api-integris.configurateapp.com")!)
    
    /// Returns an object initialized from data in a given unarchiver.
    /// You typically return self from init(coder:). If you have an advanced need that requires substituting a different object after decoding, you can do so in awakeAfter(using:).
    ///
    /// - Parameters aDecoder: aDecoder
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Function to init ConfiguRateButton
    ///
    /// - Parameters:
    ///   - target: pass a view controller that you want to show up there
    ///   - virtualId: pass your virtual device id
    required public init(target: UIViewController, virtualId: String, udid: String) {
        super.init(frame: .zero)
        self.target    = target
        self.virtualId = virtualId
        self.udid      = udid
        self.setup()
    }
    
    
    /// Function to setup layout, properties, background image, ... for ConfiguRateButton
    private func setup() {
        self.isHidden        = true
        let backgroundImage  = UIImage(named: "ic_button_normal.png", in: frameworkBundle, compatibleWith: nil)
        self.contentMode     = .scaleAspectFit
        self.setImage(backgroundImage, for: .normal)
        
        setupSocket()
        
        if let sourceVC = self.target{
            self.target?.view.addSubview(self)
            
            self.translatesAutoresizingMaskIntoConstraints                                   = false
            self.bottomAnchor.constraint(equalTo: sourceVC.view.bottomAnchor, constant: -20).isActive = true
            self.trailingAnchor.constraint(equalTo: sourceVC.view.trailingAnchor, constant: -20).isActive              = true
            self.widthAnchor.constraint(equalToConstant: 60).isActive                        = true
            self.heightAnchor.constraint(equalToConstant: 60).isActive                       = true
        }
        
        self.addTarget(self, action: #selector(clickedAction), for: .touchUpInside)
        
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(panButton))
        self.addGestureRecognizer(panRecognizer)
    }
    
    /// :nodoc:
    /// Function to setup & handle socket with server
    private func setupSocket(){
        
        self.socket.on("connected") { (data, ack) in
            
            print("---connected---")
            print(data)
            print("---connected---")
            
            self.socket.emit("registUDID", self.udid)
            
            self.socket.emit("hasSurvey", self.udid)
            
            self.socket.on("appNotificationMessage", callback: { (data, ack) in
                
                print("---appNotificationMessage---")
                print(data)
                print("---appNotificationMessage---")
                
                guard let content   = data.first as? [String : AnyObject] else { return }
                //guard let code      = content["code"] as? Int else { return }
                guard let message   = content["message"] as? [String : AnyObject] else { return }
                guard let hasSurvey = message["hasSurvey"] as? Bool else { return }
                //guard code == 1118 else { return }
                
                DispatchQueue.main.async {
                    self.isHidden = !hasSurvey
                    self.socket.off("appNotificationMessage")
                }
            })
            
            self.socket.on("virtualNotificationMessage") { (data, ack) in
                
                print("---virtualNotificationMessage---")
                print(data)
                print("---virtualNotificationMessage---")
                
                guard let content = data.first as? [String : AnyObject] else { return }
                guard let message = content["message"] as? [String : AnyObject] else { return }
                guard let action  = message["action"] as? String else { return }
                
                DispatchQueue.main.async {
                    self.isHidden = action != "loadsurvey"
                    let backgroundImage  = UIImage(named: "ic_button_survey.png", in: frameworkBundle, compatibleWith: nil)
                    self.setImage(backgroundImage, for: .normal)
                }
            }
        }
        
        socket.connect()
    }
    
    
    /// Function to handle event user clicked ConfiguRateButton
    ///
    /// - Parameter sender: instance of ConfiguRateButton (self)
    @objc private func clickedAction(sender: UIButton) {
        let backgroundImage  = UIImage(named: "ic_button_normal.png", in: frameworkBundle, compatibleWith: nil)
        self.setImage(backgroundImage, for: .normal)
        let destination       = SurveyViewController()
        destination.virtualId = virtualId
        self.target?.present(destination, animated: true, completion: nil)
    }
    
    
    /// Function to handle event user drag ConfiguRateButton
    ///
    /// - Parameter sender: instance of ConfiguRateButton (self)
    func panButton(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: target?.view)
        
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: target?.view)
    }
}
