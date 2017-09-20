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
    var dep:Int!
    var maj:Int!
    var field:Int!
    var fileName:String = ""
    
    //セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unitsArr[maj][field].count
    }
    
    //セル生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //辞書のキーを配列として取り出す
        var keys = [String](unitsArr[maj][field].keys)
        keys.sort()
        let cellText = keys[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = cellText
        
        //状態が true なら初めからチェックにする
        if self.unitsArr[maj][field][cellText]! {
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
            
            cell.isSelected = false  // 選択状態を解除
        }
    }

    @IBAction func preserve(_ sender: UIButton) {
        let ud = UserDefaults.standard
        
        
        ud.set(unitsArr, forKey: fileName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch dep {
        case 0:
            fileName = "engineer"
        case 1:
            fileName = "science"
        case 2:
            fileName = "agri"
        case 3:
            fileName = "edu"
        case 4:
            fileName = "law"
        default:
            break
        }
        
        let ud = UserDefaults.standard
        if (ud.object(forKey: fileName) != nil){
            unitsArr = ud.object(forKey: fileName) as! [[Dictionary<String, Bool>]]
        }else{
            let path = Bundle.main.path(forResource: fileName, ofType: "plist")
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
