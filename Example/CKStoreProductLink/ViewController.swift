//
//  ViewController.swift
//  CKStoreProductLink
//
//  Created by kaich on 11/03/2016.
//  Copyright (c) 2016 kaich. All rights reserved.
//

import UIKit
import CKStoreProductLink
import SVProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var tfAppID: UITextField!
    
    @IBAction func showStore(_ sender: AnyObject) {

        ckst_open(itemID: tfAppID.text!, type: .outer) { (isOK,_) in
            if isOK == false {
                SVProgressHUD.showError(withStatus: "Apptore无此应用")
            }
        }
    }
    
    @IBAction func showInner(_ sender: AnyObject) {
        if let text = tfAppID.text {
            
            SVProgressHUD.show()
            ckst_open(itemID: text) { (isOK,_) in
                if isOK == false {
                    SVProgressHUD.showError(withStatus: "Apptore无此应用")
                }
                else {
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    
}

