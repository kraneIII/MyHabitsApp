
import UIKit

class InfoViewController: UIViewController {
    
    private lazy var habitLabel: UILabel = {
        let habitLabel = UILabel()
        habitLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 25)
        habitLabel.text = "Привычка за 21 день"
        habitLabel.textColor = UIColor.myColor(dark: .white, any: .black)
        habitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return habitLabel
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        descriptionTextView.isEditable = false
        descriptionTextView.textColor = UIColor.myColor(dark: .white, any: .black)
        descriptionTextView.backgroundColor = UIColor.myColor(dark: #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1), any: .white)
        descriptionTextView.text =
    """
        1. Надо понять, от чего вы хотите избавиться и что приобрести.Провести ревизию всех своих приобретенных привычек. Составить список тех, которые вы желали бы выработать. Поставьте цели, достичь которых вам помогут только новые навыки. Выберите 1–3 привычки, над которыми будете работать в ближайшее время. Напишите мотивирующие фразы. Развесьте их на стенах так, чтобы они всегда попадались вам на глаза и помогали в трудные минуты.
        
        2. После принятия решения стартуйте на следующий же день. Не откладывайте в долгий ящик обещания, данные самому себе. Если решили обливаться утром холодной водой, то сделайте это хотя бы один раз. Сдвиньтесь с мертвой точки!

        3. Сделайте над собой еще одно усилие: повторите привычку два дня подряд. Будет сложно, но не сдавайтесь! Попробуйте воспользоваться «правилом одного дня». Каждый день говорите себе: «Я делаю это сегодня и только один день». И на следующий день говорите себе то же самое: «Я делаю это только сегодня и только один день». И так каждый день в течение 21 дня.

        4. Выходим на финишную прямую: или обливаемся холодной водой каждый день в течение недели, или перестаем пить пиво, или бросаем курить. Никаких выходных! Никаких отговорок! Назвались груздем — полезайте в кузов.

        5. Повторяйте действия в течение 21 дня. Это время считается оптимальным для формирования привычки. Если ни разу не сошли с дистанции, считайте себя героем!"
    """
        
        return descriptionTextView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        addSubViews()
        viewsLayout()
        
        
    }
    
    //MARK: - Private
    
    private func setupViewController() {
        view.backgroundColor = UIColor.myColor(dark: #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1), any: .white)
        navigationItem.title = "Информация"

    }
    
    private func addSubViews() {
        view.addSubview(habitLabel)
        view.addSubview(descriptionTextView)
       
    }
    private func viewsLayout() {
        addSubViews()
      let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            habitLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            habitLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            
            descriptionTextView.topAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 12),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
            descriptionTextView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            
        ])
        
    }

}
