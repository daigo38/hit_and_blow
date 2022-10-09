//
//  GameViewController2.swift
//  Hit and Blow
//
//  Created by student on 2019/11/19.
//  Copyright © 2019年 Daigo. All rights reserved.
//

import UIKit

class GameViewController2: UIViewController {
    var answer1 = arc4random() % 10
    var answer2 = arc4random() % 10
    var answer3 = arc4random() % 10
    var first = 0
    var second = 0
    var third = 0
    var hozon = 0
    var x = 1//case 何か
    var misiyou = [0,1,2,3,4,5,6,7,8,9]
    
    var sum = 0
    
    var koho:[String] = [""]
    
    
    var sortedArray:[Int] = [0,0,0,0,0,0,0,0,0,0]
    var omomi:[Int] = [0,0,0,0,0,0,0,0,0,0]
    
    var past:[[Int]] = [[]]
    var c = 1//ターン数えるやつ
    var HBc = 0
    
    
    
    var Crog:String = ""
    var Urog:String = ""
    
    @IBOutlet weak var bg: UIView!
    
    @IBOutlet weak var Text: UITextField!
    
    @IBOutlet weak var YourResult: UILabel!
    
    @IBOutlet weak var CPUResult: UILabel!
    
    @IBOutlet weak var CPU: UILabel!
    
    @IBOutlet weak var Text1: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(Text1)
        
        while (answer1 == answer2 || answer1 == answer3 || answer3 == answer2){
            answer1 = arc4random() % 10
            answer2 = arc4random() % 10
            answer3 = arc4random() % 10
        }
        
