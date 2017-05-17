
public enum CKSPLinkType {
    case inner , outer
}

extension UIViewController {
    
    /// 在应用内打开App Store相关应用页面
    ///
    /// - parameter itemID:        应用id
    /// - parameter type:          应用内打开还是直接跳转Apptore
    /// - parameter completeBlock: 完成回调,第一个Bool指示该应用是否存在，第二个Bool指示是否跳转完成
    public func ckst_open(itemID :String, type :CKSPLinkType = .inner, completeBlock :((Bool,Bool) -> Void)? = nil) {
        CKStoreProductLink.shared.open(itemID: itemID, in: self, type: type, completeBlock: completeBlock)
    }

}

typealias CKSPLCompleteHandler = ((Bool,Bool) -> Void)
class CKStoreProductLink : NSObject {
    static var shared = CKStoreProductLink()
    
    var targetViewController :UIViewController! = nil
    var itemID :String = ""
    var completeBlock :CKSPLCompleteHandler?
    var didCanceledBlock :((Void) -> Void)?
    
    func open(itemID :String, in container :UIViewController, type :CKSPLinkType, completeBlock :CKSPLCompleteHandler?) {
        self.targetViewController = container
        self.itemID = itemID
        self.completeBlock = completeBlock
        
        lookupItem(itemID: itemID) { (isOK,isFinished) in
            
            if isOK == false {
                if let completeBlock = completeBlock {
                    completeBlock(false,false)
                }
            }
            else {
                
                if type == .inner {
                    let selector = NSSelectorFromString("presentInnerApp")
                    if self.responds(to: selector) {
                        self.perform(selector)
                    }
                    else {
                        fatalError("You must input pod 'CKStoreProductLink' rather than pod 'CKStoreProductLink/Outer' in Podfile")
                    }
                }
                else {
                    self.jumpOuterApp()
                }
            }
        }
    }
    
    //由于这个接口不是很准确，暂时注释（989673964 王者荣耀，Appstore里面有，但是这个接口查询不到)
    func lookupItem(itemID :String, completeBlock :CKSPLCompleteHandler?) {
//        let urlString = "https://itunes.apple.com/lookup?id=" + itemID
//        if let url = URL(string: urlString) {
//            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//                var isExist = false
//                if let data = data {
//                    do {
//                        if let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] {
//                            if let results = jsonObject["results"] as? [Any] {
//                                if results.count > 0 {
//                                   isExist = true
//                                }
//                            }
//                        }
//                    } catch {
//                       NSLog("parse json error : \(error)")
//                    }
//                }
//                if let completeBlock = completeBlock {
//                    completeBlock(isExist,false)
//                }
//            }
//            task.resume()
//        }

        if let completeBlock = completeBlock {
            completeBlock(true,false)
        }
        
    }
    
    func jumpOuterApp() {
        if let url = URL(string: "https://itunes.apple.com/app/id\(itemID)") {
            if UIApplication.shared.canOpenURL(url) {
                let isOK = UIApplication.shared.openURL(url)
                if let completeBlock = self.completeBlock {
                    completeBlock(true,isOK)
                }
            }
        }
    }

}


