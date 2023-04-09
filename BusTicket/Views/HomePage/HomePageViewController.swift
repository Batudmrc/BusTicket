//
//  HomePageViewController.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 3.04.2023.
//

import UIKit

public var selection = UILabel()
var allTickets = [Ticket]()
var seatStubs = [SeatStub]()

class HomePageViewController: UIViewController {
    
    
    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var tomorrowButton: UIButton!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var cardView: CardView!
    
    var ticket = Ticket()
    var todaysDateAsString = String()
    var todayDateAsDate = Date()
    let datePicker = UIDatePicker()
    let itemsTVC = CitiesTableViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateDoneButton()
        createDatePicker()
        setupDateField()
        setupButtons()
        
        self.setupLabelTap(for: self.fromLabel, withTag: 1)
        self.setupLabelTap(for: self.toLabel, withTag: 2)
    }
    
    // Destination Selection
    // In this function, I create a tap gesture and I use tags to differenciate labels
    @IBAction func tapFunction(_ sender: UITapGestureRecognizer) {
        self.itemsTVC.delegate = self
        if let label = sender.view as? UILabel {
            let tag = label.tag
            if tag == 1 {
                selection = fromLabel
            }
            if tag == 2 {
                selection = toLabel
            }
        }
        if let sheet = self.itemsTVC.sheetPresentationController {
            sheet.detents = [.medium(),.large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.dismissalTransitionWillBegin()
        }
        self.present(self.itemsTVC, animated: true)
    }
    
    func setupLabelTap(for label: UILabel, withTag tag: Int) {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(labelTap)
        label.tag = tag
    }
    
    // Destination Selection
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Seç", style: .done, target: nil, action: #selector(dateDoneButton))
        toolbar.setItems([flexSpace,doneBtn,flexSpace], animated: true)
        toolbar.sizeToFit()
        return toolbar
    }
    func createDatePicker() {
        datePicker.minimumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dateLabel.inputView = datePicker
        dateLabel.inputAccessoryView = createToolbar()
    }
    func setupDateField() {
        dateLabel.borderStyle = .none
        dateLabel.background = nil
        dateLabel.isUserInteractionEnabled = true
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.darkGray]
        let attributedPlaceholder = NSAttributedString(string: todaysDateAsString, attributes: placeholderAttributes)
        dateLabel.attributedPlaceholder = attributedPlaceholder
    }
    func setupButtons() {
        todayButton.layer.borderWidth = 0.5
        todayButton.layer.cornerRadius = 3
        tomorrowButton.layer.cornerRadius = 3
    }
    @objc func dateDoneButton() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        todayDateAsDate = datePicker.date
        todaysDateAsString = dateFormatter.string(from: datePicker.date)
        self.dateLabel.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func todayBtnTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2) {
            self.tomorrowButton.layer.borderWidth = 0
            self.todayButton.layer.borderWidth = 1
            self.todayButton.layer.borderColor = UIColor.black.cgColor
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        UIView.transition(with: dateLabel, duration: 0.15, options: .transitionCrossDissolve, animations: {
            self.dateLabel.text = dateFormatter.string(from: Date())
        }, completion: nil)
        
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        todaysDateAsString = self.dateLabel.text!
    }
    
    @IBAction func tomorrowBtnTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            self.todayButton.layer.borderWidth = 0
            self.tomorrowButton.layer.borderWidth = 1
            self.tomorrowButton.layer.borderColor = UIColor.black.cgColor
        }
        let calendar = Calendar.current
        let tomorrowDate = calendar.date(byAdding: .day, value: 1, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        UIView.transition(with: dateLabel, duration: 0.15, options: .transitionCrossDissolve, animations: {
            self.dateLabel.text = dateFormatter.string(from: tomorrowDate!)
        }, completion: nil)
        datePicker.datePickerMode = .date
        datePicker.date = tomorrowDate!
        todaysDateAsString = self.dateLabel.text!
    }
    
    // Passing Data
    
    @IBAction func findTrips(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "TripsVC") as! TripsViewController
        ticket.to = toLabel.text
        ticket.from = fromLabel.text
        
        // Formatting date
        let day = customDateFormat(date: datePicker.date, format: "dd")
        let month = customDateFormat(date: datePicker.date, format: "mm")
        let year = customDateFormat(date: datePicker.date, format: "yy")
       /* let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let day = formatter.string(from: datePicker.date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: datePicker.date)
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: datePicker.date)*/
        
        ticket.date = TicketDate(day: day,month: month,year: year)
        
        // Passing ticket date to TripsViewController
        controller.ticket = ticket
        controller.selectedDate = todaysDateAsString
        controller.todayDateAsDate = todayDateAsDate
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    func customDateFormat(date: Date, format: String) -> String {
        
        let formatter = DateFormatter()
        switch format {
        case "dd":
            formatter.dateFormat = "dd"
            let day = formatter.string(from: date)
            return day
        case "mm":
            formatter.dateFormat = "MM"
            let month = formatter.string(from: date)
            return month
        case "yy":
            formatter.dateFormat = "yy"
            let year = formatter.string(from: date)
            return year
        default:
            break
        }
        return "fail"
    }
}

extension HomePageViewController: CitiesTableViewControllerDelegate {
    func citiesTableViewControllerDidSelect(city: String, forLabel label: UILabel) {
        if itemsTVC.sheetPresentationController != nil {
            dismiss(animated: true)
        }
        UIView.transition(with: label, duration: 0.15, options: .transitionCrossDissolve, animations: {
            label.text = city
        }, completion: nil)
    }
}

