
import UIKit

class HabitsViewController: UIViewController {
    
    var collectionCell = HabitsCollectionViewCell()
    var notificationService = NotificationService()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionViewLayout.sectionInset = .init(top: 20, left: 15, bottom: 10, right: 15)
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewLayout.minimumLineSpacing = 15
        collectionViewLayout.minimumInteritemSpacing = 20
        
        return collectionView
    }()
    
    private enum ReuseID: String {
        case progress = "ProgressViewControllerCell_ReuseID"
        case habits = "HabitsViewControllerCell_ReuseID"
    }
    
    private lazy var dataLabel: UILabel = {
        let dataLabel = UILabel()
        dataLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        dataLabel.text = "Сегодня"
        dataLabel.textColor = UIColor.myColor(dark: .white, any: .black)
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dataLabel
    }()
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray5
        line.translatesAutoresizingMaskIntoConstraints = false
        
        return line
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubView()
        allViewsLayout()
        tuneCollectionView()
        self.collectionView.reloadData()
        notificationService.AskForNotificationPermission()
        alertIfPermissionDenied()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataAction(notificiation: )), name: Notification.Name("reloadData"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if collectionCell.buttonState == .tapped {
            reload()
        }
    }

    //MARK: - Private
    
    private func alertIfPermissionDenied() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            guard let self else { return }
            Task{
                if await self.notificationService.checkNotificationPermission() {
                    return
                }
                else {
                    let alertVC = UIAlertController(title: "Notification", message: "Вы запретили отправку уведомлений данным приложением, хотите ли вы включить ее?", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: {_ in
                        if let appSettings = URL(string: UIApplication.openNotificationSettingsURLString),
                            UIApplication.shared.canOpenURL(appSettings) {
                            UIApplication.shared.open(appSettings)
                        }
                    })
                    let alertAction2 = UIAlertAction(title: "No", style: .default, handler: {_ in
                        return
                    })
                    alertVC.addAction(alertAction)
                    alertVC.addAction(alertAction2)
                    self.navigationController?.present(alertVC, animated: true)
                }
            }
        })

    }
    
    private func setupView() {
        view.backgroundColor = UIColor.myColor(dark: #colorLiteral(red: 0.1098039076, green: 0.1098039076, blue: 0.1098039076, alpha: 1), any: .white)
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(presentCreateHabitController))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(deleteAllHabits))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.myColor(dark: #colorLiteral(red: 0.8646442294, green: 0.2918058038, blue: 0, alpha: 1), any: .purpleColor)
        navigationItem.rightBarButtonItem?.tintColor = 
        UIColor.myColor(dark: #colorLiteral(red: 0.8646442294,
                                            green: 0.2918058038,
                                            blue: 0, alpha: 1),
                        any: .purpleColor)

    }
    
    private func addSubView() {
        view.addSubview(dataLabel)
        view.addSubview(collectionView)
        view.addSubview(line)
    }
    
    private func allViewsLayout() {
        addSubView()
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            dataLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 4),
            dataLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            
            line.topAnchor.constraint(equalTo: dataLabel.bottomAnchor, constant: 5),
            line.widthAnchor.constraint(equalToConstant: 400),
            line.heightAnchor.constraint(equalToConstant: 1),

            
            collectionView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        
        ])
        
    }
    
    private func deleteAll() {
        let alert = UIAlertController(title: "Удалить все", message: "Вы уверены, что хотите безвозвратно удалить все элементы?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Удалить", style: .default)
                        {
            _ in
            HabitsStore.shared.habits.removeAll()
            self.reloadData()
            self.navigationController?.dismiss(animated: true)

        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .default))
        
        present(alert, animated: true)
    }
    
    private func tuneCollectionView() {
        collectionView.backgroundColor = UIColor.myColor(dark: #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1), any: #colorLiteral(red: 0.949019134, green: 0.9490200877, blue: 0.9705253243, alpha: 1))

        
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ReuseID.progress.rawValue)
        
        collectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: ReuseID.habits.rawValue)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        reloadData()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    //MARK: - objc func
    
    @objc func presentCreateHabitController() {
        let habitCreateViewController = HabitCreateViewController()
        let createHabit = UINavigationController(rootViewController: habitCreateViewController)
        createHabit.modalTransitionStyle = .coverVertical
        createHabit.modalPresentationStyle = .fullScreen
        present(createHabit, animated: true)
    }
 
    @objc func deleteAllHabits() {
        deleteAll()
        notificationService.deleteAllNotification()
    }
    
    @objc func reloadDataAction(notificiation: Notification) {
        collectionView.reloadData()
        
    }
    
}

//MARK: - Extensiones


extension HabitsViewController : UICollectionViewDataSource{
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseID.progress.rawValue, for: indexPath) as? ProgressCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            cell.contentView.layer.cornerRadius = 12.0
            cell.configureProgresscCell()
            cell.contentView.backgroundColor = UIColor.myColor(dark:#colorLiteral(red: 0.1098039076, green: 0.1098039076, blue: 0.1098039076, alpha: 1), any: .white)
        
            return cell
        }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseID.habits.rawValue, for: indexPath) as? HabitsCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.contentView.layer.cornerRadius = 12.0
        cell.contentView.backgroundColor = UIColor.myColor(dark: #colorLiteral(red: 0.1098039076, green: 0.1098039076, blue: 0.1098039076, alpha: 1), any: .white)
        cell.configure(index: indexPath.row - 1)
            return cell
        }
    }
    

extension HabitsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            
            let detailsViewController = DetailsViewController()
            detailsViewController.index = indexPath.row - 1
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func reload() {
        self.collectionView.reloadData()
    }
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 30, height: 65)
        }
        return CGSize(width: UIScreen.main.bounds.width - 30, height: 130)
    }
}


