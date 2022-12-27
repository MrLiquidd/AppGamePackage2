//
//  Home2ViewController.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

import UIKit

protocol HomeViewProtocol: AnyObject {
}

class HomeViewController: UIViewController {
    // MARK: - Public
    var presenter: HomePresenterProtocol?

    var containerView = UIView()

    let upcomimgVC = NewGamesModuleBuilder.build()
    let popularVC = PopularModuleBuilder.build()

    private let segmentControl: UISegmentedControl = {
        let titles = [HomeSections.upcomingSection.description, HomeSections.popularSection.description]
        let segmentControl = UISegmentedControl(items: titles)
        segmentControl.backgroundColor = .systemBackground
        segmentControl.selectedSegmentTintColor = .systemOrange
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        for index in 0...titles.count-1 {
            segmentControl.setWidth(150, forSegmentAt: index) }
        segmentControl.tintColor = .label
        segmentControl.frame.size.height = 44.0
        return segmentControl
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

}

// MARK: - Private functions
private extension HomeViewController {
    func initialize() {
        view.backgroundColor = .systemBackground
        configureUI()
        configurePopularView()
        containereUpcomingView()
    }


    private func configureUI(){
        navigationItem.titleView = segmentControl
        addBlurEffect()
        segmentControl.addTarget(self, action: #selector(segmentSelectedAction), for: .valueChanged)
    }
    func addBlurEffect() {
        let bounds = self.navigationController?.navigationBar.bounds
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = bounds ?? CGRect.zero
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.navigationController?.navigationBar.sendSubviewToBack(visualEffectView)
    }

    @objc private func segmentSelectedAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                UIView.animate(withDuration: 0.5) {
                    self.popularVC.view.isHidden = true
                    self.upcomimgVC.view.isHidden = false
                }
            case 1:
                UIView.animate(withDuration: 0.5) {
                    self.popularVC.view.isHidden = false
                    self.upcomimgVC.view.isHidden = true
                }
            default:break;
        }
    }

    private func configurePopularView(){

        self.containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

        addChild(popularVC)
        addChild(upcomimgVC)

        self.view.addSubview(popularVC.view)
        self.view.addSubview(upcomimgVC.view)

        popularVC.didMove(toParent: self)
        upcomimgVC.didMove(toParent: self)

        popularVC.view.frame = self.view.frame
        upcomimgVC.view.frame = self.view.frame

    }

    private func containereUpcomingView(){

    }


}

// MARK: - Home2ViewProtocol
extension HomeViewController: HomeViewProtocol {

}
