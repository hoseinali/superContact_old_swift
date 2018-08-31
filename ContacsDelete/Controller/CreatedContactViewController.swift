//
//  CreatedContactViewController.swift
//  ContacsDelete
//
//  Created by hosein on 8/27/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

class CreatedContactViewController: UIViewController ,UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    // MARK: - Outlet
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var phoneNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ButtonAddImage: UIButton!
    
    // MARK: - Property
    var contacts = [PVContact]()
    var contact:PVContact?
    var imaged: UIImage?
    var iSEditing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: - Action
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alertConroller = UIAlertController.init(title: "", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertConroller.addAction(cancelAction)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction.init(title: "Photo Library", style: .default) { (action) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertConroller.addAction(photoLibraryAction)
        }
        present(alertConroller, animated: true, completion: nil)
    }
    
    // MARK: - Func
    func updateUI() {
        if contact != nil {
            firstNameTextField.text = contact!.firstName
            lastNameTextField.text = contact!.lastName
            phoneNameTextField.text = contact!.phone
            image.image = contact!.image
            companyNameTextField.text = contact!.companyName
            emailTextField.text = contact!.email
            imaged = contact!.image
        }
        firstNameTextField.becomeFirstResponder()
        if PVContact.load() != nil {
            contacts = PVContact.load()!
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        image.image = selectedImage
        imaged = selectedImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindTopv" {
            let destination = segue.destination as! PrivateContactViewController
            let lastName = lastNameTextField.text
            let firstName = firstNameTextField.text
            let email = emailTextField.text
            let companyName = companyNameTextField.text
            let phone = phoneNameTextField.text
            let contactInt = PVContact.init(firstName: firstName!, lastName: lastName!, phone: phone!, image: imaged, companyName: companyName!, email: email!)
            destination.contacts.append(contactInt)
            destination.contacts = destination.contacts.filter({ $0 != destination.contactSelected })
            PVContact.save(pVContact: destination.contacts)
          
            }
        }
    
    
}
