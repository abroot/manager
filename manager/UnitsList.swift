//
//  unitsList.swift
//  manager
//
//  Created by 福田隆史 on 2017/09/13.
//  Copyright © 2017年 f.R. All rights reserved.
//

import Foundation
import UIKit

class UnitsList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var unitsArr:[[[String]]] = [[[]]]
    var unitsArr = [[Dictionary<String, Bool>]]()
    var maj:Int!
    var field:Int!
    
    //セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unitsArr[maj][field].count
    }
    
    //セル生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var keys = [String](unitsArr[0][0].keys)
        keys.sort()
        let cellText = keys[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = cellText
        
        // チェック状態が true なら、初めからチェック状態にする
        if self.unitsArr[0][0][cellText]! {
            cell.imageView?.image = UIImage(named: "check.png")
        } else {
            cell.imageView?.image = UIImage(named: "gray.png")
        }
//        cell.textLabel?.text = "\(unitsArr[maj][field][indexPath.row])"
        return cell
    }
    
    // Cell が選択された場合
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            // タップしたセルのテキストを取得
            let cellText = cell.textLabel?.text
            
            // 画像を切り替えと Dictonary の値を変更
            if cell.imageView?.image == UIImage(named: "check.png") {
                
                self.unitsArr[0][0].updateValue(false, forKey: cellText!)
                cell.imageView?.image = UIImage(named: "gray.png")
            } else {
                
                self.unitsArr[0][0].updateValue(true, forKey: cellText!)
                cell.imageView?.image = UIImage(named: "check.png")
            }
            
            // 選択状態を解除
            cell.isSelected = false
        }
            
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "engineer", ofType: "plist")
        //unitsArr = NSArray(contentsOfFile: path!) as! [[[String]]]
        unitsArr = NSArray(contentsOfFile: path!) as! [[Dictionary<String, Bool>]]
        print("\(maj) \(field)")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
