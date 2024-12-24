

import UIKit
var callPlace = ""


class HabitCreateViewController: UIViewController, UITextFieldDelegate {
    
    lazy var notificationService = NotificationService()
    
    private lazy var namedLabel: UILabel = {
        let namedLabel = UILabel()
        namedLabel.text = "НАЗВАНИЕ"
        namedLabel.font = UIFont.boldSystemFont(ofSize: 17)
//        namedLabel.font = UIFont(name: "SFProText-Semibold", size: 13)
        namedLabel.translatesAutoresizingMaskIntoConstraints = false
        namedLabel.clipsToBounds = true
        
        return namedLabel
    }()
    
    private lazy var habitTextField: UITextField = {
        let habitTextField = UITextField()
        habitTextField.placeholder = "Делать утреннею зарядку"
        habitTextField.textColor = .blueColor
        habitTextField.font = UIFont.systemFont(ofSize: 17)
        habitTextField.translatesAutoresizingMaskIntoConstraints = false
        habitTextField.clipsToBounds = true
        habitTextField.keyboardType = .default
        habitTextField.returnKeyType = UIReturnKeyType.done
        habitTextField.delegate = self
        
        return habitTextField
    }()

    private lazy var colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = "ЦВЕТ"
        colorLabel.font = UIFont.boldSystemFont(ofSize: 17)
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.clipsToBounds = true
        
        return colorLabel
    }()
    
    private lazy var colorPickerButton: UIButton = {
        let colorPickerButton = UIButton()
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        colorPickerButton.addTarget(self, action: #selector(presentColorPicker), for: .touchUpInside)
        colorPickerButton.layer.cornerRadius = 16
        colorPickerButton.backgroundColor = .lightOrangeColor
        
        
        return colorPickerButton
    }()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "ВРЕМЯ"
        timeLabel.font = UIFont.boldSystemFont(ofSize: 17)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.clipsToBounds = true
        
        return timeLabel
    }()
    
    private lazy var dataPickerLabel: UILabel = {
        let dataPickerLabel = UILabel()

        dataPickerLabel.text = "Каждый день в"
        dataPickerLabel.textColor =  UIColor.myColor(dark: .white, any: .black)
        dataPickerLabel.font = UIFont.systemFont(ofSize: 17)
        dataPickerLabel.translatesAutoresizingMaskIntoConstraints = false
        dataPickerLabel.clipsToBounds = true
        
        return dataPickerLabel
    }()
    
    private lazy var dataPicker: UIDatePicker = {
        let dataPicker = UIDatePicker()
        dataPicker.datePickerMode = .time
        dataPicker.date = .now
        dataPicker.preferredDatePickerStyle = .compact
        dataPicker.translatesAutoresizingMaskIntoConstraints = false
        
        return dataPicker
    }()
    
    private lazy var habitInfoTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Инструкция:"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = UIColor.myColor(dark: .white, any: .black)
        label.backgroundColor = .clear
        
        return label
    }()
    
    private lazy var habitInfo: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = String.infoHabits
        textView.backgroundColor = .clear
        textView.textColor = UIColor.myColor(dark: .white, any: .black)
        textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textView.isEditable = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerSetup()
        addSubViews()
        viewsLayout()
        
        let hideKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardTap)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        habitTextField.resignFirstResponder()
        textField.resignFirstResponder()

        return true
    }

    
    //MARK: - Private
    
    private func viewControllerSetup() {
        view.backgroundColor = UIColor.myColor(dark: #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1), any: .white)
        self.navigationItem.title = "Создать"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabitAndPushHabitController))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .done, target: self, action: #selector(pushHabitViewController))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.myColor(dark: #colorLiteral(red: 0.8646442294, green: 0.2918058038, blue: 0, alpha: 1), any: .purpleColor)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.myColor(dark: #colorLiteral(red: 0.8646442294, green: 0.2918058038, blue: 0, alpha: 1), any: .purpleColor)
        
  
    }
    
    private func addSubViews() {
        view.addSubview(namedLabel)
        view.addSubview(habitTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorPickerButton)
        view.addSubview(timeLabel)
        view.addSubview(dataPickerLabel)
        view.addSubview(dataPicker)
        view.addSubview(habitInfo)
        view.addSubview(habitInfoTitle)
    }
    
    private func viewsLayout() {
        let safeArea = view.safeAreaLayoutGuide
        addSubViews()
        NSLayoutConstraint.activate([
        
            namedLabel.topAnchor.constraint(equalTo: safeArea.topAnchor , constant: 20),
            namedLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            
            habitTextField.topAnchor.constraint(equalTo: namedLabel.bottomAnchor, constant: 5),
            habitTextField.leadingAnchor.constraint(equalTo: namedLabel.leadingAnchor),
            
            colorLabel.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: namedLabel.leadingAnchor),
            
            colorPickerButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 5),
            colorPickerButton.leadingAnchor.constraint(equalTo: namedLabel.leadingAnchor),
            colorPickerButton.heightAnchor.constraint(equalToConstant: 32),
            colorPickerButton.widthAnchor.constraint(equalToConstant: 32),
            
            timeLabel.topAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: namedLabel.leadingAnchor),
            
            dataPickerLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            dataPickerLabel.leadingAnchor.constraint(equalTo: namedLabel.leadingAnchor),
            
            dataPicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0),
            dataPicker.leadingAnchor.constraint(equalTo: dataPickerLabel.trailingAnchor, constant: 4),
            
            habitInfoTitle.topAnchor.constraint(equalTo: dataPicker.bottomAnchor, constant: 30),
            habitInfoTitle.leadingAnchor.constraint(equalTo: colorLabel.leadingAnchor),
            
            habitInfo.topAnchor.constraint(equalTo: habitInfoTitle.bottomAnchor, constant: 20),
            habitInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            habitInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            habitInfo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
        
        ])
    }
    
    //MARK: - @objc

    @objc func presentColorPicker(sender: UIButton) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        present(colorPicker, animated: true)
        
    }
    
    @objc func pushHabitViewController() {
        
        dismiss(animated: true)
    }
    
    @objc func saveHabitAndPushHabitController() {
        
        if habitTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Название привычки", message: "Вы не задали привычке имя", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            self.present(alert, animated: true)
        }
        else {
            let notificationContext = UNMutableNotificationContent()
            notificationContext.title = "Дзынь"
            notificationContext.sound = .default
            notificationContext.body = habitTextField.text ?? "веапроло"
            notificationService.addNotification(date: dataPicker.date, context: notificationContext)
            
            
            let newHabit = Habit(name: habitTextField.text!,
                                 date: dataPicker.date,
                                 color: colorPickerButton.backgroundColor!)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
            
            dismiss(animated: true)
            
      
        }
    }
    
    @objc func hideKeyboard() {
        habitTextField.resignFirstResponder()
    }
}


extension HabitCreateViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorPickerButton.backgroundColor = color
    }
}
