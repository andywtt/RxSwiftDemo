//
//  DisposedController.swift
//  RxSwiftDemo_03_20
//
//  Created by Andy on 2020/3/21.
//  Copyright © 2020 FL SMART. All rights reserved.
//

import UIKit

class DisposedController: UIViewController {

    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let observableOf = Observable.of(1,2,3,4,5,6)
        
        let sub = observableOf.subscribe { event in
            print(event)
        }
        
        sub.dispose() // 手动释放
        sub.disposed(by: disposeBag) // 自动释放
    }

}
