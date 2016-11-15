//
//  CKStoreProductLink+Inner.swift
//  Pods
//
//  Created by mac on 16/11/15.
//
//

import Foundation
import StoreKit

extension CKStoreProductLink : SKStoreProductViewControllerDelegate {
    
    func presentInnerApp() {
        
        let storeVC = SKStoreProductViewController()
        storeVC.delegate = self
        storeVC.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier : itemID]) { (isOK, error) in
            if let completeBlock = self.completeBlock {
                completeBlock(true,isOK)
            }
        }
        targetViewController.present(storeVC, animated: true, completion: nil)
    }
    
    
    //MARK: - SKStoreProductViewControllerDelegate
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        targetViewController.dismiss(animated: true, completion: nil)
    }
    
}
