import UIKit

struct ProfileViewModel {
    var postFeed: [UIImage] = []
    var postCount: Int { return postFeed.count }
    var followerCount: Int = .random(in: 100 ... 300)
    var followingCount: Int = .random(in: 100 ... 300)
    
    var imagePickerAction: (() -> Void)?

    func websiteClicked(websiteURLString: String?) {
        if let websiteURLString = websiteURLString, let url = URL(string: websiteURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    func didSelectProfileImage(){
        imagePickerAction?()
    }
 
}
