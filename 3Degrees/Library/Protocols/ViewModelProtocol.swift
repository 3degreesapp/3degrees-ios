//
//  ViewModelProtocol.swift
//  3Degrees
//
//  Created by Gigster Developer on 4/27/16.
//  Copyright © 2016 Gigster. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol ViewModelProtocol {
    var appNavigator: AppNavigator? { get set }
}

extension ViewModelProtocol {
    func show(viewController: UIViewController, withMenu: Bool) {
        if (withMenu) {
            self.appNavigator?.showVcAction(vc: viewController)
        } else {
            self.appNavigator?.presentOnWindowRootVc(vc: viewController)
        }
    }
}