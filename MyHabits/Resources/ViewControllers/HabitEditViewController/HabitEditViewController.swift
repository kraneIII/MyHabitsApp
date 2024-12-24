
import UIKit

class HabitEditViewController: UIViewController, UITextFieldDelegate {
        
    let habitViewController = HabitsViewController()
    let habitDetailsViewController = DetailsViewController()
    
    var index: Int = 0

    private lazy var namedLabel: UILabel = {
        let namedLabel = UILabel()
        namedLabel.text = "НАЗВАНИЕ"
        namedLabel.font = UIFont.boldSystemFont(ofSize: 17)
        namedLabel.translatesAutoresizingMaskIntoConstraints = false
        namedLabel.clipsToBounds = true
        
        return namedLabel
    }()
    
    private lazy var habitTextField: UITextField = {
        let habitTextField = UITextField()
        habitTextField.placeholder = "Новое название привычки"
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
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setTitle("Удалить привычку", for: .normal)
        deleteButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)
        deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        return deleteButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerSetup()
        addSubViews()
        viewsLayout()
        
        let hideKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardTap)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        habitTextField.resignFirstResponder()
        textField.resignFirstResponder()

        return true
    }

    
    //MARK: - Private
    
    private func viewControllerSetup() {
        navigationItem.title = "Править"
        view.backgroundColor =  UIColor.myColor(dark: #colorLiteral(red: 0.1098039076, green: 0.1098039076, blue: 0.1098039076, alpha: 1), any: .white)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabitAndPushHabitController))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .done, target: self, action: #selector(pushHabitViewController))
        navigationItem.rightBarButtonItem?.tintColor =  UIColor.myColor(dark: #colorLiteral(red: 0.8646442294, green: 0.2918058038, blue: 0, alpha: 1), any: .purpleColor)
        navigationItem.leftBarButtonItem?.tintColor =  UIColor.myColor(dark: #colorLiteral(red: 0.8646442294, green: 0.2918058038, blue: 0, alpha: 1), any: .purpleColor)
        
  
    }
    
    private func addSubViews() {
        view.addSubview(namedLabel)
        view.addSubview(habitTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorPickerButton)
        view.addSubview(timeLabel)
        view.addSubview(dataPickerLabel)
        view.addSubview(dataPicker)
        view.addSubview(deleteButton)
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
            
            deleteButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            deleteButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            deleteButton.widthAnchor.constraint(equalToConstant: 180),
            
        ])
    }
    
    private func updateData() {
        
        
        namedLabel.text = HabitsStore.shared.habits[index].name
        colorPickerButton.backgroundColor = HabitsStore.shared.habits[index].color
        dataPicker.date = HabitsStore.shared.habits[index].date
    }
    
    
    private func delete() {
        
        HabitsStore.shared.habits.remove(at: index)

    }
    
    //MARK: - @objc
    
    @objc func deleteHabit() {
        
        let alert = UIAlertController(title: "Удаление привычки", message: "Вы действительно хотите безвозвратно удалить привычку", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .default) {_ in
            //MARK: - вставить функцию удаления привычки
            self.delete()
            self.habitViewController.reload()
            self.navigationController?.dismiss(animated: true)
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        NotificationCenter.default.post(name: Notification.Name("popVC"), object: nil)
        
        present(alert, animated: true)
        
    }

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
            pushHabitViewController()
        }
        else {
            HabitsStore.shared.habits[index].name = habitTextField.text!
            HabitsStore.shared.habits[index].color = colorPickerButton.backgroundColor!
            HabitsStore.shared.habits[index].date = dataPicker.date
            HabitsStore.shared.save()
            self.habitViewController.reload()
            
            NotificationCenter.default.post(name: Notification.Name("popVC"), object: nil)
            dismiss(animated: true)
        }
    }
    
    @objc func hideKeyboard() {
        habitTextField.resignFirstResponder()
    }
}

extension HabitEditViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorPickerButton.backgroundColor = color
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let color = viewController.selectedColor
        colorPickerButton.backgroundColor = color
    }
}
