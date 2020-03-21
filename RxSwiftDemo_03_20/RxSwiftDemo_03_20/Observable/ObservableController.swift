//
//  ObservableController.swift
//  RxSwiftDemo_03_20
//
//  Created by Andy on 2020/3/21.
//  Copyright © 2020 FL SMART. All rights reserved.
//

import UIKit

enum myError: Error {
    case errorA
    case errorB
}

class ObservableController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //MARK: 如何创建序列的方法
        
        // 1. just() 需要一个初始值，可以用来初始化一个序列，可以不需要指定类型，由系统自行判断
        let observableJust = Observable.just("a")
        print(observableJust)
        
        // 2. of() 这个方法可以接受可变的数量的参数（注意：一定要是同类型）
        let observableOf = Observable.of("a", "b", "c")
        print(observableOf)
        
        // 3. from() 创建一个数组
        let observableFrom = Observable.from(["1", "2", "3"])
        print(observableFrom)
        
        // 4. empty() 创建一个空内容的序列，必须指定类型
        let observableEmpty = Observable<Int>.empty()
        print(observableEmpty)
        
        // 5. never() 创建一个永远不会发出event，也不会终止的观察者，必须指定类型
        let observableNever = Observable<String>.never()
        print(observableNever)
        
        // 6. error() 创建一个错误的序列，必须要指定类型
        let observableError = Observable<Int>.error(myError.errorA)
        print(observableError)
        
        // 7. range() 创建一个范围序列
        let observableRange = Observable.range(start: 1, count: 10)
        print(observableRange)
        
        // 8. repeatElement() 无限发出给定元素的event（永不终止）
        let observableRepeatElement = Observable.repeatElement(1)
        print(observableRepeatElement)
        
        // 9. generate() 判断条件都位true时，才会执行序列
        let observableGenerate = Observable.generate(initialState: 0, condition: { $0 <= 10}, iterate: { $0 + 2})
        print(observableGenerate)
        
        // 10. create() 这个方法接收一个block形式的参数，会对每一个订阅的做一个处理，必须指定类型
        let observableCreate = Observable<String>.create { ob in
            ob.onNext("发出事件")
            ob.onCompleted()
            // 因为订阅行为会有一个 Disposebles 的返回值，所以在结尾必须要return一个Disposebles.create()
            return Disposables.create { }
        }
        
        
        // 11. deferred() 创建的是一个工厂模式
        var isOdd = true
        let observableDeferred:Observable<Int> = Observable.deferred {
            isOdd = !isOdd
            if isOdd {
                return Observable.of(1,3,5,7)
            } else {
                return Observable.of(2,4,6,8)
            }
        }
        
        // 第一次订阅
        observableDeferred.subscribe{
            event in
            print("第一次订阅: \(isOdd)", event)
        }
        
        // 第二次订阅
        observableDeferred.subscribe{
            event in
            print("第二次订阅: \(isOdd)", event)
        }
        
        // 12. interval() 在指定时间内，发出一个元素，然后重复发出，必须指定类型
        let observableInterval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        observableInterval.subscribe{
            event in
            print("在指定时间内，发出一个元素，然后重复发出，必须指定类型:\(event)")
        }
        
        // 13. timer() 创建一个经过设定的时间后，产生唯一的元素
        let observableTimer = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
        observableTimer.subscribe {
            event in
            print("间隔5秒后发出的事件:\(event)")
        }
        
        let observableTimer2 = Observable<Int>.timer(2, period: 4, scheduler: MainScheduler.instance)
        observableTimer2.subscribe { event in
            print("这是从2秒之后，再每间隔4秒，在主线程发送一次事件：\(event)")
            
        }
        
    }
    

}
