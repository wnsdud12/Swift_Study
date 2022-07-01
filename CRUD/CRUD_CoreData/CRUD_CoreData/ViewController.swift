//
//  ViewController.swift
//  CRUD_CoreData
//
//  Created by 박준영 on 2022/07/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

    var people: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        for i in stride(from: 1, to: 10, by: +1) {
            CoreDataManager.shared.create(Person(name: "devwns\(i)", phoneNumber: "123", shortcutNumber: i))
        }
        people = CoreDataManager.shared.read()!
    }

    @IBAction func add(_ sender: Any) {
        var name = ""
        var phoneNumber = ""
        var shortcutNumber = ""

        let alert = UIAlertController(title: "전화번호 추가", message: "이름과 전화번호, 단축번호를 적어주세요.", preferredStyle: .alert)

        alert.addTextField() { textField in
            textField.placeholder = "이름"
        }
        alert.addTextField() { textField in
            textField.placeholder = "전화번호"
        }
        alert.addTextField() { textField in
            textField.placeholder = "단축번호"
            textField.keyboardType = .numberPad
        }

        let ok = UIAlertAction(title: "추가", style: .default) { ok in
            name = alert.textFields?[0].text ?? "이름 모름"
            phoneNumber = alert.textFields?[1].text ?? "전화번호 모름"
            shortcutNumber = alert.textFields?[1].text ?? "0"

            CoreDataManager.shared.create(Person(name: name, phoneNumber: phoneNumber, shortcutNumber: Int(shortcutNumber)!))
            self.people = CoreDataManager.shared.read()!
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancel in }
        alert.addAction(ok)
        alert.addAction(cancel)

        self.present(alert, animated: true)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        people = CoreDataManager.shared.read()!
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id) as! TableViewCell
        cell.name.text = people[indexPath.row].name
        cell.phoneNumber.text = people[indexPath.row].phoneNumber
        cell.shortcutNumber.text = "\(people[indexPath.row].shortcutNumber)"

        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            people.remove(at: indexPath.row)
            CoreDataManager.shared.delete(object: people[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
