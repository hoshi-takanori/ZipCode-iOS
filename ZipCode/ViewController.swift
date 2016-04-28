//
//  ViewController.swift
//  ZipCode
//
//  Created by Hoshi Takanori on 2016/04/24.
//  Copyright © 2016 Hoshi Takanori. All rights reserved.
//

import UIKit
import APIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var reactiveButton: UIButton!
    @IBOutlet weak var textView: UITextView!

    var text: String = "" {
        didSet {
            self.textView.text = text
        }
    }

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        reactiveButton.addTarget(self, action: #selector(start), forControlEvents: .TouchUpInside)
    }

    @IBAction func start() {
        let alert = UIAlertController(title: "Zip Code", message: nil, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler(nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { action in
            let textField = alert.textFields![0] as UITextField
            self.query(textField.text ?? "")
        })
        presentViewController(alert, animated: true, completion: nil)
    }

    func query(zipCode: String) {
        text = "zipCode = \(zipCode)"
        let request = ZipCodeRequest(zipCode: zipCode)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            Session.sendRequest(request) { result in
                self.text += "\n\nresult = \(result)"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
