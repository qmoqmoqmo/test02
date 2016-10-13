//
//  PdfViewController.swift
//  test02
//
//  Created by TK on 2016/01/16.
//  Copyright © 2016年 TK. All rights reserved.
//

import UIKit
import WebKit

class PdfViewController: UIViewController, WKNavigationDelegate, UIWebViewDelegate, WKUIDelegate {

    var myToolbar: UIToolbar!
    var myWebView2: UIWebView!
    var myWebView: WKWebView!
    var webView: WKWebView!
    var myPDFurl: NSURL!
    var myRequest: NSURLRequest!
    var myIndiator: UIActivityIndicatorView!
    var myNavigationController: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "製品情報"
        //myNavigationController = UINavigationController(rootViewController: self)
        // ツールバーのサイズを決める.
        myToolbar = UIToolbar(frame: CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 40.0))
        // ツールバーの位置を決める.
        myToolbar.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height-20.0)
        // ツールバーの色を決める.
        myToolbar.barStyle = .BlackTranslucent
        myToolbar.tintColor = UIColor.whiteColor()
        myToolbar.backgroundColor = UIColor.blackColor()
        let myUIBarButtonArm: UIBarButtonItem = UIBarButtonItem(title: "アラーム一覧", style:.Plain, target: self, action: "onClickBarButton:")
        myUIBarButtonArm.tag = 1
        let myUIBarButtonPrm: UIBarButtonItem = UIBarButtonItem(title: "パラメータ一覧", style:.Plain, target: self, action: "onClickBarButton:")
        myUIBarButtonPrm.tag = 2
        let myUIBarButtonSts: UIBarButtonItem = UIBarButtonItem(title: "動作・状態一覧", style:.Plain, target: self, action: "onClickBarButton:")
        myUIBarButtonSts.tag = 3
        let myUIBarButtonMan: UIBarButtonItem = UIBarButtonItem(title: "マニュアル", style:.Plain, target: self, action: "onClickBarButton:")
        myUIBarButtonMan.tag = 4
        let myUIBarButtonQR: UIBarButtonItem = UIBarButtonItem(title: "QRコード", style:.Plain, target: self, action: "onClickBarButton:")
        myUIBarButtonQR.tag = 5
        myToolbar.items = [myUIBarButtonArm, myUIBarButtonPrm, myUIBarButtonSts, myUIBarButtonMan, myUIBarButtonQR]
        // ツールバーに追加する.
        self.view.addSubview(myToolbar)

        // ページ読み込み中に表示させるインジケータを生成.
        myIndiator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        myIndiator.center = self.view.center
        myIndiator.hidesWhenStopped = true
        myIndiator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray

        let sw = 0
        if(sw == 0) {
            myWebView = WKWebView(frame: CGRectMake(0, 70, self.view.frame.width, self.view.frame.height - 110))
            myWebView.allowsBackForwardNavigationGestures = true
            //self.view = self.webView!
            let url = NSURL(string:"http://webservice.e-mechatronics.com/XML_Files/modelList/modelList_Servopack.xml")!
            let req = NSURLRequest(URL:url)
            myWebView.loadRequest(req)
            self.view.addSubview(myWebView)
        } else if(sw == 1) {
            self.webView = WKWebView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 60))
            self.webView.allowsBackForwardNavigationGestures = true
            self.view = self.webView!
            let url = NSURL(string:"https://developer.apple.com/jp/documentation/CocoaEncyclopedia.pdf")!
            let req = NSURLRequest(URL:url)
            self.webView!.loadRequest(req)
        } else if(sw == 2) {
            // PDFを開くためのWebViewを生成.
            myWebView2 = UIWebView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 60))
            myWebView2.delegate = self
            myWebView2.scalesPageToFit = true
