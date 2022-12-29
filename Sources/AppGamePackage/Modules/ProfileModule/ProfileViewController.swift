//
//  ProfileViewController.swift
//  Super easy dev
//
//  Created by Олег Борисов on 22.11.2022
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func showDeleteComplete()
    func showProfile(profile: [Profile])
    func setNewTheme(theme: Theme)
    func fetchShowProfile()
    func didTapEditProfile()
    func showNewTheme(newTheme: Theme)

}

final class ProfileViewController: UIViewController {
    // MARK: - Public
    var presenter: ProfilePresenterProtocol?

    var footerProtocol: SegmentControlFooterProtocol?

    var userDefaults: MTUserDefaultsProtocol?

    private var profile: Profile?

    private var tableView =  UITableView()

    private var userInfoHeader: UserInfoHeader!
    private var segmentControlFooter: SegmentControlFooter!


    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension ProfileViewController{
    func initialize(){
        configureUI()
        configureHeader()
        configureFooter()
        configureTable()
        fetchShowProfile()
        fetchTheme()
    }

    func fetchTheme(){
        presenter?.fetchTheme()
    }

    func configureTable(){
        view.backgroundColor = .systemBackground
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.rowHeight = 60
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.frame
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = segmentControlFooter
        view.addSubview(tableView)

    }

    func configureHeader(){
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        userInfoHeader.profileProtocol = self
    }
    func configureFooter(){
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 80)
        segmentControlFooter = SegmentControlFooter(frame: frame)
        segmentControlFooter.profileProtocol = self
        segmentControlFooter.userDefaults = userDefaults

    }

    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Settings"
    }
}

// MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
    func didTapEditProfile() {
        presenter?.didTapEditProfile()
    }

    func setNewTheme(theme: Theme) {
        presenter?.setNewTheme(theme: theme)
    }

    func showNewTheme(newTheme: Theme){
        segmentControlFooter.showNewTheme(theme: newTheme)
    }

    func fetchShowProfile(){
        presenter?.fetchShowProfile()
    }

    func showProfile(profile: [Profile]) {
        self.profile = profile.last
        self.userInfoHeader.configure(profile: profile)
    }
    func showDeleteComplete(){
        let alert = UIAlertController(title: "Успех!", message: "Записи успешно удалены", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }

        switch section{
            case .Profile: return ProfileOptions.allCases.count
            case .ClearData: return ClearDatabaseOptions.allCases.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section{
            case .Profile:
                let social = ProfileOptions(rawValue: indexPath.row)
                cell.sectionType = social
            case .ClearData:
                let clear = ClearDatabaseOptions(rawValue: indexPath.row)
                cell.sectionType = clear
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = .systemRed
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        switch section{
            case .Profile:
                switch ProfileOptions(rawValue: indexPath.row){
                    case .editProfile:
                        presenter?.didTapEditProfile()
                    default: break
                }
            case .ClearData:
                switch ClearDatabaseOptions(rawValue: indexPath.row){
                    case .clearData:
                        let alert = UIAlertController(title: "Attention", message: "Вы действительно хотите удалить все записи?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                            self.presenter?.didTapDeleteAllTitles()
                        }))
                        alert.addAction(UIAlertAction(title: "No", style: .cancel))
                        self.present(alert, animated: true)
                    default: break
                }
        }
    }

}


extension ProfileViewController: UITableViewDataSource{ }
