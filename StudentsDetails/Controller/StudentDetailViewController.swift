//
//  ViewController.swift
//  StudentsDetails
//
//  Created by admin on 21/05/21.
//

import UIKit
import CoreData

class StudentDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var studentsDetails = [StudentDetails]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchDetails()
        setLeftNavigation()
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchDetails()
        print(studentsDetails)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.addDetailsStoryBoardId) as? UIViewController
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    
    // saving the value in core data database
    func saveDetails(){
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // fetching the data from core data
    func fetchDetails(){
        let request : NSFetchRequest<StudentDetails> = StudentDetails.fetchRequest()
        
        do {
            studentsDetails = try context.fetch(request)
            print(studentsDetails)
            tableView.reloadData()
        }catch{
            print(error.localizedDescription)
        }
    }
    

}

//Mark:- Table View Datasource
extension StudentDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if studentsDetails.count == 0 {
            tableView.setEmptyMessage("No Students Data Available")
            
        }else{
            tableView.restore()
        }
        return studentsDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return studentsDetails(tableView: tableView, indexPath: indexPath)
        
    }
    
    func studentsDetails(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! StudentsTableViewCell
        cell.nameLabel.text = studentsDetails[indexPath.row].name
        cell.emailLabel.text = studentsDetails[indexPath.row].email
        cell.idLabel.text = studentsDetails[indexPath.row].id
        cell.phoneNoLabel.text = studentsDetails[indexPath.row].number
        
        cell.callBackForDelete = { [weak self] in
            guard let self = self else { return }
            self.context.delete(self.studentsDetails[indexPath.row])
            print(self.studentsDetails)
            self.saveDetails()
            self.fetchDetails()
        }
        
        cell.callBackForEdit = { [weak self] in
            guard let self = self else { return }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: Constants.addDetailsStoryBoardId) as! AddDetailsViewController
            vc.isEditingEnabled = true
            vc.index = indexPath.row
            self.navigationController!.pushViewController(vc, animated: true)
        }
        
        return cell
    }
}


//MARK:- Miscellaneous 
extension StudentDetailViewController{
    
    func customTitle() -> UIBarButtonItem {
        let sideTitleLabel = UILabel()
        sideTitleLabel.text = "Students"
        sideTitleLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2 + 200, height: 25)
        sideTitleLabel.font = UIFont.systemFont(ofSize: 21)
        sideTitleLabel.textColor = .black
        sideTitleLabel.textAlignment = .center
        sideTitleLabel.font = UIFont(name: "Times New Roman", size: 21.0)
        
        let titleLabel = UIBarButtonItem(customView: sideTitleLabel)
        return titleLabel
    }
    
    func setLeftNavigation() {
        navigationItem.leftBarButtonItems = [customTitle()]
    }
}
