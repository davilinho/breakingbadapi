//
//  BaseViewController.swift
//  breakingbadapi
//
//  Created by David Martin on 7/11/21.
//

import UIKit

open class BaseViewController: UIViewController {
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bindViewModels()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unBindViewModels()
    }

    func bindViewModels() {
        CoreLog.ui.debug("Binding view models")
    }

    func unBindViewModels() {
        CoreLog.ui.debug("Unbinding view models")
    }
}
