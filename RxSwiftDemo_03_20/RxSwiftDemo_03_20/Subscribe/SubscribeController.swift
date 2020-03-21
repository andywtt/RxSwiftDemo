//
//  SubscribeController.swift
//  RxSwiftDemo_03_20
//
//  Created by Andy on 2020/3/21.
//  Copyright © 2020 FL SMART. All rights reserved.
//

import UIKit

class SubscribeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        //MARK: 学习如何进行订阅
        
        let observableOf = Observable.of(1,3,4)
        
        observableOf.subscribe{
            event in
            print(event.element)
        }
        
        // 可以通过不同的block回调处理不同类型的event事件
        observableOf.subscribe(
            onNext: { event in
                print("这里的event已经是解包后的实际数据：\(event)")
            },
            onError: { error in
                print("如果有错误，会走这个监听通道：\(error)")
            },
            onCompleted: {
                print("onCompleted")
            },
            onDisposed: {
                print("onDisposed")
            }
        )
        
        
    }
    

}
