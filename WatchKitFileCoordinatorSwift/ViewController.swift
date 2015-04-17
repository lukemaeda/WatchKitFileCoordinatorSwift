//
//  ViewController.swift
//  WatchKitFileCoordinatorSwift
//
//  Created by MAEDAHAJIME on 2015/04/15.
//  Copyright (c) 2015年 MAEDAHAJIME. All rights reserved.
//

import UIKit

// UITextFieldDelegate のプロトコルをViewControllerに設定
class ViewController: UIViewController, UITextFieldDelegate {

    // テキストラベル
    @IBOutlet weak var textLabel: UILabel!
    // テキストフィールド
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // textFiel の情報を受け取るための delegate を設定
        textField?.delegate = self
        
        textLabel.text = "Type Something..."
    }

    // セーブアクション
    @IBAction func onSaveTap(sender: AnyObject) {
        
        // NSFileCoordinatorとは、同じプロセス内で複数のプロセスとオブジェクト間の
        // ファイルおよびディレクトリの読み込みと書き込みを調整します。
        let fileCoordinator = NSFileCoordinator()
        
        // App Group アプリ間でデータのストレージ共有機能
        // App Group によって定義される共有領域のことを shared container と言います。
        // App Group の識別子で shared container にアクセス
        let groupURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.iScene.watchlist")
        // 共有ディレクトリへのパスを取得
        let fileURL = groupURL?.URLByAppendingPathComponent("todoItems.bin")
        
        fileCoordinator.coordinateWritingItemAtURL(fileURL!, options: nil, error: nil)
            { [unowned self] (newURL) -> Void in
                
                // 入力テキストデータをsaveDataに保存する
                let saveData = self.textField.text
                // NSKeyedArchiver（アーカイブ）を使ってデータをファイルに保存
                let dataToSave = NSKeyedArchiver.archivedDataWithRootObject(saveData!)
                
                // 出来ているか判定チェック
                if dataToSave.writeToURL(newURL, atomically: true) {
                    
                    // テキストラベルに表示
                    self.textLabel.text = saveData
                    
                    //let ret = dataToSave.writeToURL(newURL, atomically: true)
                    //println(ret);//true
                    
                } else {
                    
                    println("何かがおかしい…")
                }
            }
    }

    
    // 「return」を押すと、キーボードを隠す
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        // textField の文字列を受け取り mLabel の文字に設定する
        //mLabel?.text = textField.text
        
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

