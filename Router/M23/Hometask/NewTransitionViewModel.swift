//
//  NewTransitionViewModel.swift
//  M23
//
//  Created by Nor1 on 17.06.2022.
//

import Foundation

class NewTransitionViewModel {
    typealias Routes = NewTransitionRoute
    private let router: Routes

    init(router: Routes) {
            self.router = router
        }
    func tapped(){
        router.openNewTransition()
    }
    
}
