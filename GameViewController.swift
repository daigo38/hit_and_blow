//
//  GameViewController.swift
//  Hit and Blow
//
//  Created by student on 2019/10/30.
//  Copyright © 2019年 Daigo. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var answer1 = arc4random() % 10
    var answer2 = arc4random() % 10
    var answer3 = arc4random() % 10
    
    
    
    var rog:String = ""
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var hyo: UILabel!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numLabel.text=""
        while (answer1 == answer2 || answer1 == answer3 || answer3 == answer2){
            answer1 = arc4random() % 10
            answer2 = arc4random() % 10
            answer3 = arc4random() % 10
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func input(_ sender: UIButton) {
        guard let numText = numLabel.text else {
            return
        }
        guard let senderedText = sender.titleLabel?.text else {
            return
        }
        
        numLabel.text = numText + senderedText
        
    }
    
    @IBAction func Reset(_ sender: UIButton) {
        numLabel.text=""
    }
    
    

    @IBAction func coll(_ sender: UIButton) {
        
        guard let numText = numLabel.text else {
            return
        }
        let num:Int? = Int(numText)!
        numLabel.text=""
        
       
        
        let san:Int = num! / 100
        let ni:Int = (num! - (san * 100)) / 10
        let iti:Int = num! - (san * 100) - (ni * 10)
        var count:Int = 1
        var hit:Int = 0
        var blow:Int = 0
        
        
        while count <= 3 {
            if count == 1{
                if iti == answer1{
                    hit += 1
                }else if (iti == answer2 || iti == answer3){
                    blow += 1
                }
                
            }else if count == 2{
                if ni == answer2{
                    hit += 1
                }else if (ni == answer1 || ni == answer3){
                    blow += 1
                }
                
            }else{
                if san == answer3{
                    hit += 1
                }else if (san == answer1 || san == answer2){
                    blow += 1
                }
            }
            count = count + 1
        }
        
        rog = rog + String(san) + String(ni) + String(iti) + "  =====＞  " + String(hit) + " Hit -- " + String(blow) + " Blow" + "\n"

        hyo.text = rog
        
        if hit == 3{
            var dispatchTime = DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.performSegue(withIdentifier: "goResult", sender: nil)
            }
            

                
        }
    }
}
    
    

