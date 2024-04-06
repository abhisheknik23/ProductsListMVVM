//
//  ProdcutDetailViewController.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 17/03/24.
//

import UIKit

class ProdcutDetailViewController: UIViewController {

    var viewModel: ProductDtailViewModel?
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private func buildUI() {
        //Setup TableView
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailTableViewCell")
        view.addSubview(tableView)
        
        //Setup Navigationbar
        navigationItem.backButtonTitle = ""
    }
    
    deinit {
        print("Detail VC dinit")
    }

}

extension ProdcutDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell") as? ProductDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: ProductDtailViewModel(product: viewModel?.product))
        return cell
    }
    
}

extension ProdcutDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension ProdcutDetailViewController: Configurable {
    
    typealias ModelType = ProductDtailViewModel
    func configure(with model: ProductDtailViewModel) {
        viewModel = model
    }
    
}
