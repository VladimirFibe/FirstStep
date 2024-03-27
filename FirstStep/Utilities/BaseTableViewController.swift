import UIKit

class BaseTableViewController: UITableViewController {
    var bag = Bag()
    deinit {
        print("\(String(describing: self)) dealloc" )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

@objc extension BaseTableViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
    }
    func setupConstraints() {}
}
