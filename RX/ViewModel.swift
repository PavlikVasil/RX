//
//  ViewModel.swift
//  RX
//
//  Created by Павел on 7/30/20.
//  Copyright © 2020 Павел. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct ViewModel{
    let searchText = BehaviorRelay(value: " ")
    
    
    let APIProvider: APIprovider
    var data: Driver<[Repository]>
    
    init(APIProvider: APIprovider){
        self.APIProvider = APIProvider
        
        data = self.searchText.asObservable()
            .throttle(0.1, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
            .flatMapLatest{
                APIProvider.getRepositories($0)
        }.asDriver(onErrorJustReturn: [])
    }
}
