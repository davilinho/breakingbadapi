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
            self.animationView.contentMode = .scaleAspectFit
            self.animationView.loopMode = .loop
            self.animationView.backgroundBehavior = .pauseAndRestore
        }
    }

    @Inject var viewModel: ListViewModel

    private var characters: [Character]? {
        didSet {
            self.viewModel.stopAnimation()
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLottieAnimation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.bindData()
    }

    private func bindData() {
        self.viewModel.startAnimation()
        self.viewModel.onViewDidLoad()
    }

    override func bindViewModels() {
        super.bindViewModels()
        self.viewModel.characters.subscribe { [weak self] response in
            self?.characters = response
        }
        self.viewModel.isAnimated.subscribe { [weak self] isAnimated in
            guard let isAnimated = isAnimated, isAnimated else {
                self?.animationView.stop()
                self?.animationView.isHidden = true
                return
            }
            self?.animationView.play()
        }
    }

    override func unBindViewModels() {
        super.unBindViewModels()
        self.viewModel.characters.unsubscribe()
        self.viewModel.isAnimated.unsubscribe()
    }

    private func initLottieAnimation() {
        let animation = Animation.named("loading")
        self.animationView.animation = animation
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
