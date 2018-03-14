//
//  MainSearchContract.swift
//  Boilerplate
//
//  Created by MARCELO GRACIETTI on 23/01/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import Foundation


protocol MainSearchView: BaseView {
    
}

protocol MainSearchPresentation: class {
    func doSomething()
}

protocol MainSearchUseCase: class {
    
}

protocol MainSearchInteractorOutput: class {
    func onFetchProductsFailure(message: String)
}

protocol MainSearchWireframe: class {
    
}
