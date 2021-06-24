import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignupViewController: UIViewController {
    
    @IBOutlet weak var UserOrEmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setUpStyle(){
        SignUpButton.layer.cornerRadius = 6.0
    }
    
    @IBAction func OnBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func OnClickSignUp(_ sender: Any) {
        let email = UserOrEmailTextField.text!
        let password = PasswordTextField.text!
        
        /**Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                self.performSegue(withIdentifier: "SignupSegue", sender: nil)
                authResult.get
                let uid = user!.user.uid
                Database.database().reference().child("usuarios").child(uid).setValue(userData)
            }else{
                let alert = UIAlertController(title: "Error", message: "User or Password incorrect", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
        }**/
        
        Auth.auth().createUser(withEmail: self.UserOrEmailTextField.text!, password: self.PasswordTextField.text!, completion: { (user,error) in
                            print("Intentamos Crear un Usuario")
                            if error == nil {
                                print("El usuario fue creado existosamente")
                                self.performSegue(withIdentifier: "SignupSegue", sender: nil)
                                let userData = [
                                    "email":user!.user.email,
                                    "uid": user!.user.uid
                                ]
                                let uid = user!.user.uid
                                Database.database().reference().child("usuarios").child(uid).setValue(userData)
                            } else {
                                print("Tenemos el siguiente error - 2:\(error?.localizedDescription)")
                            }
                        })
    }
    
    
    
}
