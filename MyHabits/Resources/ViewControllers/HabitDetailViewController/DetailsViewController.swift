
import UIKit

class DetailsViewController: UIViewController {

    var index: Int = 0
    
    private lazy var tableViewEditor: UITableView = {
        let tableViewEditor = UITableView(frame: .zero, style: .plain)
        tableViewEditor.translatesAutoresizingMaskIntoConstraints = false
        
        return tableViewEditor
    }()
    
    private let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.text = "АКТИВНОСТЬ"
        headerLabel.textColor = UIColor.myColor(dark: #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1), any: UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6))
        headerLabel.font = UIFont(name: "SFProText-Regular", size: 13)
        
        return headerLabel
    }()
    
    private enum ReuseID: String {
        case habit = "HabitDetailsTableViewCell_ReuseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubView()
        tableViewEditorLayout()
        tuneTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(popVC(notificiation: )), name: Notification.Name("popVC"), object: nil)

    }
    
    private func addSubView() {
        view.addSubview(tableViewEditor)
    }
    
    private func tableViewEditorLayout() {
        addSubView()
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
        
            tableViewEditor.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableViewEditor.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableViewEditor.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableViewEditor.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            
        ])
        
    }
    
    private func tuneTableView() {
        
        tableViewEditor.backgroundColor = UIColor.myColor(dark: #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1), any: #colorLiteral(red: 0.949019134, green: 0.9490200877, blue: 0.9705253243, alpha: 1))
        
        tableViewEditor.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: ReuseID.habit.rawValue)
        
        tableViewEditor.tableHeaderView = headerLabel
        tableViewEditor.tableHeaderView?.backgroundColor = view.backgroundColor
        
        tableViewEditor.tableFooterView = UIView()
        tableViewEditor.tableFooterView?.backgroundColor = view.backgroundColor
        
        tableViewEditor.delegate = self
        tableViewEditor.dataSource = self
        
    }
    
    private func setupView() {
        title = HabitsStore.shared.habits[index].name
        view.backgroundColor = UIColor.myColor(dark: #colorLiteral(red: 0.1098039076, green: 0.1098039076, blue: 0.1098039076, alpha: 1), any: .white)
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Сегодня", style: .plain, target: self, action: #selector(backToHabitViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(pushEditViewController))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.myColor(dark: #colorLiteral(red: 0.8646442294, green: 0.2918058038, blue: 0, alpha: 1), any: .purpleColor)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.myColor(dark: #colorLiteral(red: 0.8646442294, green: 0.2918058038, blue: 0, alpha: 1), any: .purpleColor)
    }
    
    @objc func popVC(notificiation: Notification) {
        navigationController?.popViewController(animated: true)
    }

    @objc func backToHabitViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func pushEditViewController() {
                
        let habitEditViewController = HabitEditViewController()
        habitEditViewController.index = index
        let navigationController = UINavigationController(rootViewController: habitEditViewController)
        
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
}

extension DetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewEditor.dequeueReusableCell(withIdentifier: ReuseID.habit.rawValue, for: indexPath)

        cell.backgroundColor = UIColor.myColor(dark: #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1), any: .white)
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        
        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            let accessoryImage = UIImageView(frame: CGRect(x: .zero, y: .zero, width: 25, height: 25))
            accessoryImage.image = UIImage(named: "accessory")
            accessoryImage.tintColor = UIColor.myColor(dark: #colorLiteral(red: 0.2660255134, green: 0.5197638869, blue: 0.7189750075, alpha: 1), any: .purpleColor)
            cell.accessoryView = accessoryImage
        }

        return cell
    }
    
    
}
