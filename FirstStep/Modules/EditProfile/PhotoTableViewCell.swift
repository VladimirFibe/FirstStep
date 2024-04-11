import UIKit

final class PhotoTableViewCell: BaseTableViewCell {
    static let identifier = "PhotoTableViewCell"

    private let photoImageView: UIImageView = {
        $0.image = .avatar
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    private let editButton: UIButton = {
        $0.setTitle("Edit", for: [])
        return $0
    }(UIButton(type: .system))

    private let titleLabel: UILabel = {
        $0.text = "Enter your name and add an optional profile picture"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .secondaryLabel
        return $0
    }(UILabel())

    public func configure(_ target: Any?, action: Selector) {
        editButton.addTarget(target, action: action, for: .primaryActionTriggered)
    }

    public func configure(with image: UIImage?) {
        photoImageView.image = image?.circleMasked
    }
}
// MARK: - Setup Views
extension PhotoTableViewCell {
    override func setupViews() {
        [photoImageView, editButton, titleLabel].forEach {
            contentView.addSubview($0)
        }
        selectionStyle = .none
    }

    override func setupConstraints() {
        photoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(55)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(60)
        }

        editButton.snp.makeConstraints {
            $0.centerX.equalTo(photoImageView)
            $0.top.equalTo(photoImageView.snp.bottom).offset(5)
            $0.height.equalTo(22)
            $0.bottom.equalToSuperview().inset(14)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(photoImageView)
            $0.leading.equalTo(photoImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