        Text.keyboardType = UIKeyboardType.phonePad
        Text.returnKeyType = UIReturnKeyType.next
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var Unum = 0
    
    
    @IBAction func Set(_ sender: UITextField) {
        
            Text1.isHidden = true
            bg.isHidden = true
            
        
        
    }
    
    
    
    
    @IBAction func Yourturn(_ sender: UITextField) {
        let Cnum: Int? = Int(Text.text!)
        let Csan = Cnum! / 100
        let Cni = (Cnum! - Csan * 100) / 10
        let Citi = (Cnum! - Csan * 100 - Cni * 10)
        var count = 1
        var hit = 0
        var blow = 0
        
        while count <= 3 {
            if count == 1{
                if Citi == answer1{
                    hit += 1
                }else if (Citi == answer2 || Citi == answer3){
                    blow += 1
                }
                
            }else if count == 2{
                if Cni == answer2{
                    hit += 1
                }else if (Cni == answer1 || Cni == answer3){
                    blow += 1
                }
                
            }else{
                if Csan == answer3{
                    hit += 1
                }else if (Csan == answer1 || Csan == answer2){
                    blow += 1
                }
            }
            count = count + 1
        }
        
        Urog = Urog + String(Csan) + String(Cni) + String(Citi) + " ===＞ " + String(hit) + " Hit - " + String(blow) + " Blow" + "\n"
        
        YourResult.text = Urog
        
        if hit == 3{
            var dispatchTime = DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.performSegue(withIdentifier: "toResult", sender: nil)
            }
        }
        CPUturn()
        
    }
    
    func CPUturn(){
        var y = 1
        var best = 0
        
        if c == 1{
            first = Int(arc4random() % 10)
            second = Int(arc4random() % 10)
            third = Int(arc4random() % 10)
            while (first == second || first == third || third == second){
                first = Int(arc4random() % 10)
                second = Int(arc4random() % 10)
                third = Int(arc4random() % 10)
                
            }
            
        }else if koho.count >= 30{
            var minkohosu = 1000
            
            while y < 1000{
                third = y / 100
                second = (y - third * 100) / 10
                first = (y - third * 100 - second * 10)
                
                if (first != second && first != third && second != third){
                    let k = Nerrow(f: first,s: second,t: third)
                    
                    if minkohosu >= k.max{
                        minkohosu = k.max
                        best = y
                    }
                }
                y += 1
                
            }
            
            third = best / 100
            second = (best - third * 100) / 10
            first = (best - third * 100 - second * 10)
            
        }else{
            var minkohosu = 10000
            
            while y < 1000{
                third = y / 100
                second = (y - third * 100) / 10
                first = (y - third * 100 - second * 10)
                
                if (first != second && first != third && second != third){
                    let k = Nerrow(f: first,s: second,t: third)
                    
                    if minkohosu >= (k.max + k.min + k.kei){
                        minkohosu = (k.max + k.min + k.kei)
                        best = y
                    }
                }
                y += 1
            }

            third = best / 100
            second = (best - third * 100) / 10
            first = (best - third * 100 - second * 10)
            
            
            if koho.count == 3{
                koho.remove(at: 0)
                let random = Int(arc4random() % 2)
                third = Int(koho[random])! / 100
                second = (Int(koho[random])! - third * 100) / 10
                first = (Int(koho[random])! - third * 100 - second * 10)
            }else if koho.count == 2 || koho.count == 1{
                koho.remove(at: 0)
                third = Int(koho[0])! / 100
                second = (Int(koho[0])! - third * 100) / 10
                first = (Int(koho[0])! - third * 100 - second * 10)
            }else{
            }
            
        }
        
        
        
        var h = hantei(f: first,s: second,t: third)
        
        
        
        CPU.text = String(third) + String(second) + String(first);
        
        print(koho.count)
        
        Crog = Crog + String(third) + String(second) + String(first) + " ===＞ " + String(h.Chit) + " Hit - " + String(h.Cblow) + " Blow" + "\n"
        
        CPUResult.text = Crog
       
        
        c += 1
        
    }
    
    func hantei(f: Int,s: Int,t: Int)->(Chit:Int,Cblow:Int){
        Unum = Int(Text1.text!)!
        
        let san = Unum / 100
        let ni = (Unum - san * 100) / 10
        let iti = (Unum - san * 100 - ni * 10)
        
        var count2 = 1
        var Chit = 0
        var Cblow = 0
        while count2 <= 3 {
            if count2 == 1{
                if f == iti{
                    Chit += 1
                }else{}
                if (f == ni || f == san){
                    Cblow += 1
                }
                
            }else if count2 == 2{
                if s == ni{
                    Chit += 1
                }else{}
                if (s == iti || s == san){
                    Cblow += 1
                }
                
            }else{
                if t == san{
                    Chit += 1
                }else{}
                if (t == iti || t == ni){
                    Cblow += 1
                }
            }
            count2 += 1
        }
        if Chit == 3{
            var dispatchTime = DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.performSegue(withIdentifier: "toResult", sender: nil)
            }
        }
        
        var three = 0
        var two = 0
        var one = 0
        var Nerrownum: String = ""
        
        if c == 1{
            if(Chit == 0){
                if(Cblow == 0){
                    while three <= 9 {
                        two = 0
                        while two <= 9 {
                            one = 0
                            while one <= 9 {
                                if (one != f && one != s && one != t && two != f && two != s && two != t && three != f && three != s && three != t ){
                                    Nerrownum = String(three * 100 + two * 10 + one)
                                    koho += [Nerrownum]
                                }
                                one += 1
                            }
                            two += 1
                        }
                        three += 1
                    }
                }else if(Cblow == 1){
                    while three <= 9 {
                        two = 0
                        while two <= 9 {
                            one = 0
                            while one <= 9 {
                                if (one == s || one == t || two == f || two == t || three == f || three == s ){
                                    if(one == s || one == t){
                                        if (two != f && two != t && three != f && three != s){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }else if (two == f || two == t){
                                        if (one != s && one != t && three != f && three != s){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }else{
                                        if (one != s && one != t && two != f && two != t){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }
                                }
                                one += 1
                            }
                            two += 1
                        }
                        three += 1
                    }
                }else if(Cblow == 2){
                    while three <= 9 {
                        two = 0
                        while two <= 9 {
                            one = 0
                            while one <= 9 {
                                if (one == s || one == t || two == f || two == t || three == f || three == s ){
                                    if(one == s || one == t){
                                        if (((two == f || two == t) && (three != f && three != s)) || ((three == f || three == s) && (two != f && two != t))){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }else if(two == f || two == t){
                                        if (((one == s || one == t) && (three != f && three != s)) || ((three == f || three == s) && (one != s && one != t))){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }else{
                                        if (((one == s || one == t) && (two != f && two != t)) || ((two == f || two == t) && (one != s && one != t))){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }
                                    
                                }
                                one += 1
                            }
                            two += 1
                        }
                        three += 1
                    }
                }else{
                    while three <= 9 {
                        two = 0
                        while two <= 9 {
                            one = 0
                            while one <= 9 {
                                if((one == s || one == t) && (two == f || two == t) && (three == f || three == s)){
                                    Nerrownum = String(three * 100 + two * 10 + one)
                                    koho += [Nerrownum]
                                }
                                one += 1
                            }
                            two += 1
                        }
                        three += 1
                    }
                }
            }else if (Chit == 1){
                if (Cblow == 0){
                    while three <= 9 {
                        two = 0
                        while two <= 9 {
                            one = 0
                            while one <= 9 {
                                if(one == f || two == s || three == t){
                                    if ((one == f) && (two != s && three != t)){
                                        if(two != f && two != t && three != f && three != s){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }else if((two == s) && (one != f && three != t)){
                                        if(one != s && one != t && three != f && three != s){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }else if((three == t) && (one != f && two != s)){
                                        if(one != s && one != t && two != f && two != t){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }
                                }
                                one += 1
                            }
                            two += 1
                        }
                        three += 1
                    }
                }else if(Cblow == 1){
                    while three <= 9 {
                        two = 0
                        while two <= 9 {
                            one = 0
                            while one <= 9 {
                                if(one == f || two == s || three == t){
                                    if ((one == f) && (two != s && three != t)){
                                        if(((two == f || two == t) && (three != f && three != s)) || ((three == f || three == s) && (two != f && two != t))){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }else if((two == s) && (one != f && three != t)){
                                        if(((one == s || one == t) && (three != f && three != s)) || ((three == f || three == s) && (one != s && one != t))){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }else if((three == t) && (one != f && two != s)){
                                        if(((one == s || one == t) && (two != f && two != t)) || ((two == f || two == t) && (one != s && one != t))){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }
                                }
                                one += 1
                            }
                            two += 1
                        }
                        three += 1
                    }
                }else{
                    while three <= 9 {
                        two = 0
                        while two <= 9 {
                            one = 0
                            while one <= 9 {
                                if(one == f || two == s || three == t){
                                    if(one == f){
                                        if((two == f || two == t) && (three == f || three == s)){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }else if(two == s){
                                        if((one == s || one == t) && (three == f || three == s)){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }else if(three == t){
                                        if((one == s || one == t) && (two == f || two == t)){
                                            Nerrownum = String(three * 100 + two * 10 + one)
                                            koho += [Nerrownum]
                                        }
                                    }
                                }
                                one += 1
                            }
                            two += 1
                        }
                        three += 1
                    }
                }
            }else if(Chit == 2){
                while three <= 9 {
                    two = 0
                    while two <= 9 {
                        one = 0
                        while one <= 9 {
                            if(one == f){
                                if(two == s){
                                    if(three != f || three != s){
                                        Nerrownum = String(three * 100 + two * 10 + one)
                                        koho += [Nerrownum]
                                    }
                                }else if(three == t){
                                    if(two != f || two != t){
                                        Nerrownum = String(three * 100 + two * 10 + one)
                                        koho += [Nerrownum]
                                    }
                                }
                            }else if (two == s){
                                if(three == t){
                                    if(one != s || one != t){
                                        Nerrownum = String(three * 100 + two * 10 + one)
                                        koho += [Nerrownum]
                                    }
                                }
                            }
                            one += 1
                        }
                        two += 1
                    }
                    three += 1
                }
            }
        }else{
            print(koho[0])
            var a = koho.count - 1
            
            while a > 0{
                three = Int(koho[a])! / 100
                two = (Int(koho[a])! - three * 100) / 10
                one = (Int(koho[a])! - three * 100 - two * 10)
                if (one == two || one == three || two == three){
                    koho.remove(at: a)
                }
                a -= 1
            }
            
            
            
            
            a = koho.count - 1
            
            
            if(Chit == 0){
                if(Cblow == 0){
                    while a > 0{
                        three = Int(koho[a])! / 100
                        two = (Int(koho[a])! - three * 100) / 10
                        one = (Int(koho[a])! - three * 100 - two * 10)
                        if (one != f && one != s && one != t && two != f && two != s && two != t && three != f && three != s && three != t ){
                        }else{
                            koho.remove(at: a)
                        }
                        a -= 1
                    }
                    
                }else if(Cblow == 1){
                    while a > 0{
                        three = Int(koho[a])! / 100
                        two = (Int(koho[a])! - three * 100) / 10
                        one = (Int(koho[a])! - three * 100 - two * 10)
                        if (one == s || one == t || two == f || two == t || three == f || three == s ){
                            if(one == s || one == t){
                                if (two != f && two != t && three != f && three != s){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else if (two == f || two == t){
                                if (one != s && one != t && three != f && three != s){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else{
                                if (one != s && one != t && two != f && two != t){
                                }else{
                                    koho.remove(at: a)
                                }
                            }
                        }else{
                            koho.remove(at: a)
                        }
                        a -= 1
                    }
                    
                    
                }else if(Cblow == 2){
                    while a > 0{
                        three = Int(koho[a])! / 100
                        two = (Int(koho[a])! - three * 100) / 10
                        one = (Int(koho[a])! - three * 100 - two * 10)
                        if (one == s || one == t || two == f || two == t || three == f || three == s ){
                            if(one == s || one == t){
                                if (((two == f || two == t) && (three != f && three != s)) || ((three == f || three == s) && (two != f && two != t))){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else if(two == f || two == t){
                                if (((one == s || one == t) && (three != f && three != s)) || ((three == f || three == s) && (one != s && one != t))){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else{
                                if (((one == s || one == t) && (two != f && two != t)) || ((two == f || two == t) && (one != s && one != t))){
                                }else{
                                    koho.remove(at: a)
                                }
                            }
                            
                        }else{
                            koho.remove(at: a)
                        }
                        
                        a -= 1
                    }
                }else{
                    while a > 0{
                        three = Int(koho[a])! / 100
                        two = (Int(koho[a])! - three * 100) / 10
                        one = (Int(koho[a])! - three * 100 - two * 10)
                        if((one == s || one == t) && (two == f || two == t) && (three == f || three == s)){
                        }else{
                            koho.remove(at: a)
                        }
                        a -= 1
                    }
                }
            }else if (Chit == 1){
                if (Cblow == 0){
                    while a > 0{
                        three = Int(koho[a])! / 100
                        two = (Int(koho[a])! - three * 100) / 10
                        one = (Int(koho[a])! - three * 100 - two * 10)
                        if(one == f || two == s || three == t){
                            if ((one == f) && (two != s && three != t)){
                                if(two != f && two != t && three != f && three != s){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else if((two == s) && (one != f && three != t)){
                                if(one != s && one != t && three != f && three != s){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else if((three == t) && (one != f && two != s)){
                                if(one != s && one != t && two != f && two != t){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else{
                                koho.remove(at: a)
                            }
                        }else{
                            koho.remove(at: a)
                        }
                        a -= 1
                    }
                }else if(Cblow == 1){
                    while a > 0{
                        three = Int(koho[a])! / 100
                        two = (Int(koho[a])! - three * 100) / 10
                        one = (Int(koho[a])! - three * 100 - two * 10)
                        if(one == f || two == s || three == t){
                            if ((one == f) && (two != s && three != t)){
                                if(((two == f || two == t) && (three != f && three != s)) || ((three == f || three == s) && (two != f && two != t))){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else if((two == s) && (one != f && three != t)){
                                if(((one == s || one == t) && (three != f && three != s)) || ((three == f || three == s) && (one != s && one != t))){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else if((three == t) && (one != f && two != s)){
                                if(((one == s || one == t) && (two != f && two != t)) || ((two == f || two == t) && (one != s && one != t))){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else{
                                koho.remove(at: a)
                            }
                        }else{
                            koho.remove(at: a)
                        }
                        a -= 1
                    }
                }else{
                    while a > 0{
                        three = Int(koho[a])! / 100
                        two = (Int(koho[a])! - three * 100) / 10
                        one = (Int(koho[a])! - three * 100 - two * 10)
                        if(one == f || two == s || three == t){
                            if(one == f){
                                if((two == f || two == t) && (three == f || three == s)){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else if(two == s){
                                if((one == s || one == t) && (three == f || three == s)){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else if(three == t){
                                if((one == s || one == t) && (two == f || two == t)){
                                }else{
                                    koho.remove(at: a)
                                }
                            }else{
                                koho.remove(at: a)
                            }
                        }else{
                            koho.remove(at: a)
                        }
                        a -= 1
                    }
                }
            }else if(Chit == 2){
                while a > 0{
                    three = Int(koho[a])! / 100
                    two = (Int(koho[a])! - three * 100) / 10
                    one = (Int(koho[a])! - three * 100 - two * 10)
                    if(one == f){
                        if(two == s){
                            if(three != f && three != s){
                            }else{
                                koho.remove(at: a)
                            }
                        }else if(three == t){
                            if(two != f && two != t){
                            }else{
                                koho.remove(at: a)
                            }
                        }else{
                            koho.remove(at: a)
                        }
                    }else if (two == s){
                        if(three == t){
                            if(one != s && one != t){
                            }else{
                                koho.remove(at: a)
                            }
                        }else{
                            koho.remove(at: a)
                        }
                    }else{
                        koho.remove(at: a)
                    }
                    
                    a -= 1
                }
            }
            
            
        }
        
        
        
        return (Chit,Cblow)
    }
    
    
    
    
    
    
    
    func Nerrow(f: Int,s: Int,t: Int) -> (max: Int,min: Int,kei: Int){
        var kohosu = [koho.count - 1,koho.count - 1,koho.count - 1,koho.count - 1,koho.count - 1]
        var three = 0
        var two = 0
        var one = 0
        var a = 1
        
        while a < koho.count{//0-0
            three = Int(koho[a])! / 100
            two = (Int(koho[a])! - three * 100) / 10
            one = (Int(koho[a])! - three * 100 - two * 10)
            if (one != f && one != s && one != t && two != f && two != s && two != t && three != f && three != s && three != t ){
            }else{
                kohosu[0] -= 1
            }
            a += 1
        }
        a = 1
        
        while a < koho.count{//0-1
            three = Int(koho[a])! / 100
            two = (Int(koho[a])! - three * 100) / 10
            one = (Int(koho[a])! - three * 100 - two * 10)
            if (one == s || one == t || two == f || two == t || three == f || three == s ){
                if(one == s || one == t){
                    if (two != f && two != t && three != f && three != s){
                    }else{
                        kohosu[1] -= 1
                    }
                }else if (two == f || two == t){
                    if (one != s && one != t && three != f && three != s){
                    }else{
                        kohosu[1] -= 1
                    }
                }else{
                    if (one != s && one != t && two != f && two != t){
                    }else{
                        kohosu[1] -= 1
                    }
                }
            }else{
                kohosu[1] -= 1
            }
            a += 1
        }
        
        a = 1
        
        while a < koho.count{//0-2
            three = Int(koho[a])! / 100
            two = (Int(koho[a])! - three * 100) / 10
            one = (Int(koho[a])! - three * 100 - two * 10)
            if (one == s || one == t || two == f || two == t || three == f || three == s ){
                if(one == s || one == t){
                    if (((two == f || two == t) && (three != f && three != s)) || ((three == f || three == s) && (two != f && two != t))){
                    }else{
                        kohosu[2] -= 1
                    }
                }else if(two == f || two == t){
                    if (((one == s || one == t) && (three != f && three != s)) || ((three == f || three == s) && (one != s && one != t))){
                    }else{
                        kohosu[2] -= 1
                    }
                }else{
                    if (((one == s || one == t) && (two != f && two != t)) || ((two == f || two == t) && (one != s && one != t))){
                    }else{
                        kohosu[2] -= 1
                    }
                }
                
            }else{
                kohosu[2] -= 1
            }
            
            a += 1
        }
        
        a = 1
        
        while a < koho.count{//1-0
            three = Int(koho[a])! / 100
            two = (Int(koho[a])! - three * 100) / 10
            one = (Int(koho[a])! - three * 100 - two * 10)
            if(one == f || two == s || three == t){
                if ((one == f) && (two != s && three != t)){
                    if(two != f && two != t && three != f && three != s){
                    }else{
                        kohosu[3] -= 1
                    }
                }else if((two == s) && (one != f && three != t)){
                    if(one != s && one != t && three != f && three != s){
                    }else{
                        kohosu[3] -= 1
                    }
                }else if((three == t) && (one != f && two != s)){
                    if(one != s && one != t && two != f && two != t){
                    }else{
                        kohosu[3] -= 1
                    }
                }else{
                    kohosu[3] -= 1
                }
            }else{
                kohosu[3] -= 1
            }
            
            a += 1
        }
        a = 1
        
        while a < koho.count{//1-1
            three = Int(koho[a])! / 100
            two = (Int(koho[a])! - three * 100) / 10
            one = (Int(koho[a])! - three * 100 - two * 10)
            if(one == f || two == s || three == t){
                if ((one == f) && (two != s && three != t)){
                    if(((two == f || two == t) && (three != f && three != s)) || ((three == f || three == s) && (two != f && two != t))){
                    }else{
                        kohosu[4] -= 1
                    }
                }else if((two == s) && (one != f && three != t)){
                    if(((one == s || one == t) && (three != f && three != s)) || ((three == f || three == s) && (one != s && one != t))){
                    }else{
                        kohosu[4] -= 1
                    }
                }else if((three == t) && (one != f && two != s)){
                    if(((one == s || one == t) && (two != f && two != t)) || ((two == f || two == t) && (one != s && one != t))){
                    }else{
                        kohosu[4] -= 1
                    }
                }else{
                    kohosu[4] -= 1
                }
            }else{
                kohosu[4] -= 1
            }
            
            a += 1
        }
        
        
        
        
        
        
        
        a = kohosu.count - 1
        sum = 0
        var maxkohosu: [Int]
        var minkohosu: [Int]
        while a >= 0{
            if kohosu[a] <= 1{
                kohosu.remove(at: a)
            }
            a -= 1
        }
        a = 0
        if kohosu.count <= 2{
            maxkohosu = [1000,0]
            minkohosu = [500,0]
            sum = 1000
        }else{
            maxkohosu = kohosu.sorted { $0 > $1 }
            minkohosu = kohosu.sorted { $0 < $1 }
            while a < kohosu.count{
                sum += kohosu[a]
                a += 1
            }
        }
        
        
        
        return (maxkohosu[0],minkohosu[0],sum)
        
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
