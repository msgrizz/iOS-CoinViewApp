//
//  MainSearchRouter.swift
//  Boilerplate
//
//  Created by MARCELO GRACIETTI on 23/01/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class MainSearchRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule() -> MainSearchViewController {
        
        let viewController = UIStoryboard.loadViewController() as MainSearchViewController
        
        let presenter = MainSearchPresenter()
        let router = MainSearchRouter()
        let interactor = MainSearchInteractor()
        
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
}


extension MainSearchRouter: MainSearchWireframe {
    // TODO: Implement wireframe methods
}
