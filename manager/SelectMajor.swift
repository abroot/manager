//
//  SelectMajor.swift
//  manager
//
//  Created by 福田隆史 on 2017/09/09.
//  Copyright © 2017年 f.R. All rights reserved.
//

import Foundation
import UIKit
import SwiftyPickerPopover

class SelectMajor: UIViewController{
    
    @IBOutlet var departmentArray: [UIButton]!
    @IBOutlet weak var depLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    let depArray:[String] = ["工学部","理学部","農学部","教育学部","法文学部"]
    let engineering:[String] = ["情報生体","電気電子","建築","機械","海洋土木","化学生命","環境化学"]
    let science:[String] = ["数理情報","物理科学","生命化学","地球環境"]
    let agriculture:[String] = ["生物生産","生物資源","生物環境"]
    let education:[String] = ["初等教育コース","中等教育コース"]
    let law:[String] = ["人文","法経社会"]
    
    var profile:(dep:Int, major:Int) = (0,0)
    
    //appdelegateにアクセス
    //let myApp = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func actionButton00(_ sender: UIButton) {
        profile.dep = 0
        depSelect(depNum: profile.dep)
        majorSelect(sender: sender)
        
    }
    @IBAction func actionButton01(_ sender: UIButton) {
        profile.dep = 1
        depSelect(depNum: profile.dep)
        majorSelect(sender: sender)
    }
    @IBAction func actionButton02(_ sender: UIButton) {
        profile.dep = 2
        depSelect(depNum: profile.dep)
        majorSelect(sender: sender)
    }
    @IBAction func actionButton03(_ sender: UIButton) {
        profile.dep = 3
        depSelect(depNum: profile.dep)
        majorSelect(sender: sender)
    }
    @IBAction func actionButton04(_ sender: UIButton) {
        profile.dep = 4
        depSelect(depNum: profile.dep)
        majorSelect(sender: sender)
    }
    
    //保存　ユーザデフォに学部学科値を格納　homeに戻る
    @IBAction func seveProfile(_ sender: UIButton) {
        let userDefault = UserDefaults.standard
        userDefault.set(profile.dep, forKey: "department")
        userDefault.set(profile.major, forKey: "major")
    }
    
    //コード短くできそう
    func depSelect(depNum:Int){
        
        var image:UIImage!
        
        for i in 0...departmentArray.count-1 {
            departmentArray[i].tag = 0
        }
        
        departmentArray[depNum].tag = 1
        
        for j in 0...departmentArray.count-1 {
            if departmentArray[j].tag == 1 {
                image = UIImage(named: "frame04.png")
            }else{
                image = UIImage(named: "frame03.png")
            }
            departmentArray[j].setBackgroundImage(image, for: .normal)
        }
        
        depLabel.text = depArray[depNum]
    }
    
    func majorSelect(sender:UIButton){
        
       let p = decideP()
            .setSelectedRow(0)
            .setDoneButton(title:"done", action: {
                (popover, selectedRow, selectedString) in
                self.majorLabel.text = selectedString
                self.profile.major = selectedRow
            })
            .setCancelButton(title:"cancel", action: { v in print("cancel")} )
        
        p.appear(originView: sender,baseViewController: self)
    }
    
    func decideP()->StringPickerPopover{
        
        switch profile.dep{
        case 0:
            return StringPickerPopover(title: "学科選択", choices: engineering)
        case 1:
            return StringPickerPopover(title: "学科選択", choices: science)
        case 2:
            return StringPickerPopover(title: "学科選択", choices: agriculture)
        case 3:
            return StringPickerPopover(title: "学科選択", choices: education)
        case 4:
            return StringPickerPopover(title: "学科選択", choices: law)
        default:
            return StringPickerPopover(title: "学科選択", choices: depArray)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
