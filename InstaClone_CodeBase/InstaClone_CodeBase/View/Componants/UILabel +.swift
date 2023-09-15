import UIKit

extension UILabel {
    
    func profileLabel(text: String, textColor: UIColor, fontSize: CGFloat){
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
    
}
