//
//  SpecialtyView.swift
//  manager
//
//  Created by 福田隆史 on 2017/09/08.
//  Copyright © 2017年 f.R. All rights reserved.
//

import Foundation
import UIKit

class SpecialtyView: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    @IBOutlet weak var fieldCollection: UICollectionView!
    var fieldArr:[[[String]]] = [[[]]]
    var unitsArr = [[Dictionary<String, Bool>]]()
    var dep:Int!
    var major:Int!
    var selectedField:Int!
    let ud = UserDefaults.standard
    
    //セルを編集して返す cell数分呼ばれてる indexPath.row(0から始まる)がそんときのインデックス
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // Cell はストーリーボードで設定したセルのID
        let testCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        var count:Int = 0
        if (ud.object(forKey: "unitsDic") != nil){
            unitsArr = ud.object(forKey: "unitsDic") as! [[Dictionary<String, Bool>]]
            for (_,data) in unitsArr[major][indexPath.row]{
                if data == true{count += 2}
            }
        }
        
        let fieldLabel = testCell.contentView.viewWithTag(1) as! UILabel
        let numLabel = testCell.contentView.viewWithTag(2) as! UILabel
//        label.text = fieldArr[dep][major][(indexPath as NSIndexPath).row]
        fieldLabel.text = fieldArr[dep][major][(indexPath as NSIndexPath).row]
        numLabel.text = "\(count)"
        
        return testCell
    }
    
    //選択されたセル
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedField = indexPath.row
        performSegue(withIdentifier: "toList", sender: nil)
    }
    
    //セクション数？
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は１つ
        return 1
    }
    
    // cell数を入れる、要素以上の数字を入れると表示でエラーとなる
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let ud = UserDefaults.standard
        dep = ud.integer(forKey: "department")
        major = ud.integer(forKey: "major")
        return fieldArr[dep][major].count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (ud.object(forKey: "unitsDic") != nil){
            
        }
        fieldCollection.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "toList" {
            let list:UnitsList = (segue.destination as? UnitsList)!
            list.maj = major!
            list.field = selectedField
        }
    }
    
    @IBAction func backSpecialty(_ segue:UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "fieldName", ofType: "plist")
        fieldArr = NSArray(contentsOfFile: path!) as! [[[String]]]
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
