import UIKit

class ChatsTableViewController: BaseTableViewController {
    var recents: [Recent] = [.init(username: "Quen", avatarLink: "https://raw.githubusercontent.com/VladimirFibe/FirstStep/main/FirstStep/Assets.xcassets/fsimages/\("fs01").imageset/\("fs01").jpg", text: "Privet", unreadCounter: 7)]
}

extension ChatsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatsCell.identifier, for: indexPath) as? ChatsCell else { fatalError("kapets")}
        let recent = recents[indexPath.row]
        cell.configure(with: recent)
        return cell
    }
}

extension ChatsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recent = recents[indexPath.row]
        let controller = ChatViewController(recent: recent)
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ChatsTableViewController {
    override func setupViews() {
        tableView.register(ChatsCell.self, forCellReuseIdentifier: ChatsCell.identifier)
    }
}
