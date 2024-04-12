import UIKit

class UsersViewControlller: BaseTableViewController {
    let useCase = UsersUseCase(apiService: FirebaseClient.shared)
    lazy var store = UsersStore(useCase: useCase)
    var persons: [Person] = []
    var filteredPersons: [Person] = []

    let searchController = UISearchController(searchResultsController: nil)
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
        tableView.register(UsersTableViewCell.self,
                           forCellReuseIdentifier: UsersTableViewCell.identifier)
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
        searchController.isActive ? filteredPersons.count : persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier, for: indexPath) as? UsersTableViewCell else {
            return UITableViewCell()
        }
        let person = searchController.isActive ? filteredPersons[indexPath.row] : persons[indexPath.row]
        cell.configure(with: person)
        return cell
    }
}

