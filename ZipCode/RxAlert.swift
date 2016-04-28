//
//  RxAlert.swift
//  ZipCode
//
//  Created by Takanori Hoshi on 2016/04/28.
//  Copyright © 2016 Hoshi Takanori. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController {
    func inputFor(alert: UIAlertController, ok: String, cancel: String) -> Observable<String> {
        return Observable.create { [unowned self] observer in
            alert.addTextFieldWithConfigurationHandler(nil)
            alert.addAction(UIAlertAction(title: cancel, style: .Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: ok, style: .Default) { _ in
                if let text = alert.textFields?.first?.text {
                    observer.on(.Next(text))
                }
            })

            self.presentViewController(alert, animated: true, completion: nil)

            return AnonymousDisposable {
                alert.dismissViewControllerAnimated(false, completion: nil)
            }
        }
    }
}
