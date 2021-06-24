import UIKit
import Firebase
import FirebaseDatabase

class ElegirUsuarioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var usuarios : [Usuario] = []
    var imagenURL = ""
    var descrip = ""
    var imagenID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded, with: {(snapshot)in
        
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.password = snapshot.key
            self.usuarios.append(usuario)
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        let snap = ["from":Auth.auth().currentUser!.email,"descripcion":descrip,"imagenURL":imagenURL, "imagenID":imagenID]
        cell.textLabel?.text = usuario.email
        return cell
        Database.database().reference().child("usuarios").child(usuario.password).child("snaps").childByAutoId().setValue(snap)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuario = usuarios[indexPath.row]
        let snap = ["from":usuario.email, "descripcion":descrip, "imagenURL":imagenURL, "imagenID":imagenID]
        Database.database().reference().child("usuarios").child(usuario.password).child("snap").childByAutoId().setValue(snap)
        navigationController?.popToRootViewController(animated: true)
    }
}
