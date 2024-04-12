import UIKit

final class UsersTableViewCell: BaseTableViewCell {
    static let identifier = "UsersTableViewCell"

    private let avatarImageView: UIImageView = {
        $0.image = .avatar
        return $0
    }(UIImageView())

    private let usernameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())

    private let statusLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .secondaryLabel
        return $0
    }(UILabel())

    public func configure(with person: Person) {
        usernameLabel.text = person.username
        statusLabel.text = person.status.text
        guard let id = person.id else { return }
        FileStorage.downloadImage(id: id, link: person.avatarLink) {
            self.avatarImageView.image = $0?.circleMasked
        }
    }
}
// MARK: - Setup Views
extension UsersTableViewCell {
    override func setupViews() {
        [avatarImageView, usernameLabel, statusLabel].forEach { contentView.addSubview($0) }
    }

    override func setupConstraints() {
        avatarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(52)
        }

        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView)
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        statusLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(usernameLabel)
        }
    }
}
