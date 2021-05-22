//
//  AddDetailsViewController.swift
//  StudentsDetails
//
//  Created by admin on 22/05/21.
//

import UIKit
import CoreData

class AddDetailsViewController: UIViewController {

    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var isEditingEnabled = false
    var index = 0
    var studentsDetails = [StudentDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setLeftNavigation()
        updateUi()
        
    }
    
    
    @IBAction func backButton_tapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func addBtnTapped(_ sender: Any) {
        if isEditingEnabled{
            if validate(){
                studentsDetails[index].setValue(nameField.text ?? "", forKey: "name")
                studentsDetails[index].setValue(emailField.text ?? "", forKey: "email")
                studentsDetails[index].setValue(numberField.text ?? "", forKey: "number")
                studentsDetails[index].setValue(idField.text ?? "", forKey: "id")
            saveDetails()
                navigationController?.popViewController(animated: true)
            }else{
                CommonHelper.shared.showToast(message: Constants.errorMssg, font: UIFont(name: "Times New Roman", size: 12)!)
            }
        }else{
            if validate(){
                let newStudentDetails = StudentDetails(context: context)
                newStudentDetails.name = nameField.text ?? ""
                newStudentDetails.email = emailField.text ?? ""
                newStudentDetails.number = numberField.text ?? ""
                newStudentDetails.id = idField.text ?? ""
                saveDetails()
                navigationController?.popViewController(animated: true)
            }else{
                CommonHelper.shared.showToast(message: Constants.errorMssg, font: UIFont(name: "Times New Roman", size: 12)!)
            }
        }
        
    }
    
    // Updating UI
    func updateUi(){
        if isEditingEnabled{
            fetchDetails()
            idField.isEnabled = false
            nameField.text  = studentsDetails[index].name
            emailField.text = studentsDetails[index].email
            numberField.text = studentsDetails[index].number
            idField.text = studentsDetails[index].id
            addBtn.setTitle("EDIT", for: .normal)
            
        }else{
            idField.isEnabled = true
            addBtn.setTitle("ADD", for: .normal)
        }
    }
    
    // Saving data to core data
    func saveDetails(){
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // validation functions for text field
    func validate() -> Bool {
        var isValid = true
        
        if (nameField.text ?? "").isEmpty {
            isValid = false
        }
        
        if (emailField.text ?? "").isEmpty {
            isValid = false
        }
        
        if (numberField.text ?? "").isEmpty {
            isValid = false
        }
        
        if (idField.text ?? "").isEmpty {
            isValid = false
            }
            
        return isValid
    }
    
    // Fetching data from core data
    func fetchDetails(){
        let request : NSFetchRequest<StudentDetails> = StudentDetails.fetchRequest()
        
        do {
            studentsDetails = try context.fetch(request)
        }catch{
            print(error.localizedDescription)
        }
    }
}


//MARK:-  Miscellaneous
extension AddDetailsViewController{
    
    func customTitle() -> UIBarButtonItem {
        let sideTitleLabel = UILabel()
        sideTitleLabel.text = "Add Records"
        sideTitleLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2 + 50, height: 25)
        sideTitleLabel.font = UIFont.systemFont(ofSize: 21)
        sideTitleLabel.textColor = .black
        sideTitleLabel.textAlignment = .center
        sideTitleLabel.font = UIFont(name: "Times New Roman", size: 21.0)
        
        let titleLabel = UIBarButtonItem(customView: sideTitleLabel)
        return titleLabel
    }
    
    func customBackButton() -> UIBarButtonItem {
        let backButton = UIButton(type: .system)
        let imageSideMenu = UIImage(named: "Back_Black")
        backButton.setImage(imageSideMenu?.withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.addTarget(self, action: #selector(backButton_tapped), for: .touchUpInside)
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let customBackButton = UIBarButtonItem(customView: backButton)
        return customBackButton
    }
    
    
    func setLeftNavigation() {
        navigationItem.leftBarButtonItems = [customBackButton(),customTitle()]
    }
}
