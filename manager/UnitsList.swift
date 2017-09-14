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
    
    @IBOutlet weak var countLabel: UILabel!
    var unitsArr = [[Dictionary<String, Bool>]]()
    var maj:Int!
    var field:Int!
    
    //セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unitsArr[maj][field].count
    }
    
    //セル生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var keys = [String](unitsArr[maj][field].keys)
        keys.sort()
        let cellText = keys[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = cellText
        
        // チェック状態が true なら、初めからチェック状態にする
        if self.unitsArr[maj][field][cellText]! {
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
                
                self.unitsArr[maj][field].updateValue(false, forKey: cellText!)
                cell.imageView?.image = UIImage(named: "gray.png")
            } else {
                
                self.unitsArr[maj][field].updateValue(true, forKey: cellText!)
                cell.imageView?.image = UIImage(named: "check.png")
            }
            
            //unitsArrのtrueを数える　テキストに表示する
            var count:Int = 0
            for (_,data) in unitsArr[maj][field]{
                if data == true{count += 2}
            }
            countLabel.text = "\(count)"
            
            // 選択状態を解除
            cell.isSelected = false
        }
    }

    @IBAction func preserve(_ sender: UIButton) {
        let ud = UserDefaults.standard
        ud.set(unitsArr, forKey: "unitsDic")
        //ud.set(Int(countLabel.text!), forKey: "countUnits")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let ud = UserDefaults.standard
        if (ud.object(forKey: "unitsDic") != nil){
            unitsArr = ud.object(forKey: "unitsDic") as! [[Dictionary<String, Bool>]]
        }else{
            let path = Bundle.main.path(forResource: "engineer", ofType: "plist")
            unitsArr = NSArray(contentsOfFile: path!) as! [[Dictionary<String, Bool>]]
        }
        
        //unitsArrのtrueを数える　テキストに表示する
        var count:Int = 0
        for (_,data) in unitsArr[maj][field]{
            if data == true{count += 2}
        }
        countLabel.text = "\(count)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
