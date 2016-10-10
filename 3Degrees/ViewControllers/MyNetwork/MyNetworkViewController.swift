//
//  MyNetworkViewController.swift
//  3Degrees
//
//  Created by Gigster Developer on 5/13/16.
//  Copyright © 2016 Gigster. All rights reserved.
//

import UIKit

class MyNetworkViewController: UIViewController, ViewProtocol, RootTabBarViewControllerProtocol {
    private lazy var viewModel: MyNetworkViewModel = {[unowned self] in
        let viewModel = MyNetworkViewModel(tableView: self.tableView, tabsView: self.tabsView, router: self)
        if let tabBarController = self.tabBarController as? TabBarViewController {
            viewModel.matchClickedDelegate = tabBarController
        }
        return viewModel
    }()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var tabsView: TabsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = false
        applyDefaultStyle()
        configureBindings()
        setUpLeftMenuButton()
        title = "My Network"
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        removeBackButtonsTitle()
        viewModel.prepareForSegue(segue)
    }

    func applyDefaultStyle() {
        view.backgroundColor = Constants.ViewOnBackground.Color
        tableView.backgroundColor = Constants.ViewOnBackground.Color
        tableView.preservesSuperviewLayoutMargins = false
        tableView.separatorColor = Constants.MyNetwork.SeparatorColor
        tableView.tableFooterView = UIView()
    }

    func configureBindings() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
}
