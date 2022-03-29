//
//  templateModule.swift
//  project_name
//
//  Created by user_name on dd/mm/yy.
//  Copyright © yy project_name. All rights reserved.
//

class templateModule {

    // MARK: - Methods

    static func create() -> templateViewController? {
         let bundle = Bundle(for: templateViewController.self)
        guard let viewController: templateViewController = bundle.loadNibNamed(
            String(describing: templateViewController.self),
            owner: nil,
            options: nil
        )?.first as? templateViewController else { return nil }

        let presenter = templatePresenter()
        let interactor = templateInteractor()
        let wireframe = templateWireframe()

        presenter.wireframe = wireframe
        presenter.interactor = interactor
        presenter.view = viewController

        interactor.presenter = presenter

        viewController.presenter = presenter

        return viewController
    }
}
