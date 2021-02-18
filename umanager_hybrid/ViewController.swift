//
//  ViewController.swift
//  umanager_hybrid
//
//  Created by WanGakKim on 2021/02/16.
//  
//


import UIKit
import WebKit
class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://instagram.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    
}

extension ViewController: WKUIDelegate, WKNavigationDelegate{
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: "확인",
                          style: .default,
                          handler: { (action) in
                            completionHandler()}))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) { let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: "확인",
                          style: .default,
                          handler: { (action) in completionHandler(true) }))
        alertController.addAction(
            UIAlertAction(title: "취소",
                          style: .default,
                          handler: { (action) in completionHandler(false) }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //confirm 처리2
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: "", message: prompt, preferredStyle: .alert)
        alertController.addTextField { (textField) in textField.text = defaultText }
        alertController.addAction(
            UIAlertAction(title: "확인",
                          style: .default, handler: { (action) in
                            if let text = alertController.textFields?.first?.text {
                                completionHandler(text)
                            } else {
                                completionHandler(defaultText)
                            }
                          }))
        alertController.addAction(
            UIAlertAction(title: "취소",
                          style: .default,
                          handler: { (action) in
                            completionHandler(nil)
                          }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // href="_blank" 처리
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    // 중복적으로 리로드 방지
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
    }
}
