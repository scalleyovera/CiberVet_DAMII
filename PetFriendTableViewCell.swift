import UIKit

protocol PetFriendCellDelegate: AnyObject {
    func didTapMeetFriend()
}

class PetFriendTableViewCell: UITableViewCell {

    @IBOutlet weak var petDetailsLabel: UILabel!
    @IBOutlet weak var petFriendImage: UIImageView!
    @IBOutlet weak var meetButton: UIButton!

    weak var delegate: PetFriendCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    private func setupViews() {
        petDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        meetButton.translatesAutoresizingMaskIntoConstraints = false
        petFriendImage.translatesAutoresizingMaskIntoConstraints = false

        meetButton.addTarget(self, action: #selector(meetButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            petDetailsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            petDetailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            petDetailsLabel.trailingAnchor.constraint(lessThanOrEqualTo: meetButton.leadingAnchor, constant: -8),


            meetButton.centerYAnchor.constraint(equalTo: petDetailsLabel.centerYAnchor),
            meetButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

        
            petFriendImage.topAnchor.constraint(equalTo: petDetailsLabel.bottomAnchor, constant: 12),
            petFriendImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            petFriendImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            petFriendImage.heightAnchor.constraint(equalToConstant: 200),
            petFriendImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

  
    @IBAction func meetButtonTapped(_ sender: UIButton) {
        delegate?.didTapMeetFriend()
    }
}