//            myWebView.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
//            myButton.layer.position = CGPointMake(10, 10)
        
            // URLReqestを生成.
            myPDFurl = NSURL(string: "https://developer.apple.com/jp/documentation/CocoaEncyclopedia.pdf")!
            //myPDFurl = NSURL(string: "http://www.e-mechatronics.com/jsp_ssl/download/techdoc/inverter/technicalsupport_info/data/doc01.pdf")!
            myRequest = NSURLRequest(URL: myPDFurl)
            
            myWebView.loadRequest(myRequest)
            self.view.addSubview(myWebView)
        }
    }

    /*
    UIBarButtonItemが押された際に呼ばれる.
    */
    internal func onClickBarButton(sender: UIBarButtonItem) {
        
        switch sender.tag {
        case 1:
            self.title = "アラーム一覧"
            self.view.backgroundColor = UIColor.greenColor()
            myWebView = WKWebView(frame: CGRectMake(0, 70, self.view.frame.width, self.view.frame.height - 110))
            myWebView.allowsBackForwardNavigationGestures = true
            let url = NSURL(string:"http://webservice.e-mechatronics.com/XML_Files/troubleshootings/SGD7S00/alarm/jpn/list.xml")!
            let req = NSURLRequest(URL:url)
            myWebView.loadRequest(req)
            self.view.addSubview(myWebView)
        case 2:
            self.title = "パラメータ一覧"
            self.view.backgroundColor = UIColor.blueColor()
            self.view.backgroundColor = UIColor.greenColor()
            myWebView = WKWebView(frame: CGRectMake(0, 70, self.view.frame.width, self.view.frame.height - 110))
            myWebView.allowsBackForwardNavigationGestures = true
            let url = NSURL(string:"http://webservice.e-mechatronics.com/XML_Files/troubleshootings/SGD7S00/param/jpn/list.xml")!
            let req = NSURLRequest(URL:url)
            myWebView.loadRequest(req)
            self.view.addSubview(myWebView)
        case 3:
            self.title = "動作・状態一覧"
            self.view.backgroundColor = UIColor.redColor()
            self.view.backgroundColor = UIColor.blueColor()
            self.view.backgroundColor = UIColor.greenColor()
            myWebView = WKWebView(frame: CGRectMake(0, 70, self.view.frame.width, self.view.frame.height - 110))
            myWebView.allowsBackForwardNavigationGestures = true
            let url = NSURL(string:"http://webservice.e-mechatronics.com/XML_Files/troubleshootings/SGD7S00/state/jpn/list.xml")!
            let req = NSURLRequest(URL:url)
            myWebView.loadRequest(req)
            self.view.addSubview(myWebView)
        case 4:
            self.view.backgroundColor = UIColor.redColor()
        case 5:
            self.view.backgroundColor = UIColor.redColor()
        default:
            print("ERROR!!")
        }
    }
    
    /*
    インジケータのアニメーション開始.
    */
    func startAnimation() {
        
        // NetworkActivityIndicatorを表示.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // UIACtivityIndicatorを表示.
        if !myIndiator.isAnimating() {
            myIndiator.startAnimating()
        }
        
        // viewにインジケータを追加.
        self.view.addSubview(myIndiator)
    }
    
    /*
    インジケータのアニメーション終了.
    */
    func stopAnimation() {
        // NetworkActivityIndicatorを非表示.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        // UIACtivityIndicatorを非表示.
        if myIndiator.isAnimating() {
            myIndiator.stopAnimating()
        }
    }
    
    /*
    Buttonが押された時に呼ばれるメソッド.
    */
    func onClickMyButton(sender: UIButton) {
        
        // WebViewのLoad開始.
        myWebView.loadRequest(myRequest)
        
        // viewにWebViewを追加.
        self.view.addSubview(myWebView)
    }
    
    /*
    WebViewのloadが開始された時に呼ばれるメソッド.
    */
    func webViewDidStartLoad(webView: UIWebView) {
        print("load started")
        
        startAnimation()
    }
    
    /*
    WebViewのloadが終了した時に呼ばれるメソッド.
    */
    func webViewDidFinishLoad(webView: UIWebView) {
        print("load finished")
        
        stopAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
