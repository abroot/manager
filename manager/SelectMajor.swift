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
    let engineering:[String] = ["情報生体システム工学","電気電子工学","建築工学","機械工学","海洋土木工学","化学生命工学","環境化学工学"]
    let science:[String] = ["数理情報","物理科学","生命化学","地球環境"]
    let agriculture:[String] = ["生物生産 植物生産学コース","生物生産 家畜生産学コース","生物生産 農業経営経済コース","生物資源 生命機能化学コース"," 生物資源 食品機能化学コース","生物資源 食糧生産化学コース","生物資源 焼酎学コース","生物環境 森林化学コース","生物環境 環境システム学コース","生物環境 生産環境工学コース"]
    let education:[String] = ["初等・教育学","初等・心理学","初等・国語","初等・社会","初等・数学","初等・理科","初等・音楽","初等・美術","初等・保健体育","初等・技術","初等・家庭","初等・英語","中等・教育学","中等・心理学","中等・国語","中等・社会","中等・数学","中等・理科","中等・音楽","中等・美術","中等・保健体育","中等・技術","中等・家庭","中等・英語"]
    let law:[String] = ["法政策学","経済情報","人文(人間と文化コース)","人文(メディアと現代文化コース)","人文(比較地域環境コース)","人文(日本とアジアコース)","人文(欧米文化コース)"]
    
    var profile:(dep:Int, major:Int) = (0,0)
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
    
    //保存 udに学部学科値を格納 homeに戻る
    @IBAction func seveProfile(_ sender: UIButton) {
        let ud = UserDefaults.standard
        ud.set(profile.dep, forKey: "department")
        ud.set(profile.major, forKey: "major")
    }
    
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
            .setCancelButton(title:"cancel", action: nil)
        
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
