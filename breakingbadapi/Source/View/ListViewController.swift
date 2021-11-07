//
//  ListViewController.swift
//  breakingbadapi
//
//  Created by David Martin on 3/12/20.
//

import UIKit

class ListViewController: BaseViewController {
    @IBOutlet private var tableView: UITableView!

    @Inject var viewModel: ListViewModel

    private var characters: [Character]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindData()
    }

    private func bindData() {
        self.viewModel.onViewDidLoad()
    }

    override func bindViewModels() {
        super.bindViewModels()
        self.viewModel.characters.subscribe { [weak self] response in
            self?.characters = response
        }
    }

    override func unBindViewModels() {
        super.unBindViewModels()
        self.viewModel.characters.unsubscribe()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charactersCell", for: indexPath)
        let character = self.characters?[indexPath.row]
        cell.textLabel?.text = character?.name
        return cell
    }
}

extension ListViewController: UITabBarDelegate {

}
