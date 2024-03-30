import Foundation
class Presenter: InteractorOutput {
       weak var view: ViewInterface?
       var interactor: InteractorInput?
       var router: RouterInput?
    func viewDidLoad() {
           interactor?.fetchServices()
    }
    func servicesFetched(_ services: [Service]) {
        view?.showServices(services)
    }

    func servicesFetchFailed(_ error: Error) {
        view?.showError(error)
    }

    func didSelectService(_ service: Service) {
        router?.navigateToService(service.link)
    }
}
