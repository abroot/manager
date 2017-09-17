//
//  SecondViewController.swift
//  manager
//
//  Created by 福田隆史 on 2017/09/08.
//  Copyright © 2017年 f.R. All rights reserved.
//

import UIKit

class CommonView: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var comCollection: UICollectionView!
    let commonArr:[[String]] = [["初年次教育科目","グロ-バル教育科目"],[],["初修外国語","選択科目"],["実験科目","選択科目","基礎教育入門科目"],["統合1","統合2"]]
    let secName:[String] = ["必修","選択必修","人文・社会科学分野","自然科学分野","教養活用科目"]
    var selectedField:IndexPath!
    var unitsArr = [[Dictionary<String, Bool>]]()
    var sum:Int = 0
    let ud = UserDefaults.standard
    
    //セル生成
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let testCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let fieldLabel = testCell.contentView.viewWithTag(1) as! UILabel
        let numLabel = testCell.contentView.viewWithTag(2) as! UILabel
        
        var count:Int = 0
        if (ud.object(forKey: "commonDic") != nil){
            for (_,data) in unitsArr[indexPath.section][indexPath.row]{
                if data == true{count += 2}
            }
        }
        
//        sum += count
//        print(sum)
        
        numLabel.text = "\(count)"
        fieldLabel.text = commonArr[indexPath.section][indexPath.row]
        
        return testCell
    }
    
    //選択されたセル
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedField = indexPath
        performSegue(withIdentifier: "toList", sender: nil)
    }
    
    //セクション数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    // セル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 0
        case 2:
            return 2
        case 3:
            return 3
        case 4:
            return 2
        default:
            return 0
        }
        
    }
    
    //セクションの設定
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        
        //ヘッダーごとに文字列変えたい
        
        return header
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sum = 0
        //reload前にunitsArrを最新に
        if (ud.object(forKey: "commonDic") != nil){
            unitsArr = ud.object(forKey: "commonDic") as! [[Dictionary<String, Bool>]]
            comCollection.reloadData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var count:Int = 0
        if (ud.object(forKey: "commonDic") != nil){
            for i in 0...unitsArr.count-1{
                for j in 0...unitsArr[i].count-1{
                    for (_,data) in unitsArr[i][j]{
                        if data == true{count += 2}
                    }
                }
            }
        }
        
        ud.set(count, forKey: "comSum")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "toList" {
            let list:CommonList = (segue.destination as? CommonList)!
            list.fieldPath = selectedField
        }
    }
    
    @IBAction func backCommon(_ segue:UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //unitsArr　初期準備
        if (ud.object(forKey: "commonDic") != nil){
            unitsArr = ud.object(forKey: "commonDic") as! [[Dictionary<String, Bool>]]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

