//
//  NewGamesViewController.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

import UIKit

protocol NewGamesViewProtocol: AnyObject {
    func showPopularGames(games: [Game])
    func saveFavoriteGame(game: Game)
    func deleteFavoriteGame(game: Game)
}

class NewGamesViewController: UIViewController {
    // MARK: - Public
    var presenter: NewGamesPresenterProtocol?

    private var savesGames: [Game] = [Game]()

    private var games: [Game] = [Game](){
        didSet{
            DispatchQueue.main.async {
                self.newGamesFeedTable.reloadData()
            }
        }
    }

    private let newGamesFeedTable: UITableView = {
        var table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(NewGamesTitleTableViewCell.self, forCellReuseIdentifier: NewGamesTitleTableViewCell.identifier)
        return table
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(newGamesFeedTable)
        newGamesFeedTable.delegate = self
        newGamesFeedTable.dataSource = self
        presenter?.viewDidLoadedGames()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newGamesFeedTable.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newGamesFeedTable.frame = view.bounds
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.saveFavoriteGames(games: savesGames)
        savesGames.removeAll()
    }


}

// MARK: - NewGamesViewProtocol
extension NewGamesViewController: NewGamesViewProtocol {
    func showPopularGames(games: [Game]) {
        self.games = games
    }
    func saveFavoriteGame(game: Game) {
        savesGames.append(game)
    }

    func deleteFavoriteGame(game: Game) {
        savesGames.removeAll(where: {$0.id == game.id })
    }
}


extension NewGamesViewController: UITableViewDelegate, UITableViewDataSource{

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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewGamesTitleTableViewCell.identifier, for: indexPath) as? NewGamesTitleTableViewCell else { return UITableViewCell()
        }
        cell.newGamesView = self
        cell.configure(with: games[indexPath.section])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = games[indexPath.section]
        let viewModel = TitlePreviewViewModel(title: item.title, titleOverview: item.description, imageId: item.image, titleModel: item)
        presenter?.showDetailTitle(viewModel)
    }
}
