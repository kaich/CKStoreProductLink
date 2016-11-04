import StoreKit


extension UIViewController {
    
    
    /// 跳转到App Store打开指定应用页面
    ///
    /// - parameter url:           应用路径
    /// - parameter completeBlock: 完成回调
    public func ckst_open(url :URL, completeBlock :((Bool) -> Void)?) {
        if UIApplication.shared.canOpenURL(url) {
            let isOK = UIApplication.shared.openURL(url)
            if let completeBlock = completeBlock {
                completeBlock(isOK)
            }
        }
    }
    
    
    /// 在应用内打开App Store相关应用页面
    ///
    /// - parameter itemID:        应用id
    /// - parameter completeBlock: 完成回调
    public func ckst_open(itemID :String, completeBlock :((Bool) -> Void)?) {
        CKStoreProductLink.shared.open(itemID: itemID, in: self, completeBlock: completeBlock)
    }

}


class CKStoreProductLink : NSObject, SKStoreProductViewControllerDelegate {
    static var shared = CKStoreProductLink()
    
    var targetViewController :UIViewController! = nil
    var itemID :String!
    var completeBlock :((Bool) -> Void)?
    
    func open(itemID :String, in container :UIViewController, completeBlock :((Bool) -> Void)?) {
        self.targetViewController = container
        self.itemID = itemID
        self.completeBlock = completeBlock
        
        lookupItem(itemID: itemID) { (isOK) in
            self.requestFinish(isSuccessful: isOK)
        }
    }
    
    func lookupItem(itemID :String, completeBlock :((Bool) -> Void)?) {
        let urlString = "https://itunes.apple.com/lookup?id=" + itemID
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                var isExist = false
                if let data = data {
                    do {
                        if let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] {
                            if let results = jsonObject["results"] as? [Any] {
                                if results.count > 0 {
                                   isExist = true
                                }
                            }
                        }
                    } catch {
                       NSLog("parse json error : \(error)")
                    }
                }
                if let completeBlock = completeBlock {
                    completeBlock(isExist)
                }
            }
            task.resume()
        }
        
    }
    
    func requestFinish(isSuccessful :Bool) {
        if isSuccessful == false {
            if let completeBlock = completeBlock {
                completeBlock(false)
            }
        }
        else {
            let storeVC = SKStoreProductViewController()
            storeVC.delegate = self
            storeVC.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier : itemID]) { (isOK, error) in
                if let completeBlock = self.completeBlock {
                    completeBlock(isOK)
                }
            }
            targetViewController.present(storeVC, animated: true, completion: nil)
        }
    }
    
    //MARK: - SKStoreProductViewControllerDelegate
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        targetViewController.dismiss(animated: true, completion: nil)
    }
    
}
