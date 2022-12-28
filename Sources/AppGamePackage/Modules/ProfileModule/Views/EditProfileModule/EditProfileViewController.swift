//
//  EditProfileViewController.swift
//  Super easy dev
//
//  Created by Олег Борисов on 23.12.2022
//

import UIKit

protocol EditProfileViewProtocol: AnyObject {
    func showProfile(profile: [Profile])
}

final class EditProfileViewController: UIViewController {

    var presenter: EditProfilePresenterProtocol?

    private let bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()

    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "chainsawman")
        return image
    }()

    private let cameraButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        let image = UIImage(systemName: "camera.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        image?.withTintColor(.black)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()

    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemOrange
        button.tintColor = .label
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bannerViewConfigurate()
        avatarImageViewConfigurate()
        cameraButtonConfigurate()
        nameTextFieldConfigurate()
        emailTextFieldConfigurate()
        saveButtonConfigurate()
        presenter?.fetchShowProfile()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    private func checkAreFieldsEmpty() -> Bool{
        if nameTextField.text == ""{
            nameTextField.layer.borderWidth = 2
            nameTextField.layer.cornerRadius = 7
            nameTextField.layer.borderColor  = UIColor.red.cgColor
            nameTextField.placeholder = "Needs Name!"
        } else{
            nameTextField.layer.borderWidth = 0
            nameTextField.layer.borderColor = UIColor.clear.cgColor
            nameTextField.borderStyle = .roundedRect
        }
        if emailTextField.text == ""{
            emailTextField.layer.borderWidth = 2
            emailTextField.layer.cornerRadius = 7
            emailTextField.layer.borderColor  = UIColor.red.cgColor
            emailTextField.placeholder = "Needs Email!"
        } else{
            emailTextField.layer.borderWidth = 0
            emailTextField.layer.borderColor = UIColor.clear.cgColor
            emailTextField.borderStyle = .roundedRect
        }
        if nameTextField.text != "" && emailTextField.text != ""{
            return false
        }
        return true
    }

    @objc func saveButtonTapped(){
        if !checkAreFieldsEmpty(){
            let model = ProfileModel(name: nameTextField.text!, email: emailTextField.text!, image: avatarImageView.image!)
            presenter?.putNewProfile(model: model)
            dismiss(animated: true)
        }
    }

    @objc func cameraButtonPressed(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        avatarImageView.image = userPickedImage
        picker.dismiss(animated: true)
    }

    func textFieldDoneEdeting(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{

}

// MARK: - EditProfileViewProtocol
extension EditProfileViewController: EditProfileViewProtocol {
    func showProfile(profile: [Profile]) {
        let profile = profile.first
        nameTextField.text = profile?.name
        emailTextField.text = profile?.email
        if let data = profile?.image{
            if let image = UIImage(data: data){
                avatarImageView.image = image
            }
        }
    }


}

private extension EditProfileViewController{

    private func bannerViewConfigurate(){
        view.addSubview(bannerView)
        bannerView.heightAnchor.constraint(equalToConstant: 143).isActive = true
        bannerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    private func avatarImageViewConfigurate(){
        view.addSubview(avatarImageView)
        let profileImageDimension: CGFloat = 160
        avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: -60).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        avatarImageView.layer.cornerRadius = profileImageDimension / 2
    }

    private func cameraButtonConfigurate(){
        view.addSubview(cameraButton)
        let cameraDimension: CGFloat = 60

        cameraButton.addTarget(self, action: #selector(cameraButtonPressed), for: .touchUpInside)
        cameraButton.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: cameraDimension).isActive = true
        cameraButton.widthAnchor.constraint(equalToConstant: cameraDimension).isActive = true
        cameraButton.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: -30).isActive = true
        cameraButton.layer.cornerRadius = cameraDimension / 2
    }

    private func nameTextFieldConfigurate(){
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 30).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    private func emailTextFieldConfigurate(){
        view.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    private func saveButtonConfigurate(){
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
