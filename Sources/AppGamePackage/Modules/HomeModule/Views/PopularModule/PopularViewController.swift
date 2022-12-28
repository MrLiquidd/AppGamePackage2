//
//  PopularViewController.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

import UIKit

protocol PopularViewProtocol: AnyObject {
    func showPopularGames(games: [Game])
    func saveFavoriteGame(game: GameViewModel)
    func deleteFavoriteGame(game: GameViewModel)
}

class PopularViewController: UIViewController {

    // MARK: - Public
    var presenter: PopularPresenterProtocol?

    private var savesGames: [GameViewModel] = [GameViewModel]()

    private var games: [Game] = [Game](){
        didSet{
            DispatchQueue.main.async {
                self.popularFeedTable.reloadData()
            }
        }
    }

    private let popularFeedTable: UITableView = {
        var table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(PopularTitleTableViewCell.self, forCellReuseIdentifier: PopularTitleTableViewCell.identifier)
        return table
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        popularFeedTable.reloadData()
        presenter?.viewDidLoadedGames()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        popularFeedTable.frame = view.bounds
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.saveFavoriteGames(games: savesGames)
        savesGames.removeAll()
    }
}

extension PopularViewController{
    func initialize(){
        configureUI()
        popularFeedTableConfigure()
    }

    func configureUI(){
        view.backgroundColor = .secondarySystemBackground
    }

    func popularFeedTableConfigure(){
        view.addSubview(popularFeedTable)
        popularFeedTable.delegate = self
        popularFeedTable.dataSource = self
    }
}

// MARK: - PopularViewProtocol
extension PopularViewController: PopularViewProtocol {
    func showPopularGames(games: [Game]) {
        self.games = games
    }
    func saveFavoriteGame(game: GameViewModel) {
        savesGames.append(game)
    }

    func deleteFavoriteGame(game: GameViewModel) {
        savesGames.removeAll(where: {$0.id == game.id })
    }
}


extension PopularViewController: UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        games.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularTitleTableViewCell.identifier, for: indexPath) as? PopularTitleTableViewCell else { return UITableViewCell()
        }
        let game = games[indexPath.section]
        let item = GameViewModel(id: game.id, title: game.title , worth: game.worth , image: game.image , description: game.description)
        cell.configure(with: item)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = games[indexPath.section]
        let viewModel = GameViewModel(id: item.id, title: item.title, worth: item.worth, image: item.image, description: item.description)
        presenter?.showDetailTitle(viewModel)
    }
}

extension PopularViewController: UITableViewDataSource{ }
