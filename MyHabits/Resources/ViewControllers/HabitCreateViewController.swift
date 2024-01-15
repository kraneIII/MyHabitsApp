

import UIKit

class HabitCreateViewController: UIViewController, UITextFieldDelegate {
    
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
        view.backgroundColor = .white
        self.navigationItem.title = "Создать"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabitAndPushHabitController))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(pushHabitViewController))
        navigationItem.rightBarButtonItem?.tintColor = .purple
        navigationItem.leftBarButtonItem?.tintColor = .purple
        
  
    }
    
    private func addSubViews() {
        view.addSubview(namedLabel)
        view.addSubview(habitTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorPickerButton)
        view.addSubview(timeLabel)
        view.addSubview(dataPickerLabel)
        view.addSubview(dataPicker)
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
        let habitViewController = HabitsViewController()
        
        navigationController?.pushViewController(habitViewController, animated: true)
    }
    
    @objc func saveHabitAndPushHabitController() {
        let habitViewController = HabitsViewController()
        
        navigationController?.pushViewController(habitViewController, animated: true)
        
        let newHabit = Habit(name: habitTextField.text!,
                             date: dataPicker.date,
                             color: colorPickerButton.backgroundColor!)
        let store = HabitsStore.shared
        store.habits.append(newHabit)

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
