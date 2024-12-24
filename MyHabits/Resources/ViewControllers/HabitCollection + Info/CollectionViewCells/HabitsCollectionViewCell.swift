
import UIKit
import AudioToolbox

enum State {
    case tapped
    case notTapped
}

class HabitsCollectionViewCell: UICollectionViewCell {
    
    var buttonState: State = .notTapped
    var index = 0
    
    private lazy var counter: UILabel = {
        let counter = UILabel()
        counter.textColor = UIColor.myColor(dark: #colorLiteral(red: 0.6823526025, green: 0.6823533773, blue: 0.6995555758, alpha: 1), any: .systemGray2)
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.font = UIFont(name: "SFProText-Regular", size: 13)
        
        
        
        return counter
    }()
    
    private lazy var habitName: UILabel = {
        let habitName = UILabel()
        habitName.translatesAutoresizingMaskIntoConstraints = false
        habitName.font = UIFont(name: "SFProText-Semibold", size: 17)
        habitName.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        return habitName
    }()
    
    private lazy var habitTime: UILabel = {
        let habitTime = UILabel()
        habitTime.textColor = UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)
        habitTime.font = UIFont(name: "SFProText-Regular", size: 12)
        habitTime.translatesAutoresizingMaskIntoConstraints = false
        
        return habitTime
    }()
    
    private lazy var habitAction: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor(named: "buttonColor")
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private lazy var imageButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Image")

        
        return image
    }()
        //MARK: - добавить цвет
   
    override init(frame: CGRect) {
        super .init(frame: .zero)
        addSubViews()
        viewsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private

    private func addSubViews() {
        contentView.addSubview(habitName)
        contentView.addSubview(habitTime)
        contentView.addSubview(counter)
        contentView.addSubview(habitAction)
        habitAction.addSubview(imageButton)
    }
    
    private func viewsLayout() {
        addSubViews()
        NSLayoutConstraint.activate([
            
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            habitName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            habitTime.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 10),
            habitTime.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),
            
            counter.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),
            counter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            habitAction.heightAnchor.constraint(equalToConstant: 60),
            habitAction.widthAnchor.constraint(equalToConstant: 60),
            habitAction.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 43),
            habitAction.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            
           
            imageButton.heightAnchor.constraint(equalToConstant: 50),
            imageButton.widthAnchor.constraint(equalToConstant: 50),
            imageButton.centerYAnchor.constraint(equalTo: habitAction.centerYAnchor),
            imageButton.centerXAnchor.constraint(equalTo: habitAction.centerXAnchor),

            
        ])
        
    }
    
    func configure(index: Int){
        habitName.tag = index
        
        habitName.text = HabitsStore.shared.habits[index].name
        habitName.textColor = HabitsStore.shared.habits[index].color
        habitTime.text = HabitsStore.shared.habits[index].dateString
        counter.text = "Счётчик: \(HabitsStore.shared.habits[index].trackDates.count)"
        habitAction.layer.borderColor = HabitsStore.shared.habits[index].color.cgColor
        
        UIView.animate(withDuration: 3, delay: 0.5, usingSpringWithDamping: 2, initialSpringVelocity: 5, animations: {
            self.imageButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            self.imageButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            self.imageButton.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
        })
        
        if HabitsStore.shared.habits[index].isAlreadyTakenToday == false {
            notSelectedButton()
           
        } else {
            selectedButton()
            
        }
    }
    
    func selectedButton(){
        
        imageButton.isHidden = false
        imageButton.setImageColor(color:  habitName.textColor)
    }
    
    func notSelectedButton(){
        
        habitAction.backgroundColor = UIColor(named: "buttonColor")
        imageButton.isHidden = true
    }
    
    @objc func checkAction(){
        
        let index = habitName.tag
        AudioServicesPlayAlertSound(SystemSoundID(1520))
        if HabitsStore.shared.habits[index].isAlreadyTakenToday == false {
           
            notSelectedButton()
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
            counter.text = "\(HabitsStore.shared.habits[index].trackDates.count )"
            
            
            NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
        }
    }
}

//MARK: - Extensions

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
