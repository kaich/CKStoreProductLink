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
        if let text = tfAppID.text {
            if text.hasPrefix("http") {
                if let url = URL(string:text) {
                    ckst_open(url: url, completeBlock: nil)
                }
            }
            else {
                SVProgressHUD.show()
                ckst_open(itemID: tfAppID.text!) { (isOK) in
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
}

