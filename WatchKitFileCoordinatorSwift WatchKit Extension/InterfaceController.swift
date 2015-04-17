//
//  InterfaceController.swift
//  WatchKitFileCoordinatorSwift WatchKit Extension
//
//  Created by MAEDAHAJIME on 2015/04/15.
//  Copyright (c) 2015年 MAEDAHAJIME. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    // テキストラベル
    @IBOutlet weak var textLabel: WKInterfaceLabel!
    
    // 最初に呼び出されるメソッド
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }

    // Updateアクション
    @IBAction func onUpdateTap() {
        
        // NSFileCoordinatorとは、同じプロセス内で複数のプロセスとオブジェクト間の
        // ファイルおよびディレクトリの読み込みと書き込みを調整します。
        let fileCoordinator = NSFileCoordinator()
        
        // App Group アプリ間でデータのストレージ共有機能
        // App Group によって定義される共有領域のことを shared container と言います。
        // App Group の識別子で shared container にアクセス
        let groupURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.iScene.watchlist")
        // 共有ディレクトリへのパスを取得
        let fileURL = groupURL?.URLByAppendingPathComponent("todoItems.bin")
        
        fileCoordinator.coordinateReadingItemAtURL(fileURL!, options: nil, error: nil)
            { [unowned self] (newURL) -> Void in
                
                if let savedData = NSData(contentsOfURL: newURL) {

                    // ログ表示
                    //println(NSKeyedUnarchiver.unarchiveObjectWithData(savedData) as! String)
                    // アンアーカイブした　savedDataを表示
                    let data: String? = NSKeyedUnarchiver.unarchiveObjectWithData(savedData) as? String
                    // ログ表示
                    println("data %@", data)
                    
                    // ラベルに表示
                    self.textLabel.setText(data)
                }
        }

    }
    
    // ユーザーにUIが表示されたタイミングで呼び出されるメソッド
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    // UIが非表示になったタイミングで呼び出されるメソッド
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
