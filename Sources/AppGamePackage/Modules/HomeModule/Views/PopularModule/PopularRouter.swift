//
//  PopularRouter.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

protocol PopularRouterProtocol {
    func showDetailTitle(_ viewModel: TitlePreviewViewModel)
}

class PopularRouter: PopularRouterProtocol {
    weak var viewController: PopularViewController?

    func showDetailTitle(_ viewModel: TitlePreviewViewModel) {
        let vc = PreviewModuleBuilder.build()
        vc.configure(with: viewModel)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
