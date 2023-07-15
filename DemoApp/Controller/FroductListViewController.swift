//
//  FroductListViewController.swift
//  DemoApp
//
//  Created by Lê Đình Linh on 08/07/2023.
//

import UIKit
import Kingfisher

class FroductListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tbnFroductList: UITableView!
    var froductList: [FroductListResponseModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tbnFroductList.register(UINib(nibName: "ProductViewsTableViewCell", bundle: nil), forCellReuseIdentifier: "productListIdentifier")
        tbnFroductList.delegate = self
        tbnFroductList.dataSource = self
        // Set frame for tableView
        tbnFroductList.frame = view.bounds
        view.addSubview(tbnFroductList)
    }

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return froductList.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "productListIdentifier", for: indexPath) as! ProductViewsTableViewCell
            let froduct = froductList[indexPath.row]
            cell.lblTenShop.text = froduct.shopName
            cell.lblTenSanPham.text = froduct.productName
            cell.lblGia.text = froduct.productPice
            cell.lblDanhGia.text = froduct.danhGia
            cell.lblSizeA.text = froduct.sizeA
            cell.lblSizeB.text = froduct.sizeB
            cell.lblSizeC.text = froduct.sizeC
            let avtURL = URL(string: froduct.avatar)
            cell.AvataSanPham.kf.setImage(with: avtURL)
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
    }

    class FroductListTabBarController: UITabBarController {
        
        var froductList: [FroductListResponseModel] = []
        let numberOfCellsPerTableView = 10
        
        override func viewDidLoad() {
            super.viewDidLoad()
            callAPIGetFroductList()
        }
        
        func callAPIGetFroductList() {
            APIHandler.init().getFroductList { froductListResponse in
                self.froductList = froductListResponse
                let numberOfTabs = Int(ceil(Double(self.froductList.count) / Double(self.numberOfCellsPerTableView)))
                for index in 0..<numberOfTabs {
                    let startIndex = index * self.numberOfCellsPerTableView
                    let endIndex = min(startIndex + self.numberOfCellsPerTableView, self.froductList.count)
                    let sublist = Array(self.froductList[startIndex..<endIndex])
                    let froductListViewController = FroductListViewController()
                    froductListViewController.froductList = sublist
                    froductListViewController.tabBarItem = UITabBarItem(title: "Tab \(index + 1)", image: nil, selectedImage: nil)
                    self.viewControllers?.append(froductListViewController)
                }
                self.addTabButtons()
                // Reload tableView after data is loaded
                self.viewControllers?.forEach { viewController in
                    if let froductListViewController = viewController as? FroductListViewController {
                        froductListViewController.tbnFroductList.reloadData()
                    }
                }
                // Print froductList for debugging
                print(self.froductList)
            }
        }
        func addTabButtons() {
            guard let tabBarItems = tabBar.items else { return }
            for (index, tabBarItem) in tabBarItems.enumerated() {
                let button = UIButton(type: .system)
                button.setTitle(tabBarItem.title, for: .normal)
                button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
                tabBar.addSubview(button)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: CGFloat(index) * tabBar.frame.width / CGFloat(tabBarItems.count)).isActive = true
                button.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
                button.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 1 / CGFloat(tabBarItems.count)).isActive = true
                button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            }
        }
        
        @objc func tabButtonTapped(_ sender: UIButton) {
            guard let tabBarItems = tabBar.items,
                  let index = tabBarItems.firstIndex(where: { $0.title == sender.title(for: .normal) }) else {
                return
            }
            selectedIndex = index
        }
    }

    class MainViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let froductListTabBarController = FroductListTabBarController()
            addChild(froductListTabBarController)
            view.addSubview(froductListTabBarController.view)
            froductListTabBarController.didMove(toParent: self)
        }
    }
