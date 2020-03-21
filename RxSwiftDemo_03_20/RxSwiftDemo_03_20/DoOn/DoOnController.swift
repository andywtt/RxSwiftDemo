//
//  DoOnController.swift
//  RxSwiftDemo_03_20
//
//  Created by Andy on 2020/3/21.
//  Copyright © 2020 FL SMART. All rights reserved.
//

import UIKit

class DoOnController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        // doOn，是用来监听事件的生命周期的，它会在每一次事件发送前被调用。
        // doOn 和 subscribe 是一样的用法
        // do(onNext:) 会在 subscribe(onNext:)之前调用
        // do(onCompleted:) 会在 subscribe(onCompleted:) 之前t调用
        // 单独调用doOn 是不会响应的，在调用了doOn后，必须再订阅（subscribe）才可以正常执行
        var i = 0
        let observableDoOn = Observable.of(1,2,3,4,5,6)
        
        observableDoOn.do(
            onNext: { event in
                print("DoOn onNext:\(event)    ★★★★★★i = \(i)")
                i+=1
        },
            afterNext: { afterEvent in
                print("DoOn afterEvent:\(afterEvent)    ★★★★★★i = \(i)")
                i+=1
        },
            onError: { error in
                print("DoOn error:\(error)    ★★★★★★i = \(i)")
                i+=1
        },
            afterError: { afterError in
                print("DoOn afterError:\(afterError)    ★★★★★★i = \(i)")
                i+=1
        },
            onCompleted: {
                print("DoOn DoOnonCompleted    ★★★★★★i = \(i)")
                i+=1
        },
            afterCompleted: {
                print("DoOn afterCompleted    ★★★★★★i = \(i)")
                i+=1
        },
            onSubscribe: {
                print("DoOn onSubscribe    ★★★★★★i = \(i)")
                i+=1
        },
            onSubscribed: {
                print("DoOn onSubscribed    ★★★★★★i = \(i)")
                i+=1
        },
            onDispose: {
                print("DoOn onDispose    ★★★★★★i = \(i)")
                i+=1
        }
        ).subscribe(
            onNext: { event in
                print("subscribe onNext:\(event)    ★★★★★★i = \(i)")
                i+=1
        },
            onError: { error in
                print("subscribe onError:\(error)    ★★★★★★i = \(i)")
                i+=1
        },
            onCompleted: {
                print("subscribe onCompleted    ★★★★★★i = \(i)")
                i+=1
        },
            onDisposed: {
                print("subscribe onDisposed    ★★★★★★i = \(i)")
                i+=1
        }
        )
        
    }

}
