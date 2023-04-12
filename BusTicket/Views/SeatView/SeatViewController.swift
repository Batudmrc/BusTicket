//
//  SeatViewController.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 6.04.2023.
//

import UIKit
import ALBusSeatView
class SeatViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var seatView: ALBusSeatView!
    @IBOutlet weak var nameField: UITextField!
    
    var ticket = Ticket()
    var selectedChairs = [Int]()
    var passenger = Passenger()
    var dataManager = SeatDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields(field: nameField,placeholder: "Ad Soyad Giriniz")
        setupFields(field: idField,placeholder: "T.C. Kimlik No Giriniz")
        
        // Notification center if user tried to pick 6th seat
        NotificationCenter.default.addObserver(forName: Notification.Name("SelectedSeatCountExceeded"), object: nil, queue: .main) { [weak self] (_) in
            if let strongSelf = self {
                    strongSelf.showAlert(title: "Hata", message: "En fazla 5 adet koltuk seçilebilir")
                }
        }
        
        seatView.config = ExampleSeatConfig()
        seatView.delegate = dataManager
        seatView.dataSource = dataManager
        
        backButton.contentMode = .scaleToFill
        backButton.clipsToBounds = true
        
        let mock = MockSeatCreater()
        var first = mock.create(count: 45)
        
        // Showing unavailable seats and their genders
        for i in allTickets {
            if i.from == ticket.from && i.to == ticket.to && i.clock == ticket.clock && i.date?.year == ticket.date?.year && i.date?.month == ticket.date?.month && i.date?.day == ticket.date?.day {
                for seat in i.seatInfo ?? [] {
                    first[seat.number-1].salable = false
                    first[seat.number-1].gender = seat.gender
                }
            }
        }
        dataManager.seatList = [first]
        seatView?.reload()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func payButton(_ sender: Any) {
        // Error handlings
        if idField.text != ""  && nameField.text != "" {
            if let text = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
               text.components(separatedBy: " ").count < 2 {
                let alert = UIAlertController(title: "Hata", message: "Lütfen bir soyisim giriniz", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            } else if let text = idField.text, text.count != 11 {
                showAlert(title: "Hata", message: "T.C. Kimlik No 11 karakter uzunluğunda olmalıdır")
            } else if dataManager.selectedSeatlist.count == 0 {
                showAlert(title: "Hata", message: "En az bir koltuk seçmelisiniz")
            } else if let text = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                      text.components(separatedBy: " ").filter({ $0.count > 1 }).count != text.components(separatedBy: " ").count {
                let alert = UIAlertController(title: "Hata", message: "İsim veya soyisim tek karakter olamaz", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            } else {
                let idInt = Int(idField.text!)
                passenger = Passenger(name: nameField.text!, id: idInt!)
                ticket.passenger = passenger
                
                let controller = storyboard?.instantiateViewController(withIdentifier: "SuccesVC") as! SuccesViewController
                ticket.selectedChairCount = dataManager.selectedSeatlist.count
                for i in dataManager.selectedSeatlist {
                    selectedChairs.append(i.number)
                }
                ticket.selectedChairs = selectedChairs
                for i in dataManager.selectedSeatlist {
                    seatStubs.append(i)
                }
                ticket.seatInfo = seatStubs
                controller.ticket = ticket
                controller.modalPresentationStyle = .fullScreen
                present(controller, animated: true)
            }
        } else {
            showAlert(title: "Hata", message: "Lütfen tüm alanları doldurunuz")
        }
    }
    
    func setupFields(field: UITextField,placeholder: String) {
        field.delegate = self
        field.borderStyle = .none
        field.background = nil
        field.isUserInteractionEnabled = true
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray]
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        field.attributedPlaceholder = attributedPlaceholder
    }
}

extension SeatViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Regex for idField and nameField
        if textField == idField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            let isAllDigits = string.rangeOfCharacter(from: allowedCharacters.inverted) == nil
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return isAllDigits && allowedCharacters.isSuperset(of: characterSet) && newText.count <= 11
        } else if textField == nameField {
            let allowedCharacters = CharacterSet.letters.union(CharacterSet.whitespaces)
            let characterSet = CharacterSet(charactersIn: string)
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
            // Capitalize the first letter of each word
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let capitalizedString = newString.capitalized(with: Locale.current)
            // Limit the textfield to 26 characters
            let maxLength = 26
            let currentString = textField.text ?? ""
            let newLength = currentString.count + string.count - range.length
            if newLength > maxLength {
                return false
            }
            // Update the textfield's text
            textField.text = capitalizedString
            return false
        } else {
            return true
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

