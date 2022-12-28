//
//  PopularRouter.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

protocol PopularRouterProtocol {
    func showDetailTitle(_ viewModel: GameViewModel)
}

class PopularRouter: PopularRouterProtocol {
    weak var viewController: PopularViewController?

    func showDetailTitle(_ viewModel: GameViewModel) {
        let vc = PreviewModuleBuilder.build()
        vc.configure(with: viewModel)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
