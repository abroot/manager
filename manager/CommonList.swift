//
//  CommonList.swift
//  manager
//
//  Created by 福田隆史 on 2017/09/17.
//  Copyright © 2017年 f.R. All rights reserved.
//

import Foundation
import UIKit

class CommonList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var countLabel: UILabel!
    var unitsArr = [[Dictionary<String,Bool>]]()
    var fieldPath:IndexPath!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unitsArr[fieldPath.section][fieldPath.row].count
    }
    
    //セル生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //キーを配列にしてテーブルに表示
        var keys = [String](unitsArr[fieldPath.section][fieldPath.row].keys)
        keys.sort()
        let cellText = keys[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = cellText
        
        if self.unitsArr[fieldPath.section][fieldPath.row][cellText]! {
            cell.imageView?.image = UIImage(named: "check.png")
        } else {
            cell.imageView?.image = UIImage(named: "gray.png")
        }
        
        return cell
    }
    
    // Cell が選択された場合
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            // タップしたセルのテキストを取得
            let cellText = cell.textLabel?.text
            
            // 画像を切り替えと Dictonary の値を変更
            if cell.imageView?.image == UIImage(named: "check.png") {
                
                self.unitsArr[fieldPath.section][fieldPath.row].updateValue(false, forKey: cellText!)
                cell.imageView?.image = UIImage(named: "gray.png")
            } else {
                
                self.unitsArr[fieldPath.section][fieldPath.row].updateValue(true, forKey: cellText!)
                cell.imageView?.image = UIImage(named: "check.png")
            }
            
            //unitsArrのtrueを数える　テキストに表示する
            var count:Int = 0
            for (_,data) in unitsArr[fieldPath.section][fieldPath.row]{
                if data == true{count += 2}
            }
            countLabel.text = "\(count)"
            
            
            cell.isSelected = false  // 選択状態を解除
        }
        
    }
    
    
    @IBAction func preserve(_ sender: UIButton) {
        let ud = UserDefaults.standard
        ud.set(unitsArr, forKey: "commonDic")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        if (ud.object(forKey: "commonDic") != nil){
            unitsArr = ud.object(forKey: "commonDic") as! [[Dictionary<String, Bool>]]
        }else{
            let path = Bundle.main.path(forResource: "commons", ofType: "plist")
            unitsArr = NSArray(contentsOfFile: path!) as! [[Dictionary<String, Bool>]]
        }
        
        var count:Int = 0
        for (_,data) in unitsArr[fieldPath.section][fieldPath.row]{
            if data == true{count += 2}
        }
        countLabel.text = "\(count)"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
