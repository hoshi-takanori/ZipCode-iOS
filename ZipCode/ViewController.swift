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

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var textView: UITextView!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        startButton.addTarget(self, action: #selector(start), forControlEvents: .TouchUpInside)
    }

    func start() {
        let request = ZipCodeRequest(zipCode: "100-0001")
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let result):
                self.textView.text = "Success: \(result)"
            case .Failure(let error):
                self.textView.text = "Failure: \(error)"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
