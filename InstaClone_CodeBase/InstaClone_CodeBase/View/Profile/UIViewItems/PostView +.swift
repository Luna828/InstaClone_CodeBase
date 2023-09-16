import UIKit

extension PostView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postFeed.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as? PostCell {
            
            let image = postFeed[indexPath.item]
            cell.setImage(image!)
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = UIColor.red.cgColor
            
            return cell
        }
        return UICollectionViewCell()
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
