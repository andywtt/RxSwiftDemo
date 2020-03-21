//
//  SubjectsController.swift
//  RxSwiftDemo_03_20
//
//  Created by Andy on 2020/3/21.
//  Copyright © 2020 FL SMART. All rights reserved.
//

import UIKit

class SubjectsController: UIViewController {
    
    // 先创建回收袋
    let disposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        // Subjects: 即是订阅者，也是序列（Observable）,可以动态的监听新的值，当Subject有新的值的时候，会发出Event事件，有四种方式
        // PublishSubject 是一个普通的Subject，不需要初始值就可以创建  发布/公布 订阅
        
        let subject = PublishSubject<String>()
        
        subject.onNext("被订阅的值：000000000000")
        
        subject.subscribe(
            onNext: { string in
                print("第一次订阅", string)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("完成订阅")
        }
        ).disposed(by: disposeBag)
        
        subject.onNext("被订阅的值：11111111111")
        
        subject.subscribe(
            onNext: { string in
                print("第二次订阅", string)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("完成订阅2")
        }
        ).disposed(by: disposeBag)
        
        subject.onNext("被订阅的值：222222222222")
        
        subject.onCompleted()
        
        subject.onNext("被订阅的值：333333333333")
        
        
        
        // BehaviorSubject  行为订阅，需要一个默认值来创建
        
        let behaviorSubject = BehaviorSubject(value: 1)
        
        behaviorSubject.subscribe { event in
            print("第一次订阅", event)
        }.disposed(by: disposeBag)
        
        behaviorSubject.onNext(2)
        
        
    }

}
