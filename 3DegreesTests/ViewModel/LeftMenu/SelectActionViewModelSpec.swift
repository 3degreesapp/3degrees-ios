//
//  SelectActionViewModelSpec.swift
//  3Degrees
//
//  Created by Gigster Developer on 6/2/16.
//  Copyright © 2016 Gigster. All rights reserved.
//

import Quick
import Nimble
import Bond

@testable import _Degrees

class SelectActionViewModelSpec: QuickSpec {
    override func spec() {
        var viewModel: SelectActionViewModel!

        describe("action name value") {
            it("should return raw value of action") {
                viewModel = SelectActionViewModel(action: LeftMenuAction.ContactUs, value: Observable(""))
                expect(viewModel.actionName).to(equal(LeftMenuAction.ContactUs.rawValue))
                viewModel = SelectActionViewModel(action: LeftMenuAction.FAQ, value: Observable(""))
                expect(viewModel.actionName).to(equal(LeftMenuAction.FAQ.rawValue))
                viewModel = SelectActionViewModel(action: LeftMenuAction.InviteSingle, value: Observable(""))
                expect(viewModel.actionName).to(equal(LeftMenuAction.InviteSingle.rawValue))
            }
        }
        describe("value observable") {
            it("should return observable") {
                let value: Observable<String?> = Observable("")
                viewModel = SelectActionViewModel(action: LeftMenuAction.Preference, value: value)
                expect(viewModel.observableValue).to(beIdenticalTo(value))
            }
        }
    }
}
