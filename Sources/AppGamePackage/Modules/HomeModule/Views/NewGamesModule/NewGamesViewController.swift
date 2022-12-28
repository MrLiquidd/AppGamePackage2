//
//  NewGamesViewController.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

import UIKit

protocol NewGamesViewProtocol: AnyObject {
    func showPopularGames(games: [Game])
    func saveFavoriteGame(game: GameViewModel)
    func deleteFavoriteGame(game: GameViewModel)
}

class NewGamesViewController: UIViewController {
    // MARK: - Public
    var presenter: NewGamesPresenterProtocol?

    private var savesGames: [GameViewModel] = [GameViewModel]()

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

    }

    override func loadView() {
        super.loadView()
        initialize()
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

extension NewGamesViewController{
    func initialize(){
        configureUI()
        newGamesTableConfigure()
        presenter?.viewDidLoadedGames()
    }

    func configureUI(){
        view.backgroundColor = .secondarySystemBackground
    }


    func newGamesTableConfigure(){
        view.addSubview(newGamesFeedTable)
        newGamesFeedTable.delegate = self
        newGamesFeedTable.dataSource = self
    }
}

// MARK: - NewGamesViewProtocol
extension NewGamesViewController: NewGamesViewProtocol {
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


extension NewGamesViewController: UITableViewDelegate{

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
        let game = games[indexPath.section]
        let item = GameViewModel(id: game.id, title: game.title , worth: game.worth , image: game.image , description: game.description)
        cell.configure(with: item)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = games[indexPath.section]
        DispatchQueue.main.async { [weak self] in
            let viewModel = GameViewModel(id: item.id, title: item.title, worth: item.worth, image: item.image, description: item.description)
            self?.presenter?.showDetailTitle(viewModel)
        }
    }
}

extension NewGamesViewController: UITableViewDataSource{ }
