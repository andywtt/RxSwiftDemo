//
//  UIExtensionController.swift
//  RxSwiftDemo_03_20
//
//  Created by Andy on 2020/3/21.
//  Copyright © 2020 FL SMART. All rights reserved.
//

import UIKit

class UIExtensionController: UIViewController {
    let disposeBag = DisposeBag()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "UILable"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.width.height.equalTo(view)
        }
        
        let observableInterval = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observableInterval
        .map { CGFloat($0) }
//        .bind(to: label.fontSize) // 非RX方式扩展
            .bind(to: label.rx.fontSize) // RX 方式的扩展，优先使用这样方式
        .disposed(by: disposeBag)
        
    }

}

// 常规扩展1
extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self) { lable, fontSize in
            lable.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
