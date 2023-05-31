//
//  RegisterViewController.swift
//  ChaApp
//
//  Created by Tami Zouine on 30/5/2023.
//

import UIKit

class RegisterViewController: UIViewController {

    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "person")
        img.tintColor = .gray
        img.contentMode = .scaleAspectFit
        img.layer.masksToBounds = true
        img.layer.borderColor = UIColor.lightGray.cgColor
        img.layer.borderWidth = 2
        return img
    }()
    private let firstNameField: UITextField = {
       let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor

        field.placeholder = "First Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    private let lastNameField: UITextField = {
       let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor

        field.placeholder = "Last Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    private let emailTextField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor

        field.placeholder = "Email Addess"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
        
    }()
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password ..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
        
    }()
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        button.layer.cornerRadius = 12
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        view.backgroundColor = .white
        registerButton.addTarget(self, action: #selector(registerButtunPressed), for: .touchUpInside)
        //MARK: Add SubViews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(registerButton)
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapeChangeProfilePic))
        imageView.addGestureRecognizer(gesture)
    }
    @objc func didTapeChangeProfilePic(){
     presentPhotoActionSheet()
        
    }
    @objc func registerButtunPressed(){
        lastNameField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        guard let lastName = lastNameField.text,
              let firstName = firstNameField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              !lastName.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !email.isEmpty else {
            alertUserRegisterError()
            return
        }
        //MARK: FirebaseAuth
        
    }
    private func alertUserRegisterError(){
        let alert = UIAlertController(title: "Hoops", message: "Ennter All Information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dissmiss", style: .cancel,handler: nil))
        present(alert,animated: true)
        
    }

    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
        let size = scrollView.width / 3
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 100, width: size + 20, height: size + 20)
        imageView.layer.cornerRadius = imageView.width / 2.0
        firstNameField.frame = CGRect(x:30, y: imageView.bottom + 10, width: scrollView.width - 60, height: 52)
        lastNameField.frame = CGRect(x:30, y: firstNameField.bottom + 10, width: scrollView.width - 60, height: 52)
        emailTextField.frame = CGRect(x:30, y: lastNameField.bottom + 10, width: scrollView.width - 60, height: 52)
        passwordTextField.frame = CGRect(x:30, y: emailTextField.bottom + 10, width: scrollView.width - 60, height: 52)
        registerButton.frame = CGRect(x:30, y: passwordTextField.bottom + 10, width: scrollView.width - 60, height: 52)
    }
  
    


}
extension RegisterViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        if textField == emailTextField {
            
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
                
            registerButtunPressed()
        }
        return true
    }
}
extension RegisterViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you Like to select a picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default,handler: {[weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Shoose Photo", style: .default,handler: {[weak self] _ in
            self?.presentPhotoPicker()
        }))
        present(actionSheet,animated: true)
        
    }
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
         
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }

}
