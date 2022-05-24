//
//  MainChargeMyPage.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/20.
//

import UIKit
import WebKit

class MainChargeMyPage: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    @objc(userContentController:didReceiveScriptMessage:) func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("되라고")
    }
    
    var webView: WKWebView!
    final let bridgeName = "Bootpay_iOS"
    final let ios_application_id = "62866e53e38c300024ad1edb" // iOS

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
            HTTPCookieStorage.shared.cookieAcceptPolicy = HTTPCookie.AcceptPolicy.always  // 현대카드 등 쿠키설정 이슈 해결을 위해 필요
            let configuration = WKWebViewConfiguration() //wkwebview <-> javasscript function(bootpay callback)
            configuration.userContentController.add(self, name: bridgeName)
            webView = WKWebView(frame: self.view.bounds, configuration: configuration)
            webView.uiDelegate = self
            webView.navigationDelegate = self
            self.view.addSubview(webView)


            let url = URL(string: "https://nahyeonDev.github.io")
            if let url = url {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }

}
