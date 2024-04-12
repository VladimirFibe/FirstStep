import UIKit

class UsersViewControlller: BaseTableViewController {
    let useCase = UsersUseCase(apiService: FirebaseClient.shared)
    lazy var store = UsersStore(useCase: useCase)
    var persons: [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        store.sendAction(.fetch)
    }
}
// MARK: - Setup Views
extension UsersViewControlller {
    override func setupViews() {
        navigationItem.title = "Users"
        setupObservers()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self else { return }
                switch event {
                case .done(let persons):
                    print("Persons: ", persons.count)
                    self.persons = persons
                    tableView.reloadData()
                }
            }
            .store(in: &bag)
    }
}
// MARK: -
extension UsersViewControlller {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = persons[indexPath.row].username
        return cell
    }
}
