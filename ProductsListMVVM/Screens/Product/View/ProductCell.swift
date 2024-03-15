//
//  ProductCell.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 05/03/24.
//

import UIKit

class ProductCell: UITableViewCell {


    @IBOutlet weak var productBgView: UIView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var productImage: UIImageView!
    
    var viewModel: ProductCellViewModel?
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productBgView.clipsToBounds = false
        productBgView.layer.cornerRadius = 15
        productImage.layer.cornerRadius = 10
        
        productBgView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        guard let viewModel else {
            return
        }
        productTitle.text = viewModel.productTitle
        productCategory.text = viewModel.category
        productDescription.text = viewModel.description
        productPrice.text = "$\(viewModel.price)"
        rateButton.setTitle("\(viewModel.rating ?? 0)", for: .normal)
        productImage.setImage(with: viewModel.image)
    }
    
}

extension ProductCell: Configurable {
    func configure(with model: ProductCellViewModel) {
        viewModel = model
        configureCell()
    }
}
