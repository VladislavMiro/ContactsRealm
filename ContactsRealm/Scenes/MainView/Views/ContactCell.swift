import UIKit

final class ContactCell: UITableViewCell {
    
    @IBOutlet private  weak var contactImage: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    public static let cellIdentifire = "ContactCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        contactImage.layer.cornerRadius = contactImage.layer.frame.size.width / 2
        contactImage.layer.masksToBounds = true
    }
    
    public func setData(name: String, lastName: String, image: Data?) {
        label.text = name + " " + lastName
        
        if let image = image {
            contactImage.image = UIImage(data: image)
        } else {
            contactImage.image = UIImage(named: "defaultPhoto")
        }
    }

}
