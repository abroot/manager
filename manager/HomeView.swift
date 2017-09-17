//
//  FirstViewController.swift
//  manager
//
//  Created by 福田隆史 on 2017/09/08.
//  Copyright © 2017年 f.R. All rights reserved.
//

import UIKit

class HomeView: UIViewController {
    
    @IBOutlet weak var depLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var allSum: UILabel!
    @IBOutlet weak var comSumLabel: UILabel!
    @IBOutlet weak var speSumLabel: UILabel!
    @IBAction func toSelectButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toSelect", sender: self)
    }
    var comSum:Int = 0
    var speSum:Int = 0
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toSelect") {
        }
    }
    
    //画面が表示された直後？
    override func viewDidAppear(_ animated: Bool) {
        //viewDidLoadだと画面遷移ができない
        //viewWillAppearでもだめ
        let ud = UserDefaults.standard
        if ud.bool(forKey: "homeLaunch") {
            //以降、実行されないようにfalseを入れる
            ud.set(false, forKey: "homeLaunch")
            performSegue(withIdentifier: "toSelect", sender: self)
        }
        
        if (ud.object(forKey: "department") != nil) || (ud.object(forKey: "major") != nil){
            //↓変数にユーザデフォいれようとすると通らんくなる、０てことになる
            //let depNum:Int = ud.integer(forKey: "depatment")
            //let majorNum:Int = ud.integer(forKey: "major")
            let SM = SelectMajor()
            depLabel.text = SM.depArray[ud.integer(forKey: "department")]
            
            switch ud.integer(forKey: "department") {
            case 0:
                majorLabel.text = SM.engineering[ud.integer(forKey: "major")]
            case 1:
                majorLabel.text = SM.science[ud.integer(forKey: "major")]
            case 2:
                majorLabel.text = SM.agriculture[ud.integer(forKey: "major")]
            case 3:
                majorLabel.text = SM.education[ud.integer(forKey: "major")]
            case 4:
                majorLabel.text = SM.law[ud.integer(forKey: "major")]
            default:
                break
            }
        }
        
        if ud.object(forKey: "comSum") != nil {
            comSum = ud.integer(forKey: "comSum")
        }
        
        if ud.object(forKey: "speSum") != nil {
            speSum = ud.integer(forKey: "speSum")
        }
        
        comSumLabel.text = "\(comSum)"
        speSumLabel.text = "\(speSum)"
        allSum.text = "\(comSum + speSum)"
    }

    @IBAction func backHome(_ segue:UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
