//
//  UploadViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berkay Sancar on 16.04.2022.
//
import UIKit
import PhotosUI

protocol UploadViewDelegate: AnyObject, SeguePerformable {
    
    func onError(title: String, message: String)
    func setLoading(isLoading: Bool)
    func configure()
    func prepareImagePicker()
    func presentImagePicker()
    func uploadSuccess()
}

final class UploadViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var commentTextView: UITextView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var viewModel: UploadViewModelProtocol = UploadViewModel()
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        commentTextView.text = ""
        imageView.image = UIImage(systemName: "photo.fill.on.rectangle.fill")
    }
    
// MARK: - Did Tap Image
    @objc private func didTapImage() {
        viewModel.didTapImage()
    }

// MARK: - Upload Button Action
    @IBAction func didTapUploadButton(_ sender: Any) {
        
        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.5) else { return }
        
        if imageView.image != UIImage(systemName: "photo.fill.on.rectangle.fill") {
            viewModel.didTapUploadButton(data: imageData, comment: commentTextView.text ?? "")
        } else {
            self.errorMessage(titleInput: "Error!", messageInput: GeneralError.imageNotSelectedError.rawValue)
        }
    }
}
// MARK: - Upload View Delegate
extension UploadViewController: UploadViewDelegate {

// MARK: - Error
    func onError(title: String, message: String) {
        self.errorMessage(titleInput: title, messageInput: message)
    }

    func configure() {
        self.hideKeyboardWhenTappedAround()
        commentTextView.layer.borderColor = UIColor.systemIndigo.cgColor
    }
// MARK: - Prepare image picker
    func prepareImagePicker() {
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
// MARK: - Present image picker
    func presentImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
// MARK: - Upload Success
    func uploadSuccess() {
        self.tabBarController?.selectedIndex = 0
    }
    
// MARK: - Set loading
    func setLoading(isLoading: Bool) {
        if isLoading == true {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}

// MARK: - PHPickerViewControllerDelegate
extension UploadViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            let previousImage = imageView.image
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage, self.imageView.image == previousImage else { return }
                    self.imageView.image = image
                }
                guard error != nil else { return }
                self?.errorMessage(titleInput: "Error!", messageInput: GeneralError.photoPickerError.rawValue)
            }
        }
    }
}
