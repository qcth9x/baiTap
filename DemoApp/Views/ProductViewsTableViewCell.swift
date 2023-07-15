//
//  ProductViewsTableViewCell.swift
//  DemoApp
//
//  Created by Lê Đình Linh on 08/07/2023.
//

import UIKit

class ProductViewsTableViewCell: UITableViewCell {

    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        sender.backgroundColor = UIColor.red
    }

    @IBOutlet weak var AvataSanPham: UIImageView!
    @IBOutlet weak var lblSizeC: UILabel!
    @IBOutlet weak var lblSizeB: UILabel!
    @IBOutlet weak var lblSizeA: UILabel!
    @IBOutlet weak var lblTenSanPham: UILabel!
    @IBOutlet weak var lblDanhGia: UILabel!
    @IBOutlet weak var lblGia: UILabel!
    @IBOutlet weak var lblTenShop: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
}
