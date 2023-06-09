//
//  HomePageViewController.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 3.04.2023.
//

import UIKit
import CoreLocation

public var selection = UILabel()
var allTickets = [Ticket]()
var seatStubs = [SeatStub]()
var isLaunched = false

class HomePageViewController: UIViewController {
    
    
    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var tomorrowButton: UIButton!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var cardView: CardView!
    
    let locationManager = CLLocationManager()
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
        
        // Checking if user gave permission to location services
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Location authorization granted.")
        case .denied, .restricted:
            showSettingsAlert()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
        
        self.setupLabelTap(for: self.fromLabel, withTag: 1)
        self.setupLabelTap(for: self.toLabel, withTag: 2)
        
        // Getting the users city
        showUsersLocation()
        
    }
    
    // Departure and Destination Selection Starts here
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
        } // Connection tableview to sheetPresentation
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
    
    // Departure and Destination Selection Ends Here
    
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
        // Check if the selected cities are same
        if toLabel.text == fromLabel.text {
            showAlert(title: "Hata", message: "Kalkış yeri ile varış yeri aynı olamaz.")
        } else {
            ticket.to = toLabel.text
            ticket.from = fromLabel.text
            // Formatting date
            let day = customDateFormat(date: datePicker.date, format: "dd")
            let month = customDateFormat(date: datePicker.date, format: "mm")
            let year = customDateFormat(date: datePicker.date, format: "yy")
            ticket.date = TicketDate(day: day,month: month,year: year)
            
            // Passing ticket date to TripsViewController
            controller.ticket = ticket
            controller.selectedDate = todaysDateAsString
            controller.todayDateAsDate = todayDateAsDate
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true)
        }
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
    // Getting users location and changing the fromLabel
    func showUsersLocation() {
        let geocoder = CLGeocoder()
        if let userLocation = locationManager.location {
            geocoder.reverseGeocodeLocation(userLocation) { [self] (placemarks, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                if let placemark = placemarks?.first {
                    if itemsTVC.cities.contains(placemark.administrativeArea ?? "") {
                        UIView.transition(with: fromLabel, duration: 0.15, options: .transitionCrossDissolve, animations: {
                            self.fromLabel.text = placemark.administrativeArea ?? ""
                        }, completion: nil)
                    } else { // Checking if this is apps first launch
                        if !isLaunched {
                            showAlert(title: "Uyarı", message: "Bulunduğunuz bölge olan \(placemark.country ?? "") bölgesine hizmet veremiyoruz. Fakat yine de belirtilen bölgelere bilet alabilirsiniz")
                            isLaunched = true
                        }
                    }
                }
            }
        } else {
            print("User location not found.")
        }
    }
    
    func showSettingsAlert() {
        // Alert to show when user denied the location permission
        let alert = UIAlertController(title: "Konum izni gerekli", message: "Uygulamadan tam olarak faydalanabilmek için ayarlar kısmından uygulamanın konum servislerini kullanmasına izin verin", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Ayarlar", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        let cancelAction = UIAlertAction(title: "Geri", style: .cancel, handler: nil)
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func myTicketsTapped(_ sender: Any) {
        if allTickets.isEmpty {
            showAlert(title: "Hata", message: "Herhangi bir bilet bulunamadı.")
        } else {
            // Passing data
            let controller = storyboard?.instantiateViewController(withIdentifier: "myTickets") as! MyTicketsViewController
            controller.modalPresentationStyle = .fullScreen
            controller.myTickets = allTickets
            present(controller, animated: true)
        }
    }
}

extension HomePageViewController: CitiesTableViewControllerDelegate, CLLocationManagerDelegate {
    func citiesTableViewControllerDidSelect(city: String, forLabel label: UILabel) {
        if itemsTVC.sheetPresentationController != nil {
            dismiss(animated: true)
        }
        UIView.transition(with: label, duration: 0.15, options: .transitionCrossDissolve, animations: {
            label.text = city
        }, completion: nil)
    }
}

