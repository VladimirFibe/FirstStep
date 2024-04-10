import UIKit
import FirebaseStorage

final class FileStorage {
    static func uploadImage(_ image: UIImage,
                            directory: String,
                            completion: @escaping (String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.6) else { return }
        uploadData(imageData, directory: directory, completion: completion)
    }

    static func uploadData(_ data: Data,
                           directory: String,
                           completion: @escaping (String?) -> Void) {
        let storageRef = Storage.storage()
            .reference()
            .child(directory)

        var task: StorageUploadTask!
        task = storageRef.putData(data) { metadata, error in
            task.removeAllObservers()
            ProgressHUD.dismiss()
            if let error {
                print("DEBUG: ", error.localizedDescription)
            } else {
                storageRef.downloadURL { url, error in
                    completion(url?.absoluteString)
                }
            }
        }
        task.observe(StorageTaskStatus.progress) { snapshot in
            if let progress = snapshot.progress {
                let value = CGFloat(progress.completedUnitCount) / CGFloat(progress.totalUnitCount)
                ProgressHUD.progress(value)
            }
        }
    }
}
