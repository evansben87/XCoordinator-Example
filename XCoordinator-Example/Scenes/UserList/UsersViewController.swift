//  
//  UsersViewController.swift
//  XCoordinator-Example
//
//  Created by Joan Disho on 04.05.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class UsersViewController: UIViewController, BindableType {
    var viewModel: UsersViewModel!

    // MARK: Views

    @IBOutlet private var tableView: UITableView!

    // MARK: Stored properties

    private let disposeBag = DisposeBag()
    private let cellIdentifier = String(describing: DetailTableViewCell.self)

    // MARK: Initialization

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableViewCell()
        configureNavigationBar()
    }

    // MARK: BindableType

    func bindViewModel() {
        viewModel.output.users
        .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { _, element, cell in
            cell.textLabel?.text = element.name
            cell.selectionStyle = .none
        }
        .disposed(by: disposeBag)

        tableView.rx.modelSelected(User.self)
            .bind(to: viewModel.input.showUserTrigger)
            .disposed(by: disposeBag)
    }

    // MARK: Helpers

    private func configureTableViewCell() {
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    private func configureNavigationBar() {
        title = "Users"
    }

}
