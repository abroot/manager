//
//  SecondViewController.swift
//  manager
//
//  Created by 福田隆史 on 2017/09/08.
//  Copyright © 2017年 f.R. All rights reserved.
//
import Foundation
import UIKit

class CommonView: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var depLabel: UILabel!
    @IBOutlet weak var comCollection: UICollectionView!
    
    let commonArr:[[String]] = [["初年次教育科目","グロ-バル教育科目"],[],["初修外国語","選択科目"],["実験科目","選択科目","基礎教育入門科目"],["統合1","統合2"]]
    let secName:[String] = ["必修","選択必修","人文・社会科学分野","自然科学分野","教養活用科目"]
    var selectedField:IndexPath!
    var unitsArr = [[Dictionary<String, Bool>]]()
    var denom:[[[Int]]]!
    var reloadFlag:Bool = false
    var dep:Int!
    var major:Int!
    var SHdenom:Int = 0
    var sum:Int = 0
    let ud = UserDefaults.standard
    var cellIndex:Int = 0
    
    //セル生成
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let testCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let fieldLabel = testCell.contentView.viewWithTag(1) as! UILabel
        let numLabel = testCell.contentView.viewWithTag(2) as! UILabel
        let denomLabel = testCell.contentView.viewWithTag(3) as! UILabel
        
        var count:Int = 0
        if (ud.object(forKey: "commonDic") != nil){
            for (_,data) in unitsArr[indexPath.section][indexPath.row]{
                if data == true{count += 2}
            }
        }
        
        switch indexPath.section {
        case 0:
            denomLabel.text = "/\(denom[dep][major][indexPath.row])"
        case 2:
            if indexPath.row == 0 {
                denomLabel.text = "/\(denom[dep][major][2])"
            }else if indexPath.row == 1{
                denomLabel.text = "/\(denom[dep][major][3])"
            }
        case 3:
            if indexPath.row == 0 {
                denomLabel.text = "/\(denom[dep][major][4])"
            }else if indexPath.row == 1{
                denomLabel.text = "/\(denom[dep][major][5])"
            }else if indexPath.row == 2{
                denomLabel.text = "/\(denom[dep][major][6])"
            }
        case 4:
            denomLabel.text = ""
            
        default:
            break
        }
        
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
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! MyCollectionReusableView
        
//        var countH:Int = 0
        var countS:Int = 0
        var countK:Int = 0
        if (ud.object(forKey: "commonDic") != nil){
            
//            for i in 0...unitsArr[0].count-1 {
//                for (_,data) in unitsArr[0][i]{
//                    if data == true{countH += 2}
//                }
//            }
            
            //section2-4　選択必修のtrueを数える
            for i in 2...4{
                for j in 0...unitsArr[i].count-1 {
                    for (_,data) in unitsArr[i][j]{
                        if data == true{countS += 2}
                    }
                }
            }
            
            //sectoin4 教養活用科目のtrueを数える
            for i in 0...unitsArr[4].count-1 {
                for (_,data) in unitsArr[4][i]{
                    if data == true{countK += 2}
                }
            }
        }
        
        //あとで関数にまとめろ　(myCollectioinReusableViewの中身？)
        switch indexPath.section {
        case 0:
            header.numLabel.text = ""
            header.denomLabel.text = ""
            
            header.secLabel.textColor = UIColor.darkGray
            header.secLabel.textAlignment = .left
            header.secLabel.font = UIFont.systemFont(ofSize: 15.0)
            header.secLabel.text = "\(secName[indexPath.section])"
        case 1:
            header.numLabel.textColor = UIColor.black
            header.numLabel.font = UIFont.systemFont(ofSize: 23.0)
            header.numLabel.text = "\(countS)"
            
            header.denomLabel.textColor = UIColor.darkGray
            header.denomLabel.font = UIFont.systemFont(ofSize: 15.0)
            header.denomLabel.text = "/ \(SHdenom + 4)" //教養活用基礎の分母を加える
            
            header.secLabel.textAlignment = .left
            header.secLabel.textColor = UIColor.darkGray
            header.secLabel.font = UIFont.systemFont(ofSize: 15.0)
            header.secLabel.text = "\(secName[indexPath.section])"
        case 2,3:
            header.numLabel.text = ""
            header.denomLabel.text = ""
            
            header.secLabel.textAlignment = .center
            header.secLabel.textColor = UIColor.darkGray
            header.secLabel.font = UIFont.systemFont(ofSize: 12.0)
            header.secLabel.text = "\(secName[indexPath.section])"
        case 4:
            header.numLabel.textColor = UIColor.black
            header.numLabel.font = UIFont.systemFont(ofSize: 23.0)
            header.numLabel.text = "\(countK)"
            
            header.denomLabel.textColor = UIColor.darkGray
            header.denomLabel.font = UIFont.systemFont(ofSize: 15.0)
            header.denomLabel.text = "/ 4"//教養活用基礎の分母
            
            header.secLabel.textAlignment = .center
            header.secLabel.textColor = UIColor.darkGray
            header.secLabel.font = UIFont.systemFont(ofSize: 12.0)
            header.secLabel.text = "\(secName[indexPath.section])"
        default:
            break
        }
        
        return header
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sum = 0
        //reload前にunitsArrを最新に
        if (ud.object(forKey: "commonDic") != nil){
            unitsArr = ud.object(forKey: "commonDic") as! [[Dictionary<String, Bool>]]
            print("will if")
            
            dep = ud.integer(forKey: "department")
            major = ud.integer(forKey: "major")
            
            //comDenominatorに合わせた割り当て
            switch dep {
            case 0:
                if major <= 4 {major = 0}else{major = 1}
            case 2:
                major = 0
            case 3:
                if major == 19 {major = 1}else{major = 0}
            case 4:
                major = 0
            default:
                break
            }
            
            SHdenom = 0
            for i in 2...6 {
                SHdenom += denom[dep][major][i]
            }

//            if reloadFlag == true{  //初回ページアクセス時はreloadしない
//                print("relooooooad")
//                comCollection.reloadData()
//            }
//            reloadFlag = true
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
        
        if (ud.object(forKey: "department") != nil) && (ud.object(forKey: "major") != nil){
            
            let SM = SelectMajor()
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
            depLabel.text = SM.depArray[ud.integer(forKey: "department")] + " " + majName
            
            
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
        
        print("didload")
        
        dep = ud.integer(forKey: "department")
        major = ud.integer(forKey: "major")
        
        //comDenominatorに合わせた割り当て
        switch dep {
        case 0:
            if major <= 4 {major = 0}else{major = 1}
        case 2:
            major = 0
        case 3:
            if major == 19 {major = 1}else{major = 0}
        case 4:
            major = 0
        default:
            break
        }
        
        let path = Bundle.main.path(forResource: "comDenominator", ofType: "plist")
        denom = NSArray(contentsOfFile: path!) as! [[[Int]]]
        
        //選択必修分母
        for i in 2...6 {
            SHdenom += denom[dep][major][i]
        }
        
        //unitsArr　初期準備
        if (ud.object(forKey: "commonDic") != nil){
            unitsArr = ud.object(forKey: "commonDic") as! [[Dictionary<String, Bool>]]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

