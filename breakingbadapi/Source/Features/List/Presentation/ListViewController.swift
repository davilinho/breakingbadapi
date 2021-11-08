//
//  ListViewController.swift
//  breakingbadapi
//
//  Created by David Martin on 3/12/20.
//

import Lottie
import UIKit

class ListViewController: BaseViewController {
    @IBOutlet private var tableView: UITableView!

    @IBOutlet private var animationView: AnimationView! {
        didSet {
            self.animationView.layer.cornerRadius = 8
            self.animationView.contentMode = .scaleAspectFit
            self.animationView.loopMode = .loop
            self.animationView.backgroundBehavior = .pauseAndRestore
        }
    }

    @IBOutlet private var notFoundResultsLabel: UILabel! {
        didSet {
            self.notFoundResultsLabel.isHidden = true
            self.notFoundResultsLabel.textColor = .lightGray
            self.notFoundResultsLabel.font = UIFont.systemFont(ofSize: 16)
        }
    }

    @Inject var viewModel: ListViewModel

    private let search = UISearchController(searchResultsController: nil)

    private var characters: [Character]? {
        didSet {
            self.viewModel.stopAnimation()
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitle()
        self.initLottieAnimation()
        self.initRefreshControl()
        self.initSearchController()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetch()
    }

    override func bindViewModels() {
        super.bindViewModels()
        self.viewModel.characters.subscribe { [weak self] response in
            self?.characters = response
        }
        self.viewModel.isAnimated.subscribe { [weak self] isAnimated in
            guard let isAnimated = isAnimated, isAnimated else {
                self?.stopAnimation()
                return
            }
            self?.playAnimation()
        }
    }

    override func unBindViewModels() {
        super.unBindViewModels()
        self.viewModel.characters.unsubscribe()
        self.viewModel.isAnimated.unsubscribe()
    }

    @objc private func fetch() {
        guard !self.isSearched() else { return }
        self.viewModel.startAnimation()
        self.viewModel.onViewDidLoad()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.characters?.count, count > 0 else {
            self.showNotFoundResultsLabel(for: self.search.searchBar.text)
            return 0
        }
        self.hideNotFoundResultsLabel()
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CharactersCell = tableView.dequeueReusableCell(withIdentifier: "charactersCell", for: indexPath) as? CharactersCell,
              let character = self.characters?[indexPath.row] else { return UITableViewCell() }
        cell(self.view.frame.height, character)
        return cell
    }

    private func showNotFoundResultsLabel(for text: String?) {
        if let text = self.search.searchBar.text, !text.isEmpty {
            self.notFoundResultsLabel.isHidden = false
            self.notFoundResultsLabel.text = ["Not found results for", text].compactMap { $0 }.joined(separator: " ")
        }
    }

    private func hideNotFoundResultsLabel() {
        self.notFoundResultsLabel.isHidden = true
    }
}

extension ListViewController: UITableViewDelegate {

}

// MARK: - UI

extension ListViewController {
    private func initTitle() {
        self.title = "Breaking bad API"
    }
}

// MARK: - Lottie animations

extension ListViewController {
    private func initLottieAnimation() {
        let animation = Animation.named("loading")
        self.animationView.animation = animation
    }

    private func playAnimation() {
        self.animationView.play()
        self.animationView.isHidden = false
    }

    private func stopAnimation() {
        self.animationView.stop()
        self.animationView.isHidden = true
    }
}

// MARK: - Refresh control

extension ListViewController {
    private func initRefreshControl() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.fetch), for: .valueChanged)
    }
}

// MARK: - Search controller

extension ListViewController: UISearchBarDelegate {
    private func initSearchController() {
        self.search.searchBar.delegate = self
        self.search.searchBar.placeholder = "Search"
        self.search.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = self.search
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.definesPresentationContext = true

        let textFieldInsideSearchBar = self.search.searchBar.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = .gray

        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16)
        ], for: .normal)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16)
        ]
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange _: String) {
        guard let text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.clearSearchBar()
            self.fetch()
            return
        }
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.enableFilter(_:)), object: searchBar)
        perform(#selector(self.enableFilter), with: searchBar, afterDelay: 0.3)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        self.clearSearchBar()
        self.fetch()
    }

    @objc func enableFilter(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count >= 3 else { return }
        self.search(by: text)
    }

    private func search(by text: String) {
        self.viewModel.search(by: text)
    }

    private func showEmptySearchView() {
//        guard let textSearch = self.search.searchBar.text, let viewController = MediQuo.getInboxListEmptyViewController(textSearch) else { return }
//        self.add(asChildViewController: viewController,
//                 with: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.height))
    }

    private func hideEmptySearchView() {
//        self.removeChild()
    }

    private func isSearched() -> Bool {
        guard let text = self.search.searchBar.text, !text.isEmpty else { return false }
        return true
    }

    private func clearSearchBar() {
        self.search.searchBar.text?.removeAll()
    }
}
