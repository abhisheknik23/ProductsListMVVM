//
//  ProductDetailTableViewCell.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 17/03/24.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    var viewModel: ProductDtailViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateUI() {
        titleLabel.text = viewModel?.product?.title
        productDescription.text = viewModel?.product?.description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ProductDetailTableViewCell: Configurable {
    
    typealias ModelType = ProductDtailViewModel
    
    func configure(with model: ProductDtailViewModel) {
        viewModel = model
        updateUI()
    }
    
    
}

