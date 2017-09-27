//
//  FirstViewController.swift
//  manager
//
//  Created by 福田隆史 on 2017/09/08.
//  Copyright © 2017年 f.R. All rights reserved.
//

import FontAwesome_swift
import UIKit


class HomeView: UIViewController {
    
    
    
    @IBOutlet weak var depLabel: UILabel!
    
    @IBOutlet weak var allSum: UILabel!
    @IBOutlet weak var sumDenom: UILabel!
    @IBOutlet weak var comSumLabel: UILabel!
    @IBOutlet weak var comDenom: UILabel!
    @IBOutlet weak var speSumLabel: UILabel!
    @IBOutlet weak var speDenom: UILabel!
    
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var toSelectButton: UIBarButtonItem!
    @IBAction func toSelectButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toSelect", sender: self)
    }
    
    var comSum:Int = 0
    var speSum:Int = 0
    //let comDenomSum:[Int] = []
    
    //画面が表示された直後
    override func viewDidAppear(_ animated: Bool) {
        
        let ud = UserDefaults.standard
        
        //初回起動時の強制画面遷移
        if ud.bool(forKey: "homeLaunch") {
            ud.set(false, forKey: "homeLaunch")
            performSegue(withIdentifier: "toSelect", sender: self)
        }
        
        if ud.object(forKey: "deparatment") == nil && ud.object(forKey: "major") == nil{
            performSegue(withIdentifier: "toSelect", sender: self)
        }
        
        if (ud.object(forKey: "department") != nil) && (ud.object(forKey: "major") != nil){
            //↓変数にユーザデフォいれようとすると通らんくなる、０てことになる
//            let depNum:Int = ud.integer(forKey: "depatment")
            //let majorNum:Int = ud.integer(forKey: "major")
            let SM = SelectMajor()
            var majName:String!
            //depLabel.text = SM.depArray[ud.integer(forKey: "department")]
            
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
            
            //分母
            let intBox_com:Int = comDenomSelecter(dep: ud.integer(forKey: "department"), maj: ud.integer(forKey: "major"))
            let intBox_spe:Int = speDenomSelecter(dep: ud.integer(forKey: "department"), maj: ud.integer(forKey: "major"))
            
            comDenom.text = "/\(intBox_com)"
            speDenom.text = "/\(intBox_spe)"
            sumDenom.text = "/\(intBox_com + intBox_spe)"
            
            if ud.object(forKey: "comSum") != nil {
                comSum = ud.integer(forKey: "comSum")
            }
        
            if ud.object(forKey: majName) != nil {
                speSum = ud.integer(forKey: majName)
            }else{
                speSum = 0
            }
        
            comSumLabel.text = "\(comSum)"
            speSumLabel.text = "\(speSum)"
            allSum.text = "\(comSum + speSum)"
        }
    }
    
    //分母　割り当て関数
    func comDenomSelecter(dep:Int ,maj:Int) -> Int{
        var denom:Int!
        switch dep {
        case 0:
            if maj <= 4 {denom=31}else{denom=32}
        case 1:
            switch maj {
            case 0:
                denom = 28
            case 1:
                denom = 32
            case 2,3:
                denom = 34
            default:
                break
            }
        case 2:
            denom = 38
        case 3:
            denom = 31
        case 4:
            denom = 30
        default:
            break
        }
        return denom
    }
    
    func speDenomSelecter(dep:Int ,maj:Int) -> Int{
        var denom:Int!
        switch dep {
        case 0:
            denom = 80
        case 1:
            if maj == 1{denom=79}else{denom=78}
        case 2:
            if maj <= 2{denom=83}else{denom=84}
        case 3:
            denom = 90
        case 4:
            denom = 94
        default:
            break
        }
        
        return denom
    }

    @IBAction func backHome(_ segue:UIStoryboardSegue){}
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toSelect") {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [NSFontAttributeName:UIFont.fontAwesome(ofSize: 25)] as [String: Any]
        toSelectButton.setTitleTextAttributes(attributes, for: .normal)
        toSelectButton.title = String.fontAwesomeIcon(name: .cog)
        
        myToolbar.frame = CGRect(x:0, y:0, width:320, height:60)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
