import Foundation
import UIKit
class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    private let serviceNameLabel = UILabel()
    private let serviceDescriptionLabel = UILabel()
    private let serviceImageView = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        serviceDescriptionLabel.numberOfLines = 0
        serviceNameLabel.font = UIFont.systemFont(ofSize: 17.5)
        serviceDescriptionLabel.font = UIFont.systemFont(ofSize: 12.2)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout() {
        serviceImageView.translatesAutoresizingMaskIntoConstraints = false
        serviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(serviceImageView)
        contentView.addSubview(serviceNameLabel)
        contentView.addSubview(serviceDescriptionLabel)

        NSLayoutConstraint.activate([
            serviceImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            serviceImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            serviceImageView.widthAnchor.constraint(equalToConstant: 50),
            serviceImageView.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            serviceNameLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 10),
            serviceNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            serviceNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            serviceDescriptionLabel.leadingAnchor.constraint(equalTo: serviceNameLabel.leadingAnchor),
            serviceDescriptionLabel.topAnchor.constraint(equalTo: serviceNameLabel.bottomAnchor, constant: 4),
            serviceDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            serviceDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])

        serviceNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        serviceDescriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    func configure(with service: Service) {
        self.backgroundColor = .black
        serviceNameLabel.text = service.name
        serviceDescriptionLabel.text = service.description
        serviceNameLabel.textColor = .white
        serviceDescriptionLabel.textColor = .white
        if let imageURL = URL(string: service.iconURL) {
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.serviceImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
