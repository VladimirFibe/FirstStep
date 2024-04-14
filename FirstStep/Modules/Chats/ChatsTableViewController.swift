import UIKit

class ChatsTableViewController: BaseTableViewController {
    var recents: [Recent] = []

    //MARK: - Download Chats
    private func downloadRecentChats() {
        FirebaseClient.shared.downloadRecentChatsFromFireStore { recents in
            self.recents = recents
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(FirebaseClient.shared.person?.id ?? "No Person")
        downloadRecentChats()
    }
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
