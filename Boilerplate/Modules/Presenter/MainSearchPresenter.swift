//
//  MainSearchPresenter.swift
//  Boilerplate
//
//  Created by MARCELO GRACIETTI on 23/01/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import Foundation


class MainSearchPresenter {
    
    // MARK: Properties
    
    weak var view: MainSearchView?
    var router: MainSearchWireframe?
    var interactor: MainSearchUseCase?
    
}

extension MainSearchPresenter: MainSearchPresentation {
    func showCoinDetail(_ coinAttributes: CoinAttributes) {
        router?.showCoinDetail(coinAttributes)
    }
    
    func retrieveCoins() {
        view?.showLoading()
        interactor?.retrieveCoins()
    }
    
    
    func doSomething() {
        view?.showMessage("I'm doing something!!", withTitle: "Hey")
    }
    
    //TODO: Implement other methods from presenter->view here
    
}

extension MainSearchPresenter: MainSearchInteractorOutput {
    func onFetchCoins(mCoins: [CoinAttributes], error: String?) {
        view?.hideLoading()
        view?.updateCoinTable(mCoins: mCoins)
    }
    
    
    func onFetchProductsFailure(message: String) {
        view?.hideLoading()
        view?.showError(message)
    }
    
}
