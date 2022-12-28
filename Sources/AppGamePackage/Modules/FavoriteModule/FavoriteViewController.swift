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

    var games: [GameItem] = [GameItem]()

    let downloadTable: UITableView = {
        let table = UITableView(frame: CGRect(), style: .plain)
        table.register(TitleDownloadTableViewCell.self, forCellReuseIdentifier: TitleDownloadTableViewCell.identifier)
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTable.frame = view.bounds
    }
}


private extension FavoriteViewController{

    func initialize(){
        navConfigure()
        tableConfigure()

        presenter?.didFetchGamesFromDB()

        notificationCenterConfigure()
    }

    func notificationCenterConfigure(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("updateFavorite"), object: nil, queue: nil) { _ in
            self.presenter?.didFetchGamesFromDB()
            self.downloadTable.reloadData()
        }
    }


    func tableConfigure(){
        view.addSubview(downloadTable)
        downloadTable.delegate = self
        downloadTable.dataSource = self
    }

    func navConfigure(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.title = "Favorite"
    }
}


// MARK: - FavoriteViewProtocol
extension FavoriteViewController: FavoriteViewProtocol {
    func showDownloadGames(games: [GameItem]) {
        self.games = games
    }


}
extension FavoriteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleDownloadTableViewCell.identifier, for: indexPath) as? TitleDownloadTableViewCell else {
            return UITableViewCell()
        }
        let game = games[indexPath.row]
        let item = GameViewModel(id: game.id, title: game.title ?? "Unknow", worth: game.worth ?? "N/A", image: game.imageUrl ?? "", description: game.description)
        cell.configure(with: item)
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .delete:
                presenter?.deleteFavoriteGame(game: games[indexPath.row])
                games.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            default:
                break;
        }
    }
}

extension FavoriteViewController: UITableViewDataSource{

}

