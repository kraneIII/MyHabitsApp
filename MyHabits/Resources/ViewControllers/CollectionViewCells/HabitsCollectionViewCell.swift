
import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    private lazy var counter: UILabel = {
        let counter = UILabel()
        counter.textColor = .systemGray2
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.font = UIFont(name: "SFProText-Regular", size: 13)

        
       return counter
    }()
    
    private lazy var habitName: UILabel = {
        let habitName = UILabel()
        habitName.textColor = circleImage.backgroundColor
        habitName.translatesAutoresizingMaskIntoConstraints = false
        habitName.font = UIFont(name: "SFProText-Semibold", size: 17)

        
       return habitName
    }()
    
    private lazy var habitTime: UILabel = {
        let habitTime = UILabel()
        habitTime.textColor = .lightGrayColor
//        habitTime.textColor = UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)
        habitTime.font = UIFont(name: "SFProText-Regular", size: 12)
        habitTime.translatesAutoresizingMaskIntoConstraints = false
        
       return habitTime
    }()
    
    private lazy var circleImage: UIButton = {
        let circleImage = UIButton()
        circleImage.layer.cornerRadius = circleImage.frame.size.width / 2
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        circleImage.clipsToBounds = true
//        circleImage.backgroundColor = circleFilledImage.backgroundColor
        circleImage.setImage(UIImage(systemName: "circle"), for: .normal)
        circleImage.addTarget(self, action: #selector(animationCompleted) , for: .touchUpInside)
        
        return circleImage
    }()

    private lazy var circleFilledImage: UIButton = {
        let circleFilledImage = UIButton()
        circleFilledImage.translatesAutoresizingMaskIntoConstraints = false
        circleFilledImage.clipsToBounds = true
        circleFilledImage.frame.size = circleImage.frame.size
        circleFilledImage.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        circleFilledImage.addTarget(self, action: #selector(animationCanceled), for: .touchUpInside)
        circleFilledImage.layer.opacity = 0


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
            duration: 0.5,
            curve: .linear) {
                
                self.circleImage.layer.opacity = 1
            }
        animator.startAnimation(afterDelay: 0)
        }
    
    private func cancelAnimation() {
        let animator = UIViewPropertyAnimator(
            duration: 0.5,
            curve: .linear) {
                
                self.circleImage.layer.opacity = 0
            }
        animator.startAnimation(afterDelay: 0)
    }
    
    
    private func addSubViews() {
        contentView.addSubview(habitName)
        contentView.addSubview(habitTime)
        contentView.addSubview(counter)
        contentView.addSubview(circleImage)
//        contentView.addSubview(circleFilledImage)
    }
    
    private func viewsLayout() {
        addSubViews()
        NSLayoutConstraint.activate([
        
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            habitName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            habitTime.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 10),
            habitName.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),
            
            counter.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 30),
            counter.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),
            
            circleImage.widthAnchor.constraint(equalToConstant: 64),
            circleImage.heightAnchor.constraint(equalToConstant: 64),
            circleImage.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 5),
            circleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            
//            circleFilledImage.topAnchor.constraint(equalTo: circleImage.topAnchor),
//            circleFilledImage.bottomAnchor.constraint(equalTo: circleImage.bottomAnchor),
//            circleFilledImage.leadingAnchor.constraint(equalTo: circleImage.leadingAnchor),
//            circleFilledImage.trailingAnchor.constraint(equalTo: circleImage.trailingAnchor),

        ])
        
    }

    
    @objc func animationCompleted() {
        animation()
    }
    
    @objc func animationCanceled() {
        cancelAnimation()
    }
}
