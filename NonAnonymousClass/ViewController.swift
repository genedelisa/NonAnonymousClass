//
//  ViewController.swift
//  NonAnonymousClass
//
//  Created by Gene De Lisa on 7/13/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit


protocol SimpleProtocol {
    func didReceiveResults(s: [String]) -> Void
}

class ViewController: UIViewController {
    
    var resp:NonAnon = NonAnon()
    
    var someString = "Some String"
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.frob("nonanon", delegate:resp)

        // cannot do these closures
        
//        var handler:SimpleProtocol = { (s:[String]) -> Void in
//            for str in s {
//                println(str)
//            }
//        }
        
//        frob("hi") { (a:[String]) in
//            
//        }
//        
//        frob("hi")  {
//            
//        }

        
        var handler:SimpleProtocol = resp
        self.frob("handler", delegate:handler)
        // self.frob("handler", delegate:resp)

        
        handler = NonAnonDelegate(c: self)
        self.frob("delegate", delegate:handler)
        
        class NestedNonAnonDelegate:SimpleProtocol {
            var vc:ViewController?
            
            init(c:ViewController) {
                self.vc = c
            }
            
            func didReceiveResults(s: [String]) -> Void {
                println(s)
                for str in s {
                    println(str)
                }
                vc?.blob()
                // blows up XCode
                //blob()
               // println(someString)
            }
            
        }
        
        handler = NestedNonAnonDelegate(c: self)
        self.frob("nested delegate", delegate:handler)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func frob(s:String, delegate: SimpleProtocol) {
        println(s)
        delegate.didReceiveResults(["foo", "bar"])
    }
    
    func blob() {
        println("blob")
    }
}


class NonAnonDelegate:SimpleProtocol {
    var vc:ViewController?

    init(c:ViewController) {
        self.vc = c
    }
    
    func didReceiveResults(s: [String]) -> Void {
        println(s)
        for str in s {
            println(str)
        }
        vc?.blob()
    }
    
}


class NonAnon:SimpleProtocol {
    func didReceiveResults(s: [String]) -> Void {
        println(s)
        for str in s {
            println(str)
        }
    }
    
}