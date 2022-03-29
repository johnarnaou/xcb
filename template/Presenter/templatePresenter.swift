//
//  templatePresenter.swift
//  project_name
//
//  Created by user_name on dd/mm/yy.
//  Copyright © yy project_name. All rights reserved.
//

class templatePresenter: templatePresenterProtocol {

    // MARK: - Properties

    weak var view: templateViewProtocol?
    var interactor: templateInteractorInputProtocol?
    var wireframe: templateWireframeProtocol?

}

// MARK: - templateInteractorOutputProtocol
extension templatePresenter: templateInteractorOutputProtocol {

}
