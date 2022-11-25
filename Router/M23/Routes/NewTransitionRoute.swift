//
//  NewTransitionRoute.swift
//  M23
//
//  Created by Nor1 on 17.06.2022.
//

import UIKit

protocol NewTransitionRoute {
    func makeNewTransitionList() -> UIViewController
    func openNewTransition()
}

extension NewTransitionRoute where Self: Router {
    
    func makeNewTransitionList() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = NewTransitionViewModel(router: router)
        let viewController = NewTransitionViewController(viewModel: viewModel)
        router.root = viewController

        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: "New Transition", image: nil, tag: 1)
        return navigation
    }
    
    func openNewTransition(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = LoginViewModel(router: router)
        let viewController = LoginViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController

        route(to: navigationController, as: transition)
    }

    func openNewTransition() {
        openNewTransition(with: AnimatedTransition(animatedTransition: NewTransition()))
    }
}

extension DefaultRouter: NewTransitionRoute {}
