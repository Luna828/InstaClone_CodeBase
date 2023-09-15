import UIKit

extension PostView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        18
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath)

        cell.backgroundColor = UIColor.lightGray

        return cell
    }
}

extension PostView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == postsCollectionView {
            cell.backgroundColor = .systemGray5
        } else if collectionView == taggedPostsCollectionView {
            cell.backgroundColor = .systemGray3
        }
    }
}

