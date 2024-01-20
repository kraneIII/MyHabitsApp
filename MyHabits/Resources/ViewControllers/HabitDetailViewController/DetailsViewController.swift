
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
        headerLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
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
        
        tableViewEditor.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        
        tableViewEditor.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: ReuseID.habit.rawValue)
        
        tableViewEditor.tableHeaderView = headerLabel
        tableViewEditor.tableHeaderView?.backgroundColor = view.backgroundColor
        
        tableViewEditor.tableFooterView = UIView()
        tableViewEditor.tableFooterView?.backgroundColor = view.backgroundColor
        
        tableViewEditor.delegate = self
        tableViewEditor.dataSource = self
        
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Сегодня", style: .plain, target: self, action: #selector(backToHabitViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(pushEditViewController))
        navigationItem.rightBarButtonItem?.tintColor = .purple
        navigationItem.leftBarButtonItem?.tintColor = .purple
    }

    @objc func backToHabitViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func pushEditViewController() {
        
        let habitEditViewController = HabitEditViewController()
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

        cell.backgroundColor = .white
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        
        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            let accessoryImage = UIImageView(frame: CGRect(x: .zero, y: .zero, width: 25, height: 25))
            accessoryImage.image = UIImage(named: "accessory")
            accessoryImage.tintColor = .purpleColor
            cell.accessoryView = accessoryImage
        }

        return cell
    }
    
    
}
