//
//  LeftMenuViewController.swift
//  test02
//
//  Created by TK on 2016/01/16.
//  Copyright © 2016年 TK. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Tableで使用する配列を定義する.
    private let myQRItems: NSArray = ["コード1", "コード2"]
    private let myinv1Items: NSArray = ["A1000", "V1000", "J1000", "U1000", "Varispeed AC", "Varispeed G7"]
    private let myinv2Items: NSArray = ["D1000", "R1000", "U1000", "Varispeed AC"]
    
    // Sectionで使用する配列を定義する.
    private let mySections: NSArray = ["QRコード", "汎用インバータ", "回生省エネユニット"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status Barの高さを取得を.する.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成( status barの高さ分ずらして表示 ).
        let myTableView: UITableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう.
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        myTableView.dataSource = self
        
        // Delegateを設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    セクションの数を返す.
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mySections.count
    }
    
    /*
    セクションのタイトルを返す.
    */
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section] as? String
    }
    
    /*
    Cellが選択された際に呼び出される.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            print("Value: \(myQRItems[indexPath.row])")
        } else if indexPath.section == 1 {
            print("Value: \(myinv1Items[indexPath.row])")
        } else if indexPath.section == 2 {
            print("Value: \(myinv2Items[indexPath.row])")
        }

        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = PdfViewController()
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // Viewの移動する.
        //self.presentViewController(mySecondViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
        //self.navigationController?.presentViewController(mySecondViewController, animated: true, completion: nil)
    }
    
    /*
    テーブルに表示する配列の総数を返す.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myQRItems.count
        } else if section == 1 {
            return myinv1Items.count
        } else if section == 2 {
            return myinv2Items.count
        } else {
            return 0
        }
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(myQRItems[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(myinv1Items[indexPath.row])"
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "\(myinv2Items[indexPath.row])"
        }
        
        return cell
    }
    
}
