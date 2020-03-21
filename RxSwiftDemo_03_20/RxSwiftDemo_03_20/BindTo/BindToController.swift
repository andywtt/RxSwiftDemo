//
//  BindToController.swift
//  RxSwiftDemo_03_20
//
//  Created by Andy on 2020/3/21.
//  Copyright © 2020 FL SMART. All rights reserved.
//

import UIKit

class BindToController: UIViewController {
    
    private lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    let disposeBag = DisposeBag()// 创建垃圾袋，方便自动回收
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stepLabel)
        
        stepLabel.snp.makeConstraints { (make) in
            make.width.height.equalTo(view)
        }
        
        // 创建 观察者，当值有改变时，更新label内容。AnyObserver 是所有场景都可以使用
        let observer: AnyObserver<String> = AnyObserver { [weak self] event in
            switch event {
            case .next(let text):
                self?.stepLabel.text = text
            default:
                break
            }
        }
        
        let observableInterval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observableInterval
        .map { "当前索引1：\($0)" }
        .bind(to: observer)
        .disposed(by: disposeBag)
        
        // Binder 用于特定场景
        // 1. 不会处理错误事件
        // 2. 确保绑定都是在给定的 线程(Schedule) 上执行的，默认在主线程
        
        let binderServer: Binder<String> = Binder(stepLabel) {
            (lab, text) in
            lab.text = text
        }
        
        let observableInterval2 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observableInterval2
            .map{"当前索引2：\($0)"}
        .bind(to: binderServer)
        .disposed(by: disposeBag)
        
        // 同一时间只能被一个观察者进行绑定。后面绑定的会覆盖前面的。
        
    }

}
