
import UIKit
import LocalAuthentication


class PasswordViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var confirmStackView: UIStackView!
    @IBOutlet weak var createdPasswordLabel: UITextField!
    @IBOutlet weak var enterPasswordLabel: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UITextField!
    @IBOutlet weak var enterPassword: UIStackView!
    @IBOutlet weak var imagePass: RoudedImage!
    
    // MARK: - Property
    var passwordText = ""
    var touchId:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        touchId = Password.shared.isTouchID
        updateUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         if Password.shared.isCeratedPassword {
             updateUI()
            
           enterPasswordLabel.becomeFirstResponder()
            if touchId {
            authenticate()
            }

         }
    }
    
    // MARK: - Action
    @IBAction func checkPassChangeTextfield(_ sender: UITextField) {
        if sender.text! == Password.shared.password {
            sender.text = nil
            performSegue(withIdentifier: GO_TO_SECRET_CONTACT, sender: nil)
            
        } else {
            
        }
    }

    @IBAction func okButtonPressed(_ sender: UIButton) {
        if (createdPasswordLabel.text?.isEmpty)! && (confirmPasswordLabel.text?.isEmpty)! {
            self.WarningfinishAlert(titel: "Password didn't enter", message: "Please enter your password", okButton: "OK")
            
        } else if createdPasswordLabel.text == confirmPasswordLabel.text {
            Password.shared.password = confirmPasswordLabel.text!
            Password.shared.isCeratedPassword = true
            confirmStackView.isHidden = true
            enterPassword.isHidden = false
            print("Created Password")
            
            
            performSegue(withIdentifier: GO_TO_SECRET_CONTACT, sender: nil)
        } else {
          self.WarningfinishAlert(titel: "Password doesn't match confirm", message: "Please provide identical inputs", okButton: "OK")
        }
    }
    
    // MARK: - Func
    func updateUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(touchIdISEnable(_:)), name: TOUCH_ID_ENABLE, object: nil)

        self.view.hiddenKeyboard()
        if Password.shared.isCeratedPassword {
            confirmStackView.isHidden = true
            enterPassword.isHidden = false
            imagePass.image = UIImage.init(named: "avatarEnterPV")
        } else {
            confirmStackView.isHidden = false
            enterPassword.isHidden = true
            imagePass.image = UIImage.init(named: "lock")
            imagePass.backgroundColor = UIColor.clear
            
        }
    }
   @objc func touchIdISEnable(_ notifi: NotificationCenter) {
        touchId = Password.shared.isTouchID
    }
    
    
    func authenticate() {
        let localAuthContext = LAContext()
        var authError: NSError?
        if !localAuthContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            if let error = authError {
                print(error)
            }
            return
        }
        localAuthContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "touch the sensor") { (success, error) in
            if success {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: GO_TO_SECRET_CONTACT, sender: nil)
                }
            } else {
                switch error! {
                case LAError.authenticationFailed:
                    print("Authentication failed")
                case LAError.passcodeNotSet:
                    print("Passcode not set")
                case LAError.systemCancel:
                    print("Authentication was canceled by system")
                case LAError.userCancel:
                    print("Authentication was canceled by the user")
                case LAError.touchIDNotEnrolled:
                    print("Authentication could not start because Touch ID has no enrolled fingers.")
                case LAError.touchIDNotAvailable:
                    print("Authentication could not start because Touch ID is not available.")
                case LAError.userFallback:
                    print("User tapped the fallback button (Enter Password).")
                default:
                    print(error!.localizedDescription)
                }
            }
        }
    }
    
    
    
}
