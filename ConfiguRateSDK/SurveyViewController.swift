//
//  SurveyViewController.swift
//  ConfiguRateSDK
//
//  Created by Viet Nguyen on 4/19/17.
//  Copyright © 2017 goappable. All rights reserved.
//

import UIKit

/// This class to initialize & handle survey screen
class SurveyViewController: UIViewController {
    
    /// :nodoc:
    private var backgroundImageView : UIImageView!
    /// :nodoc:
    private var exitBtn   = UIButton()
    /// :nodoc:
    private var webView   = UIWebView()
    /// :nodoc:
    var virtualId         = ""
    /// :nodoc:
    private var CRProgress : CRProgressHUB?
    
    /// :nodoc:
    //    private var urlString = "https://dev.configurateapp.com/url/device/"
    /// :nodoc:
        //private var urlString = "https://ou-beta.configurateapp.com/url/device/"
        private var urlString = "https://store.configurateapp.com/url/device/"
    /// :nodoc:
    //private var urlString = "https://integris.configurateapp.com/url/device/"
    
    /// :nodoc:
    let platform          = "?platform=iOSSDK"
    
    /// Called after the view controller’s view has been loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        self.showHUB(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadSurvey()
    }
    
    
    /// Function to hidden status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    /// Function to handle touch event on exit button
    ///
    /// - Parameter sender: instance of Button (optional)
    @objc private func exitBtnSelected(sender: UIButton?){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /// Function to initialize, layout for screen. Then load survey
    private func initView() {
        
        let backgroundImage = UIImage(named: "bg_app@3x.png", in: frameworkBundle, compatibleWith: nil)
        backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.backgroundColor = UIColor.purple
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundImageView)
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive           = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive   = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive     = true
        
        webView.backgroundColor                           = UIColor.clear
        webView.delegate                                  = self
        webView.isOpaque                                  = false
        webView.scrollView.alwaysBounceVertical           = false
        webView.scrollView.alwaysBounceHorizontal         = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive           = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive   = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive     = true
        
        exitBtn.tintColor = UIColor.white
        let image         = UIImage(named: "ic_exit.png", in: frameworkBundle, compatibleWith: nil)
        exitBtn.setImage(image, for: .normal)
        exitBtn.backgroundColor = UIColor.clear
        exitBtn.translatesAutoresizingMaskIntoConstraints = false
        exitBtn.addTarget(self, action: #selector(exitBtnSelected), for: .touchUpInside)
        self.view.addSubview(exitBtn)
        
        exitBtn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        exitBtn.rightAnchor.constraint(equalTo: view.rightAnchor).isActive           = true
        exitBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        exitBtn.heightAnchor.constraint(equalToConstant: 60).isActive                = true
        exitBtn.widthAnchor.constraint(equalToConstant: 60).isActive                 = true
    }
    
    
    /// Function to load content of survey
    private func loadSurvey(){
        if let url = URL(string: urlString + virtualId + platform){
            print(url)
            self.webView.loadRequest(URLRequest(url: url))
        }
    }
    
    
    /// Function to show/hide indicator
    ///
    /// - Parameter isShow: true -> show, false -> hide
    func showHUB(_ isShow : Bool) {
        if CRProgress == nil {
            CRProgress = frameworkBundle.loadNibNamed("CRProgressHUB", owner: self, options: nil)?.first as? CRProgressHUB
        }
        isShow ? CRProgress?.show(toView: self.view) : CRProgress?.stopAnimation()
    }
}

extension SurveyViewController: UIWebViewDelegate{
    
    // Function to implement delegate of webview
    func webViewDidFinishLoad(_ webView: UIWebView){
        self.showHUB(false)
    }
}



