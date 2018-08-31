import UIKit


class PVTableViewCell: UITableViewCell {
   
    // MARK: - Outlet
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(image: UIImage?, name: String) {
        self.name.text = name
        if image == nil {
            self.profileImage!.image = UIImage.init(named: "Profile")
        } else {
            self.profileImage!.image = image
        }
    }
    
}
