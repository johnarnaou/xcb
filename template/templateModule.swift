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
        guard let viewController: templateViewController = nibController() else { return nil }

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
