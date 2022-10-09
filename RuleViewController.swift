//
//  RuleViewController.swift
//  Hit and Blow
//
//  Created by student on 2019/11/14.
//  Copyright © 2019年 Daigo. All rights reserved.
//

import UIKit

class RuleViewController: UIViewController {
    @IBOutlet weak var RuleLabel: UILabel!
    @IBOutlet weak var example: UIButton!
    
    @IBAction func Next(_ sender: UIButton) {
        
        example.isHidden = true
        
        RuleLabel.text = "例：395\n\n413 ====> 0 Hit -- 0 Blow\n 273 ====> 0 Hit -- 1 Blow\n 367 ====> 1 Hit -- 0 Blow\n 390 ====> 2 Hit -- 0 Blow\n 395 ====> 3 Hit -- 0 Blow\n\n\n3Hit すなわちランダムに設定された数字を全て当てることができたらゲーム終了です。"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
