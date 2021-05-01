//
//  templatePresenter.swift
//  project_name
//
//  Created by user_name on dd/mm/yy.
//  Copyright © year user_name. All rights reserved.
//

class templatePresenter: templatePresenterProtocol {

    // MARK: - Properties

    weak var view: templateViewProtocol?
    var interactor: templateInteractorOutputProtocol?
    var wireframe: teamplteWireframeProtocol?

}

// MARK: - templateInteractorOutputProtocol
extension templatePresenter: templateInteractorOutputProtocol {

}
