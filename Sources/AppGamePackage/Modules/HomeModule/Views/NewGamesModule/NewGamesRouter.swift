//
//  NewGamesRouter.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

protocol NewGamesRouterProtocol {
    func showDetailTitle(_ viewModel: TitlePreviewViewModel)
}

class NewGamesRouter: NewGamesRouterProtocol {
    weak var viewController: NewGamesViewController?

    func showDetailTitle(_ viewModel: TitlePreviewViewModel) {
        let vc = PreviewModuleBuilder.build()
        vc.configure(with: viewModel)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

}
