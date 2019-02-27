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
    
    var websites = ["baidu.com", "jianshu.com"]
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        progressView.trackTintColor = .clear
        progressView.progressTintColor = .green
        return progressView
    }()
    
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
        
        let url = URL(string: "https://\(websites[0])")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        //KVO
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    func initNavigationBar() {
        //rightBarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        //toolbarItems
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresher = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let progressItem = UIBarButtonItem(customView: progressView)
        let backItem = UIBarButtonItem(barButtonSystemItem: .action, target: webView, action: #selector(webView.goBack))
        let forwardItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        toolbarItems = [progressItem, backItem, spacer, forwardItem, refresher]
        navigationController?.isToolbarHidden = false
    }
    
    @objc func openTapped() {
        let alert = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            alert.addAction(UIAlertAction(title: website, style: .default, handler: { (alertAction) in
                self.openPage(alertAction)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func openPage(_ alertAction: UIAlertAction) {
        guard let urlString = alertAction.title else { return }
        guard let url = URL(string: "https://\(urlString)") else { return }
        webView.load(URLRequest(url: url))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
//            progressView.alpha = CGFloat(1 - webView.estimatedProgress)
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
//            if Float(webView.estimatedProgress) >= 1.0 {
//                progressView.alpha = 0.0
//                progressView.setProgress(0.0, animated: false)
//            }
        }
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
        
        //show alert
        let alert = UIAlertController(title: "Warning", message: "The URL you are trying to visit is blocked", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

