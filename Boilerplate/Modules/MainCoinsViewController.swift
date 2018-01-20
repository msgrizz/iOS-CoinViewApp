//
//  MainSearchViewController.swift
//  Boilerplate
//
//  Created by MARCELO GRACIETTI on 23/01/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import UIKit
import Nuke

class MainSearchViewController: BaseViewController, StoryboardLoadable, UITableViewDelegate, UITableViewDataSource {
  
    
    var manager = Nuke.Manager.shared
    var mCoins : [CoinAttributes] = []
    // MARK: Properties
    
    var presenter: MainSearchPresentation?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        self.mTableView.allowsMultipleSelection = false
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        setupView()
        hideKeyboardWhenTappedAround()
        presenter?.retrieveCoins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardNotifications(with: scrollView)
    }
    
    override func viewWillDisappear(_ animated: Bool) { 
        super.viewDidDisappear(animated)
        removeKeyboardNotification()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as! mTableViewCell
        cell.coinAttributes = self.mCoins[indexPath.row]
            if(self.mCoins[indexPath.row].logoUrl != nil){
                let url = URL(string: self.mCoins[indexPath.row].logoUrl!)
                cell.coinLogoImageView.image = nil
                self.manager.loadImage(with: url!, into: cell.coinLogoImageView)
            }
        cell.coinTitleLabel.text = mCoins[indexPath.row].marketCurrencyLong
        cell.coinReferenceLabel.text = "Ref.: \(mCoins[indexPath.row].baseCurrencyLong!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let coinAttribute: CoinAttributes = mCoins[indexPath.row] {
            presenter?.showCoinDetail(coinAttribute)
        }
    }
    
    
    
    
    // MARK: IBActions
    
  
    @IBAction func refreshCoins(_ sender: Any) {
        presenter?.retrieveCoins()
    }
    
    // MARK: Private
    
    private func setupView() {
        // TODO: Setup view here
    }

    
    func moveToNextField(_ view: UIView, nextFieldTag: Int) {
        let nextResponder = view.superview?.viewWithTag(nextFieldTag) as UIResponder!
        if (nextResponder != nil) {
            nextResponder?.becomeFirstResponder()
        } else {
            view.resignFirstResponder()
        }
    }
 
}

extension  MainSearchViewController: MainSearchView {
    func updateIndicator(state: Bool) {
        if state {
            self.progressIndicator.isHidden = false
            self.progressIndicator.startAnimating()
        }else{
            self.progressIndicator.isHidden = true
            self.progressIndicator.stopAnimating()
        }
    }
    
    func updateCoinTable(mCoins: [CoinAttributes]) {
        self.mCoins = mCoins
        self.mCoins.sort { (first, next) -> Bool in
            return first.marketCurrencyLong!.compare(next.marketCurrencyLong!) == .orderedAscending
        }
        
        DispatchQueue.main.async() {
            self.mTableView.reloadData()
            self.mTableView.tableFooterView = UIView(frame: .zero)
        }
        
    }
    
    
    //TODO: Implement MainSearchView methods here
    
    
}
