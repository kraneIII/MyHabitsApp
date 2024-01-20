
import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    var index = 0
    
    private lazy var counter: UILabel = {
        let counter = UILabel()
        counter.textColor = .systemGray2
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
    
    private lazy var circleImage: UIButton = {
        let circleImage = UIButton()
        circleImage.layer.cornerRadius = 19
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        circleImage.clipsToBounds = true
        circleImage.layer.borderWidth = 2
        //        circleImage.setImage(UIImage(named: "trackedIcon"), for: .normal)
        circleImage.addTarget(self, action: #selector(animationCompleted) , for: .touchUpInside)
        
        return circleImage
    }()

    private lazy var circleFilledImage: UIButton = {
        let circleFilledImage = UIButton()
        circleFilledImage.translatesAutoresizingMaskIntoConstraints = false
        circleFilledImage.setImage(UIImage(named: "trackedButtonTouched"), for: .normal)
        circleFilledImage.addTarget(self, action: #selector(animationCanceled), for: .touchUpInside)
        circleFilledImage.isHidden = true

        //MARK: - добавить цвет


        return circleFilledImage
    }()


    
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        addSubViews()
        viewsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    
    private func animation() {
        let animator = UIViewPropertyAnimator(
            duration: 0.2,
            curve: .linear) { [self] in
                
                self.circleImage.backgroundColor = habitName.textColor
                self.circleFilledImage.isHidden = false
            }
        animator.startAnimation(afterDelay: 0)
        }
    
    private func cancelAnimation() {
        let animator = UIViewPropertyAnimator(
            duration: 0.2,
            curve: .linear) {
                
                self.circleImage.backgroundColor = .white
                self.circleFilledImage.isHidden = true
            }
        animator.startAnimation(afterDelay: 0)
    }
    
    
    private func addSubViews() {
        contentView.addSubview(habitName)
        contentView.addSubview(habitTime)
        contentView.addSubview(counter)
        contentView.addSubview(circleImage)
        contentView.addSubview(circleFilledImage)
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
            
            circleImage.widthAnchor.constraint(equalToConstant: 38),
            circleImage.heightAnchor.constraint(equalToConstant: 38),
            circleImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            circleFilledImage.topAnchor.constraint(equalTo: circleImage.topAnchor),
            circleFilledImage.bottomAnchor.constraint(equalTo: circleImage.bottomAnchor),
            circleFilledImage.leadingAnchor.constraint(equalTo: circleImage.leadingAnchor),
            circleFilledImage.trailingAnchor.constraint(equalTo: circleImage.trailingAnchor),

        ])
        
    }

    func configure(index: Int) {
                            
        habitName.text = HabitsStore.shared.habits[index].name
        habitTime.text = "\(HabitsStore.shared.habits[index].dateString)"
        counter.text = "Счетчик: \(HabitsStore.shared.habits[index].trackDates.count )"
        habitName.textColor = HabitsStore.shared.habits[index].color
        circleImage.layer.borderColor = habitName.textColor.cgColor
        if HabitsStore.shared.habit(HabitsStore.shared.habits[index], isTrackedIn: HabitsStore.shared.habits[index].date) {
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
        }
        if HabitsStore.shared.habits[index].isAlreadyTakenToday == false {
               
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
                counter.text = "\(HabitsStore.shared.habits[index].trackDates.count )"
                
                
            }
        }
    
    @objc func animationCompleted() {
        
        let index = habitName.tag
        
        if HabitsStore.shared.habits[index].isAlreadyTakenToday == false {
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
            counter.text = "\(HabitsStore.shared.habits[index].trackDates.count )"
            cancelAnimation()

        }
        
        animation()
    }
    
    @objc func animationCanceled() {
        cancelAnimation()
    }
}
