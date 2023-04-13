//
//  SwiftListViewController.swift
//  SwiftListViewController
//
//  Created by hiraoka on 2021/07/22.
//

import UIKit

final class SwiftListViewController: UIViewController {

//    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Task>!

    enum Section {
        case main
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.trailingSwipeActionsConfigurationProvider = { [unowned self] (indexPath) in
            guard let item = self.dataSource.itemIdentifier(for: indexPath) else { return nil }

            let delete = UIContextualAction(style: .destructive, title: "delete") { action, view, completion in
                var newSnapshot = self.dataSource.snapshot()
                newSnapshot.deleteItems([item])
                self.dataSource.apply(newSnapshot)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [delete])
        }

        configuration.leadingSwipeActionsConfigurationProvider = { [unowned self] (indexPath) in
            guard let item = self.dataSource.itemIdentifier(for: indexPath) else { return nil }

            let complete = UIContextualAction(style: .normal, title: "✅") { action, view, completion in
                var newItem = item
                newItem.completed = true
                var newItems = self.dataSource.snapshot().itemIdentifiers
                newItems.remove(at: indexPath.item)
                newItems.insert(newItem, at: indexPath.item)
                var snapshot = NSDiffableDataSourceSnapshot<Section, Task>()
                snapshot.appendSections([.main])
                snapshot.appendItems(newItems, toSection: .main)
                self.dataSource.apply(snapshot, animatingDifferences: true)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [complete])
        }

        let layout = UICollectionViewCompositionalLayout.list(using: configuration)

        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        var constraints = [NSLayoutConstraint]()
        constraints.append(collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor))
        constraints.append(collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor))
        constraints.append(collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor))
        constraints.append(collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor))

        view.addSubview(collectionView)
        NSLayoutConstraint.activate(constraints)

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Task> { (cell, indexPath, task) in

            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: task.completed ? "checkmark.circle.fill" : "circle")
            content.text = task.title

            cell.contentConfiguration = content
        }

        let dataSource = UICollectionViewDiffableDataSource<Section, Task>(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }

        self.dataSource = dataSource

        var snapshot = NSDiffableDataSourceSnapshot<Section, Task>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Task.samples, toSection: .main)

        self.dataSource.apply(snapshot, animatingDifferences: false)
    }

}


import SwiftUI

struct SwiftListView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: SwiftListViewController, context: Context) {
    }

    func makeUIViewController(context: Context) -> SwiftListViewController {
        SwiftListViewController()
    }
}
