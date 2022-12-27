//
//  FavoriteViewController.swift
//  Super easy dev
//
//  Created by Олег Борисов on 22.11.2022
//

import UIKit

protocol FavoriteViewProtocol: AnyObject {
    func showDownloadGames(games: [GameItem])
}

class FavoriteViewController: UIViewController {
    // MARK: - Public
    var presenter: FavoritePresenterProtocol?

    private var games: [GameItem] = [GameItem]()

    private let downloadTable: UITableView = {
        let table = UITableView(frame: CGRect(), style: .plain)
        table.register(TitleDownloadTableViewCell.self, forCellReuseIdentifier: TitleDownloadTableViewCell.identifier)
        return table
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.title = "Favorite"
        view.backgroundColor = .white
        view.addSubview(downloadTable)
        downloadTable.delegate = self
        downloadTable.dataSource = self
        presenter?.didFetchGamesFromDB()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("updateFavorite"), object: nil, queue: nil) { _ in
            self.presenter?.didFetchGamesFromDB()
            self.downloadTable.reloadData()
        }

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTable.frame = view.bounds
    }
}



// MARK: - FavoriteViewProtocol
extension FavoriteViewController: FavoriteViewProtocol {
    func showDownloadGames(games: [GameItem]) {
        self.games = games
    }


}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleDownloadTableViewCell.identifier, for: indexPath) as? TitleDownloadTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: games[indexPath.row])
        cell.favoriteView = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .delete:
                presenter?.deleteFavoriteGame(game: games[indexPath.row])
                self.games.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            default:
                break;
        }
    }
}

