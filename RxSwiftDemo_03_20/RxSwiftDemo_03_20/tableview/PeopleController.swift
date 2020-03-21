//
//  PeopleController.swift
//  RxSwiftDemo_03_20
//
//  Created by Andy on 2020/3/21.
//  Copyright © 2020 FL SMART. All rights reserved.
//

import UIKit

class PeopleController: UIViewController {
    
    let peopleList = PeopleListModel()
    let disposeBage = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.frame = self.view.bounds
        tv.rowHeight = 60
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PeopleCell")
        peopleList.data.bind(to: tableView.rx.items(cellIdentifier: "PeopleCell")) { _, model, cell in
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = String(model.age)
        }.disposed(by: disposeBage)
        
        tableView.rx.modelSelected(PeopleModel.self).subscribe(onNext: { [weak self] people in
            let alertvc = UIAlertController(title: people.name, message: String(people.age), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertvc.addAction(okAction)
            self?.present(alertvc, animated: true, completion: nil)
        }).disposed(by: disposeBage)
    }

}
