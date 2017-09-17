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
    @IBOutlet weak var profLabel: UILabel!
    var fieldArr:[[[String]]] = [[[]]]
    var unitsArr = [[Dictionary<String, Bool>]]()
    var dep:Int!
    var major:Int!
    var selectedField:Int!
    var sum:Int = 0
    let ud = UserDefaults.standard
    
    //セルを編集して返す cell数分呼ばれてる indexPath.row(0から始まる)が各セルのインデックス
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let testCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let fieldLabel = testCell.contentView.viewWithTag(1) as! UILabel
        let numLabel = testCell.contentView.viewWithTag(2) as! UILabel
        
//        print(indexPath.row)
//        print(fieldArr[dep][major].count)
        
        if indexPath.row == fieldArr[dep][major].count{
            fieldLabel.textColor = UIColor.red
            fieldLabel.text = "合計"
            numLabel.textColor = UIColor.red
            numLabel.text = "\(sum)"
            
        }else{
            var count:Int = 0
            if (ud.object(forKey: "unitsDic") != nil){
                for (_,data) in unitsArr[major][indexPath.row]{
                    if data == true{count += 2}
                }
            }
            sum += count
            fieldLabel.textColor = UIColor.darkGray
            fieldLabel.text = fieldArr[dep][major][indexPath.row]
            numLabel.textColor = UIColor.darkGray
            numLabel.text = "\(count)"
        }
        return testCell
    }
    
    //選択されたセル
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedField = indexPath.row
        performSegue(withIdentifier: "toList", sender: nil)
    }
    
    //セクション数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // cell数を入れる、要素以上の数字を入れると表示でエラーとなる
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let ud = UserDefaults.standard
        dep = ud.integer(forKey: "department")
        major = ud.integer(forKey: "major")
        
        //print("aaa") 最初だけdidLoadとwillのreloadで2回呼ばれている
        return fieldArr[dep][major].count+1 //+1 は合計表示用セル
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sum = 0
        
        if (ud.object(forKey: "department") != nil) || (ud.object(forKey: "major") != nil){
            
            let SM = SelectMajor()
            let depName:String = SM.depArray[ud.integer(forKey: "department")]
            var majName:String = ""
            
            switch ud.integer(forKey: "department") {
            case 0:
                majName = SM.engineering[ud.integer(forKey: "major")]
            case 1:
                majName = SM.science[ud.integer(forKey: "major")]
            case 2:
                majName = SM.agriculture[ud.integer(forKey: "major")]
            case 3:
                majName = SM.education[ud.integer(forKey: "major")]
            case 4:
                majName = SM.law[ud.integer(forKey: "major")]
            default:
                break
            }
            
            profLabel.text = "\(depName)  \(majName)"
        }

        
        //reload前にunitsArrを最新に
        if (ud.object(forKey: "unitsDic") != nil){
            unitsArr = ud.object(forKey: "unitsDic") as! [[Dictionary<String, Bool>]]
            fieldCollection.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ud.set(sum, forKey: "speSum")
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
        
        //unitsArr　初期準備
        if (ud.object(forKey: "unitsDic") != nil){
            unitsArr = ud.object(forKey: "unitsDic") as! [[Dictionary<String, Bool>]]
        }
        
        let path = Bundle.main.path(forResource: "fieldName", ofType: "plist")
        fieldArr = NSArray(contentsOfFile: path!) as! [[[String]]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
