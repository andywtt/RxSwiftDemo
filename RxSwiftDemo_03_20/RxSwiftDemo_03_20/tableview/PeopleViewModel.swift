//
//  PeopleViewModel.swift
//  RxSwiftDemo_03_20
//
//  Created by Andy on 2020/3/21.
//  Copyright © 2020 FL SMART. All rights reserved.
//

import Foundation
import RxSwift

struct PeopleListModel {
    // 初始化 一些 假数据
    let data = Observable.just([
        PeopleModel(name: "张三", age: 18),
        PeopleModel(name: "李四", age: 28),
        PeopleModel(name: "王五", age: 38),
        PeopleModel(name: "早六", age: 48),
    ])
    
}
