//
//  MainSearchPresenter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 23/01/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


class MainSearchPresenter {
    
    // MARK: Properties
    
    weak var view: MainSearchView?
    var router: MainSearchWireframe?
    var interactor: MainSearchUseCase?
    
}

extension MainSearchPresenter: MainSearchPresentation {
    func saveCoin(_ coin: CoinAttributes) {
        coin.id = String(Int(NSDate().timeIntervalSince1970))
        interactor?.saveCoin(coin)
    }
    
    func showCoinDetail(_ coinAttributes: CoinAttributes) {
        router?.showCoinDetail(coinAttributes)
    }
    
    func retrieveCoins() {
        view?.showLoading()
        interactor?.retrieveCoins()
    }
    
    //TODO: Implement other methods from presenter->view here
    
}

extension MainSearchPresenter: MainSearchInteractorOutput {
    func onCoinSaved(coins: [CoinAttributes]) {
//        interactor?.retrieveCoins()
    }
    
    func showMessage(message: String, title: String) {
        view?.hideLoading()
        view?.showMessage(message, withTitle: title)
    }
    
    func onFetchCoins(mCoins: [CoinAttributes], error: String?) {
        view?.hideLoading()
        view?.updateCoinTable(mCoins: mCoins)
    }
    
    func onFetchProductsFailure(message: String) {
        view?.hideLoading()
        view?.showError(message)
    }
    
    
    
}
