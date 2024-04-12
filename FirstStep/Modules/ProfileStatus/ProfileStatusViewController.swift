import UIKit

final class ProfileStatusViewController: BaseTableViewController {
    let useCase = ProfileStatusUseCase(apiService: FirebaseClient.shared)
    lazy var store = ProfileStatusStore(useCase: useCase)
    var status = FirebaseClient.shared.person?.status ?? Person.Status()
}

extension ProfileStatusViewController {
    override func setupViews() {
        super.setupViews()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension ProfileStatusViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        status.statuses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let text = status.statuses[indexPath.row]
        cell.textLabel?.text = text
        cell.accessoryType = status.index == indexPath.row ? .checkmark : .none
        return cell
    }
}

extension ProfileStatusViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        status.index = indexPath.row
        store.sendAction(.updateStatus(status))
        navigationController?.popViewController(animated: true)
    }
}
