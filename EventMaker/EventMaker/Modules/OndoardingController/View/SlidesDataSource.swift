//
//  SlidesDataSource.swift
//  EventMaker
//
//  Created by Олег Романов on 31.03.2022.
//

import UIKit

class SlidesDataSource: NSObject {
    private var data: [Slide] = []
    private var collectionView: UICollectionView?
    private var pageNumber: Int = 0

    var pageChanged: ((Int, Int) -> Void)?

    func updateData(_ data: [Slide]) {
        self.data = data
        collectionView?.reloadData()
    }

    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SlideCell.self, forCellWithReuseIdentifier: "SlideCell")
    }

    func nextPage() {
        guard pageNumber < data.count - 1 else { return }
        let indexPath = IndexPath(item: pageNumber + 1, section: 0)
        collectionView?.scrollToItem(
            at: indexPath, at: .centeredHorizontally, animated: true
        )
    }
}

extension SlidesDataSource: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SlideCell",
            for: indexPath
        ) as? SlideCell
        let item = data[indexPath.item]
        cell?.configure(slide: item)
        return cell ?? UICollectionViewCell()
    }
}

extension SlidesDataSource: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let halfOfScreen: CGFloat = UIScreen.main.bounds.width / 2
        let nextPagePosition: CGFloat = scrollView.contentOffset.x + halfOfScreen
        let currentIndex = Int(nextPagePosition / UIScreen.main.bounds.width)
        if currentIndex != pageNumber {
            pageNumber = currentIndex
            pageChanged?(pageNumber, data.count)
        }
    }
}
