//
//  ViewController.swift
//  ZipCode
//
//  Created by Hoshi Takanori on 2016/04/24.
//  Copyright © 2016 Hoshi Takanori. All rights reserved.
//

import UIKit
import APIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Run", style: .Plain, target: self, action: #selector(run))
    }

    func run() {
        let request = ZipCodeRequest(zipCode: "100-0001")
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let result):
                print("Success: \(result)")
            case .Failure(let error):
                print("Failure: \(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
