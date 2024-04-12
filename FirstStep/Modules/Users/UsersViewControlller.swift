import UIKit

class UsersViewControlller: BaseTableViewController {
    let useCase = UsersUseCase(apiService: FirebaseClient.shared)
    lazy var store = UsersStore(useCase: useCase)
    var persons: [Person] = [] //DummyUsers.create()
    var filteredPersons: [Person] = []

    let searchController = UISearchController(searchResultsController: nil)
}
// MARK: - Setup Views
extension UsersViewControlller {
    override func setupViews() {
        navigationItem.title = "Users"
        store.sendAction(.fetch)
        setupObservers()
        setupSeachController()
        tableView.register(UsersTableViewCell.self,
                           forCellReuseIdentifier: UsersTableViewCell.identifier)
    }

    private func setupSeachController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search User"
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
    }

    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self else { return }
                switch event {
                case .done(let persons):
                    self.persons = persons
                    self.tableView.reloadData()
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
// MARK: - UISearchResultsUpdating
extension UsersViewControlller: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        filteredPersons = text.isEmpty ? persons : persons.filter({ $0.username.lowercased().contains(text)})
        tableView.reloadData()
    }


}
