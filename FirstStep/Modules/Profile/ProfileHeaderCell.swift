import UIKit

final class ProfileHeaderCell: BaseTableViewCell {
    static let identifier = "ProfileHeaderCell"

    private let avatarImageView: UIImageView = {
        return $0
    }(UIImageView())

    private let usernameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private let statusLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
        return $0
    }(UILabel())

    public func configure(with person: Person) {
        guard let id = person.id else { return }
        usernameLabel.text = person.username
        statusLabel.text = person.status.text
        FileStorage.downloadImage(id: id, link: person.avatarLink) { image in
            self.avatarImageView.image = image?.circleMasked
        }
    }
}
// MARK: - Setup Views
extension ProfileHeaderCell {
    override func setupViews() {
        selectionStyle = .none
        [avatarImageView, usernameLabel, statusLabel].forEach { contentView.addSubview($0)}
    }

    override func setupConstraints() {
        avatarImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }

        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        statusLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom)
            $0.leading.trailing.equalTo(usernameLabel)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
