import UIKit

class BaseViewController: UIViewController {
    deinit {
        print("\(String(describing: self)) dealloc" )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

@objc extension BaseViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
    }
    func setupConstraints() {}
}
