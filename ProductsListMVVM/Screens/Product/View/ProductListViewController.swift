//
//  ProductListViewController.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 05/03/24.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var tabelView: UITableView!
    var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        print("ProductListViewController dinit")
    }

}

extension ProductListViewController {
    
    private func configuration() {
        tabelView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initialiseViewModel()
        observeEvent()
        //Setup Navigationbar
        navigationItem.backButtonTitle = ""
    }
    
    private func initialiseViewModel() {
        viewModel.fetchProduct()
    }
    
    private func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else {
                return
            }
            
            switch event {
            case .loading:
                print("Product loading...")
            case .stoploading:
                print("Stop loading...")
            case .loaded:
                print("Product loaded...")
                DispatchQueue.main.async {
                    self.tabelView.reloadData()
                }
            case .loadingError(let error):
                print(error ?? "error in loading")
            }
        }
    }
}

extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell,
              let cellModel = viewModel.productCell(at: indexPath) else {
            return UITableViewCell()
        }
        cell.configure(with: cellModel)
        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowselected(indexPath: indexPath)
    }
    
    private func rowselected(indexPath: IndexPath) {
        guard let model = viewModel.productCell(at: indexPath) else {
            return
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let prodcutDetailVC = storyBoard.instantiateViewController(identifier: "ProdcutDetailViewController") as! ProdcutDetailViewController
        prodcutDetailVC.configure(with: ProductDtailViewModel(product: model.product))
        navigationController?.pushViewController(prodcutDetailVC, animated: true)
    }
}
