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

    @Inject var viewModel: ListViewModel

    private var characters: [Character]? {
        didSet {
            self.viewModel.stopAnimation()
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLottieAnimation()
        self.initRefreshControl()
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
        self.viewModel.startAnimation()
        self.viewModel.onViewDidLoad()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CharactersCell = tableView.dequeueReusableCell(withIdentifier: "charactersCell", for: indexPath) as? CharactersCell,
              let character = self.characters?[indexPath.row] else { return UITableViewCell() }
        cell(self.view.frame.height, character)
        return cell
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
        self.tableView.refreshControl?.tintColor = .clear
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.fetch), for: .valueChanged)
    }
}
