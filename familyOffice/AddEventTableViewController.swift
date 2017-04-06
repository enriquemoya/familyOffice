//
//  AddEventTableViewController.swift
//  familyOffice
//
//  Created by Leonardo Durazo on 04/04/17.
//  Copyright © 2017 Leonardo Durazo. All rights reserved.
//

import UIKit

class AddEventTableViewController: BaseCell, UITableViewDelegate, UITableViewDataSource {
    var pickerVisible = false
    var event = DateModel(title: "", description: "", date: "", endDate: "", priority: 0, members: [""])
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(tableView)
        addContraintWithFormat(format: "H:|[v0]|", views: tableView)
        addContraintWithFormat(format: "V:|[v0]|", views: tableView)
        tableView.register(UINib(nibName: "Type1TableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        tableView.register(UINib(nibName: "Type2TableViewCell", bundle: nil), forCellReuseIdentifier: "cellId2")
        tableView.register(UINib(nibName: "DateTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId3")
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 || indexPath.row == 5  {
            if pickerVisible == false {
                return 0.0
            }
            return 165.0
        }
        return 80.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 || indexPath.row == 4 {
            pickerVisible = !pickerVisible
            tableView.reloadData()
        }
    }
    func setDateValue(date: String) -> Void {
        event.date = date
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! Type1TableViewCell
            switch indexPath.row {
            case 0:
                cell.textField.placeholder = "Título"
            case 1:
                cell.textField.placeholder = "Descripción"
            default:
                break
            }
            return cell
        }else if indexPath.row == 3 || indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId3", for: indexPath) as! DateTimeTableViewCell
            cell.addEventClass = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId2", for: indexPath) as! Type2TableViewCell
            
            switch indexPath.row {
            case 2:
                cell.textLabelText.text = "Inicio"
                if let date = Date(string: event.date, formatter: .dayMonthAndYear){
                    cell.textLabelSelect.text = "\(date)"
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: cell.textLabelSelect.text!)
                    attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                    
                    cell.textLabelSelect.attributedText = attributeString
                }
                
            case 4:
                cell.textLabelText.text = "Fin"
               
            case 6:
                cell.textLabelText.text = "Zona Horaria"
            case 7:
                cell.textLabelText.text = "Recordatorio"
            default:
                break
            }
            cell.textLabelText.isEnabled = false
            return cell
        }
        
    }
    
}
