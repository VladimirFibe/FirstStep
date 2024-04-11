import UIKit

final class ProfileStatusViewController: BaseTableViewController {
    let useCase = ProfileStatusUseCase(apiService: FirebaseClient.shared)
    lazy var store = ProfileStatusStore(useCase: useCase)
    var statuses: [String] = FirebaseClient.shared.person?.statuses ?? ["No Status"]
    var current: Int = FirebaseClient.shared.person?.status ?? 0
}

extension ProfileStatusViewController {
    override func setupViews() {
        super.setupViews()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension ProfileStatusViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statuses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let status = statuses[indexPath.row]
        cell.textLabel?.text = status
        cell.accessoryType = current == indexPath.row ? .checkmark : .none
        return cell
    }
}

extension ProfileStatusViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        current = indexPath.row
        store.sendAction(.update(statuses, current))
        navigationController?.popViewController(animated: true)
    }
}
