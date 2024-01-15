
import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var progress: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = .darkPurpleColor
        progress.trackTintColor = .systemGray2
        progress.translatesAutoresizingMaskIntoConstraints = false
        
        return progress
    }()
    
    private lazy var motivationLabel: UILabel = {
        let motivationLabel = UILabel()
        motivationLabel.text = "Все получится!"
//        motivationLabel.font = UIFont(name: "SFProText-Semibold", size: 13)
        motivationLabel.font = UIFont.systemFont( ofSize: 17, weight: .medium)
        motivationLabel.textColor = .systemGray2
        motivationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return motivationLabel
    }()
    
    private lazy var procentLabel: UILabel = {
        let procentLabel = UILabel()
        procentLabel.translatesAutoresizingMaskIntoConstraints = false
        procentLabel.textColor = .systemGray2
        procentLabel.font = UIFont(name: "SFProText-Semibold", size: 13)
        
        return procentLabel
    }()
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        addSubViews()
        viewsLayout()
//        backgroundColor = UIColor.white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    
    private func addSubViews() {
        contentView.addSubview(motivationLabel)
        contentView.addSubview(procentLabel)
        contentView.addSubview(progress)

    }
    
    private func viewsLayout() {
        addSubViews()
        NSLayoutConstraint.activate([
                    
            motivationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            motivationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            procentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            procentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            progress.topAnchor.constraint(equalTo: motivationLabel.bottomAnchor, constant: 8),
            progress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            progress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            progress.heightAnchor.constraint(equalToConstant: 8),
            
        ])
    }
    
    func configureProgresscCell() {
        progress.progress = HabitsStore.shared.todayProgress
        procentLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100)) %"

    }
    
}
