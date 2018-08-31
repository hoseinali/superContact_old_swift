//
//  DetialContactViewController.swift
//  ContacsDelete
//
//  Created by hosein on 8/28/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit
import MessageUI

class DetialContactViewController: UIViewController, MFMessageComposeViewControllerDelegate {
   
    
    // MARK: - Outlet
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    // MARK: - Property
    var contact:PVContact?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    // MARK: - Action
    @IBAction func callingAction(_ sender: RoundedButton) {
        
        calling(contact!.phone)
    }
    
    @IBAction func messagingAction(_ sender: RoundedButton) {
        
         masseging(contact!.phone)
    }
    
    @IBAction func updateButtonPressed(_ sender: RoundedButton) {
        performSegue(withIdentifier: "updateContact", sender: nil)
    }
    
    @IBAction func deleteButtonPressed(_ sender: RoundedButton) {
        wraningAlertDeletePV(titel: "Do you want delete? ", message: "", okButton: "Yes", cancelButton: "No", functionAction: deletePvContact, functioncancel: cancel)
       
    }
    
    // MARK: - func
    func updateUI() {
        telLabel.text = "Email: \(contact!.email)"
        telLabel.text = "Tel: \(contact!.phone)"
        nameLabel.text = namePVContact(contact: contact!)
        if contact!.image == nil {
            contact!.image = UIImage.init(named: "profileBig")
        }
        image.image = contact!.image
    }
    func deletePvContact() {
        NotificationCenter.default.post(name: DELETE_PV, object: nil)
       performSegue(withIdentifier: "detialUnwindToPv", sender: nil)
        
    }
    func cancel() {
        
    }
    
    func calling(_ phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func masseging(_ phoneNumber: String) {
        
            guard MFMessageComposeViewController.canSendText() else {
                let alertMessage = UIAlertController(title: "SMS Unavailable", message: "Your device is not capable of sending SMS.", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertMessage, animated: true, completion: nil)
                return
            }
            let messageController = MFMessageComposeViewController()
            messageController.messageComposeDelegate = self
            messageController.recipients = [phoneNumber]
            messageController.body = " "
            present(messageController, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch(result) {
        case MessageComposeResult.cancelled:
            print("SMS cancelled")

        case MessageComposeResult.failed:
            let alertMessage = UIAlertController(title: "Failure", message: "Failed to send the message.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertMessage, animated: true, completion: nil)
            
        case MessageComposeResult.sent:
            print("SMS sent")
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func namePVContact(contact:PVContact) -> String {
        return contact.firstName + " " + contact.lastName + " " + contact.companyName
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "updateContact" {
            guard let contact = contact else { return  }
            let destination = segue.destination as! CreatedContactViewController
            destination.contact = contact
            destination.iSEditing = true
        }
    }
    


}
