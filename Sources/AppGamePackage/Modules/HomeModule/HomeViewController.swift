//
//  Home2ViewController.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

import UIKit

protocol HomeViewProtocol: AnyObject {
}

final class HomeViewController: UIViewController {
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
        configureUI()
        configurePopularView()
        containereUpcomingView()
    }


    func configureUI(){
        view.backgroundColor = .systemBackground
        navigationItem.titleView = segmentControl
        self.containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
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

    @objc func segmentSelectedAction(sender: UISegmentedControl) {
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

    func configurePopularView(){
        addChild(popularVC)
        self.view.addSubview(popularVC.view)
        popularVC.didMove(toParent: self)
        popularVC.view.frame = self.view.frame

    }

    func containereUpcomingView(){
        addChild(upcomimgVC)
        self.view.addSubview(upcomimgVC.view)
        upcomimgVC.didMove(toParent: self)
        upcomimgVC.view.frame = self.view.frame
    }


}

// MARK: - Home2ViewProtocol
extension HomeViewController: HomeViewProtocol {

}
