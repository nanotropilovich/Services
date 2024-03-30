import UIKit

class ViewController: UIViewController, ViewInterface {
    var presenter: Presenter?
    var services: [Service] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Сервисы"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
           navigationController?.navigationBar.titleTextAttributes = textAttributes
        setupTableView()
        presenter?.viewDidLoad()
    }

    private func setupTableView() {
           view.addSubview(tableView)
           tableView.delegate = self
           tableView.dataSource = self
           tableView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
               tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
               tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ])
       }


    func showServices(_ services: [Service]) {
        DispatchQueue.main.async {
            self.services = services
            self.tableView.reloadData()
        }
    }
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            fatalError("Cell not found")
        }

        let service = services[indexPath.row]
        cell.configure(with: service)
        cell.accessoryType = .disclosureIndicator 
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = services[indexPath.row]
        presenter?.didSelectService(service)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

