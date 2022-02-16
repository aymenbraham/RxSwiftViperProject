//
//  CarteViewController.swift
//  ViperRxSwiftFirstApp
//
//  Created by aymen braham on 14/02/2022.
//

import UIKit

class CartViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    
    // MARK: Properties
    
    
    
    
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        
    }
    
    override func awakeFromNib() {
        
    }
    
    
    // MARK: SetUpView
    private func setUpView() {
        
    }
    
}

// MARK: TableView Delegate && DataSource
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
