//
//  ViewController.swift
//  EasyBrowser
//
//  Created by 李凯 on 2019/2/27.
//  Copyright © 2019年 LK. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView! //implicitly unwrapping optional
    
    override func loadView() {
        webView = WKWebView()
        webView.backgroundColor = .blue
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initNavigationBar()
        
        let url = URL(string: "https://www.baidu.com/")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func initNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresher = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [spacer, refresher]
        navigationController?.isToolbarHidden = false
    }
    
    @objc func openTapped() {
        let alert = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "pan.baidu.com", style: .default, handler: { (alertAction) in
            self.openPage(alertAction)
        }))
        alert.addAction(UIAlertAction(title: "jianshu.com", style: .default, handler: { (alertAction) in
            self.openPage(alertAction)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func openPage(_ alertAction: UIAlertAction) {
        guard let urlString = alertAction.title else { return }
        guard let url = URL(string: "https://\(urlString)") else { return }
        webView.load(URLRequest(url: url))
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

