//
//  RootViewController.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/18.
//

import UIKit

private typealias RouteParameter = [String: Any?]

private typealias completion = (_ name:String) -> Void

class RootViewController: UIViewController {

    var _title: String?
    
    var dict: [String : Any] = [:]

    private var completion: completion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = _title
        
        self.view.backgroundColor = .red
        
        let button = UIButton(frame: CGRect(x: view.frame.width/2-60, y: view.frame.height/2-20, width: 120, height: 40))
        button.setTitle("pop", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(pop), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func pop() {
        self.navigationController?.popViewController(animated: true)
        dict = ["name":"返回数据"]
    }

}
