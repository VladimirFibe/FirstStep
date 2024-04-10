import UIKit
import PhotosUI

final class EditProfileViewController: BaseTableViewController {
    let useCase = EditProfileUseCase(apiService: FirebaseClient.shared)
    lazy var store = EditProfileStore(useCase: useCase)
    private let photoCell = PhotoTableViewCell()
    private let textFieldCell = TextFieldTableViewCell()
    private let statusCell = UITableViewCell()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        store.sendAction(.fetch)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}
extension EditProfileViewController {
    override func setupViews() {
        photoCell.configure(self, action: #selector(editButtonTapped))
        textFieldCell.configure(delegate: self)
        setupObservers()
    }

    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink {[weak self] event in
                guard let self else { return }
                switch event {
                case .done: self.showUserInfo()
                }
            }.store(in: &bag)
    }

    private func showUserInfo() {
        if let person = FirebaseClient.shared.person, let id = person.id {
            textFieldCell.configure(with: person.username)
            statusCell.textLabel?.text = person.statuses[person.status]
            FileStorage.downloadImage(id: id, link: person.avatarLink) { image in
                self.photoCell.configure(with: image)
            }
        }
    }
}
// MARK: - Actions
extension EditProfileViewController {
    @objc private func editButtonTapped() {
        presentPhotoPicker()
    }

    private func uploadAvatarImage(_ image: UIImage) {
        guard let id = FirebaseClient.shared.person?.id else { return }
        let path = "/profile/\(id).jpg"
        FileStorage.uploadImage(image, directory: path) { avatarLink in
            if let avatarLink {
                self.store.sendAction(.updateAvatarLink(avatarLink))
                ProgressHUD.succeed("Аватар сохранен")
                FileStorage.saveImageLocally(image, fileName: id)
            } else {
                ProgressHUD.failed("Аватар не сохранен")
            }
        }
    }
}
// MARK: - UITextFieldDelegate
extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textFieldCell.text.isEmpty {
            store.sendAction(.updateUsername(textFieldCell.text))
        }
        textField.resignFirstResponder()
        return true
    }
}
// MARK: -
extension EditProfileViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            print("Change status")
        }
    }
}
// MARK: - UITableViewDataSource
extension EditProfileViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 2 : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return indexPath.row == 0 ? photoCell : textFieldCell
        } else {
            return statusCell
        }
    }
}
// MARK: - PHPickerViewControllerDelegate
extension EditProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let result = results.first else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
            guard let image = reading as? UIImage, error == nil else {
                ProgressHUD.failed("Выберите другое изображение")
                return
            }
            DispatchQueue.main.async {
                self.photoCell.configure(with: image)
            }
            self.uploadAvatarImage(image)
        }
    }
    
    private func presentPhotoPicker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
}
