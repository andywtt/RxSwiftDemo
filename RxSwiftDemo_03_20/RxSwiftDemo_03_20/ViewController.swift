//
//  ViewController.swift
//  RxSwiftDemo_03_20
//
//  Created by Andy on 2020/3/20.
//  Copyright © 2020 FL SMART. All rights reserved.
//

import UIKit

struct DataModel {
    let name: String?
    let vcName: AnyObject?
    init(name: String?, vcName: AnyObject?) {
        self.name = name
        self.vcName = vcName
    }
}

/// 创建一个数据模型，用于存放cell数据
struct DataListModel {
    let data = Observable.just([
        DataModel(name: "TableView", vcName: PeopleController()),
        DataModel(name: "Observable", vcName: ObservableController()),
        DataModel(name: "Subscribe", vcName: SubscribeController()),
        DataModel(name: "DoOn", vcName: DoOnController()),
        DataModel(name: "Disposed", vcName: DisposedController()),
        DataModel(name: "BindTo", vcName: BindToController()),
        DataModel(name: "UI Extension", vcName: UIExtensionController()),
        DataModel(name: "Subjects", vcName: SubjectsController()),
    ])
    
}


class ViewController: UIViewController {
    
    /// 先定义垃圾袋
    let disposeBag = DisposeBag()
    
    let dataList = DataListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        // 先注册tableview的cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // 把listd数据绑定到tableview
        dataList.data.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { _, model, cell in
            cell.textLabel?.text = model.name
        }.disposed(by: disposeBag)
        
        // 监听tableview 模型选择，根据选择的模型做不同的事件处理
        tableView.rx.modelSelected(DataModel.self).subscribe(onNext: { [weak self] model in
            self?.navigationController?.pushViewController(model.vcName as! UIViewController, animated: true)
        }).disposed(by: disposeBag)
    }

    private lazy var tableView: UITableView = {
        let tabv = UITableView()
        tabv.frame = self.view.bounds
        tabv.rowHeight = 60
        return tabv
    }()
    
}

extension UIViewController {
    
    /// 根据控制的名字字符串，初始化控制器
    /// - Parameter className: 控制器的名字
    public func classFromString(className: String) -> UIViewController {
        // 1. 获取命名空间
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            return UIViewController.init()
        }
        
        // 2. 通过命名空间l和类名转换成类
        let cls: AnyClass? = NSClassFromString((clsName as! String) + "." + className)
        
        // 3. swift 中通过Class 创建一个对象，必须告诉系统Class的类型
        guard let clsType = cls as? UIViewController.Type else {
            return UIViewController.init()
        }
        
        return clsType.init()
    }
}

