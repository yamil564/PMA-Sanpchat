import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var userorEmailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyle()
        getUsers()
    }
    
    func setUpStyle() {
        userorEmailTextField.text = "holaa@gmail.com"
        passwordTextField.text = "123456"
        passwordTextField.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 6.0
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickLogin(_ sender: Any) {
        let user = userorEmailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: user, password: password) { (responseUser, error) in
            if error == nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                let alert = UIAlertController(title: "Error", message: "User or Password incorrect", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func getUsers() {
        print("Snapshot aca")
        Database.database().reference().child("usuarios").observeSingleEvent(of: .value, with: {(snapshot) in
                print(snapshot)
                print("Snapshop aca")
            })
        }
    
}
