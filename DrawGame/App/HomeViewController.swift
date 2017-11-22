import UIKit

class HomeViewController: UIViewController {
    
    fileprivate struct Geometry {
        struct CreateGameButton {
            static let topOffset: CGFloat = 20.0
            static let height: CGFloat = 70.0
            static let horizontalInset: CGFloat = 20.0
            static let cornerRadius: CGFloat = 10.0
            static let borderWidth: CGFloat = 3.0
            static let fontSize: CGFloat = 20.0
        }
        
        struct FindGameButton {
            static let topOffset: CGFloat = 20.0
            static let height: CGFloat = 70.0
            static let horizontalInset: CGFloat = 20.0
            static let cornerRadius: CGFloat = 10.0
            static let borderWidth: CGFloat = 3.0
            static let fontSize: CGFloat = 20.0
        }
        
        struct TableView {
            static let topOffset: CGFloat = 20.0
        }
    }
    
    fileprivate struct Colors {
        static let createGameButtonText = UIColor(red: 0.0, green: 0.10, blue: 0.05, alpha: 1.0)
        static let createGameButtonBackground = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
        static let createGameButtonBorder = UIColor(red: 0.0, green: 0.10, blue: 0.05, alpha: 1.0)
        static let findGameButtonText = UIColor(red: 0.0, green: 0.05, blue: 0.1, alpha: 1.0)
        static let findGameButtonBackground = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        static let findGameButtonBorder = UIColor(red: 0.0, green: 0.05, blue: 0.1, alpha: 1.0)
        static let spinner = Theme.Colors.main
        static let background = Theme.Colors.background
    }
    
    fileprivate struct ReuseId {
        static let gameCell = "GameTableViewCell"
    }
    
    fileprivate let data = HomeData()
    
    fileprivate let createGameButton = UIButton()
    fileprivate let findGameButton = UIButton()
    fileprivate let tableView = UITableView()
    fileprivate let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        updateUI()
    }
    
    fileprivate func initialSetup() {
        view.backgroundColor = Theme.Colors.background
        
        // Title
        title = "DrawGame"
        
        /* Refresh Button */
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self,
                                   action: #selector(refreshButtonPressed))
        navigationItem.rightBarButtonItem = refreshItem
        
        // create game button
        view.addSubview(createGameButton)
        createGameButton.backgroundColor = Colors.createGameButtonBackground
        createGameButton.layer.borderColor = Colors.createGameButtonBorder.cgColor
        createGameButton.layer.borderWidth = Geometry.CreateGameButton.borderWidth
        createGameButton.layer.cornerRadius = Geometry.CreateGameButton.cornerRadius
        createGameButton.layer.masksToBounds = true
        createGameButton.snp.makeConstraints { make in
            make.topMargin.equalTo(view).offset(Geometry.CreateGameButton.topOffset)
            make.left.right.equalTo(view).inset(Geometry.CreateGameButton.horizontalInset)
            make.height.equalTo(Geometry.CreateGameButton.height)
        }
        createGameButton.addTarget(self, action: #selector(createGameButtonPressed),
                                   for: .touchUpInside)
        
        let createGameButtonTitle = AttributedStringMake { (attrs, ctx) in
            attrs.font = UIFont.systemFont(ofSize: Geometry.CreateGameButton.fontSize)
            attrs.foregroundColor = Colors.createGameButtonText
            attrs.alignment = .center
            ctx.append("Crear nuevo juego")
        }
        createGameButton.setAttributedTitle(createGameButtonTitle, for: .normal)
        
        // find game button
        view.addSubview(findGameButton)
        findGameButton.backgroundColor = Colors.findGameButtonBackground
        findGameButton.layer.borderColor = Colors.findGameButtonBorder.cgColor
        findGameButton.layer.borderWidth = Geometry.FindGameButton.borderWidth
        findGameButton.layer.cornerRadius = Geometry.FindGameButton.cornerRadius
        findGameButton.layer.masksToBounds = true
        findGameButton.snp.makeConstraints { make in
            make.top.equalTo(createGameButton.snp.bottom).offset(Geometry.FindGameButton.topOffset)
            make.left.right.equalTo(view).inset(Geometry.FindGameButton.horizontalInset)
            make.height.equalTo(Geometry.FindGameButton.height)
        }
        findGameButton.addTarget(self, action: #selector(findGameButtonPressed),
                                   for: .touchUpInside)
        
        let findGameButtonTitle = AttributedStringMake { (attrs, ctx) in
            attrs.font = UIFont.systemFont(ofSize: Geometry.FindGameButton.fontSize)
            attrs.foregroundColor = Colors.findGameButtonText
            attrs.alignment = .center
            ctx.append("Buscar juego existente")
        }
        findGameButton.setAttributedTitle(findGameButtonTitle, for: .normal)
        
        // table view
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(findGameButton.snp.bottom).offset(Geometry.TableView.topOffset)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView() // hides unused cells
        tableView.estimatedRowHeight = 70
        tableView.backgroundColor = Colors.background
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(GameTableViewCell.self,
                           forCellReuseIdentifier: ReuseId.gameCell)
        
        // spinner
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        spinner.hidesWhenStopped = true
        spinner.color = Colors.spinner
    }
    
    fileprivate func updateUI() {
        spinner.startAnimating()
        data.reload { [weak self] in
            self?.spinner.stopAnimating()
            self?.tableView.reloadData()
        }
    }
    
    @objc fileprivate func refreshButtonPressed() {
        updateUI()
    }
    
    @objc fileprivate func createGameButtonPressed() {
        presentGameViewController(game: nil)
    }
    
    @objc fileprivate func findGameButtonPressed() {
        HomeData.findGame { game in
            guard let game = game else {
                // TODO: message, could not find game
            }
            presentGameViewController(game: game)
        }
    }
    
    fileprivate func presentGameViewController(game: Game?) {
        let gameViewController = GameViewController(game: game)
        gameViewController.delegate = self
        navigationController?.pushViewController(gameViewController, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return data.myTurnGames.count
        case 1:
            return data.notMyTurnGames.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseId.gameCell, for: indexPath)
        
        guard let game = game(forIndexPath: indexPath) else { return cell }
        
        if let gameCell = cell as? GameTableViewCell {
            gameCell.game = game
        }
        
        return cell
    }
    
    fileprivate func game(forIndexPath indexPath: IndexPath) -> Game? {
        switch indexPath.section {
        case 0: // my turn
            guard indexPath.row < data.myTurnGames.count else { return nil }
            
            return data.myTurnGames[indexPath.row]
            
        case 1: // not my turn
            guard indexPath.row < data.notMyTurnGames.count else { return nil }
            
            return data.notMyTurnGames[indexPath.row]
            
        default:
            return nil
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let game = self.game(forIndexPath: indexPath) else { return }
        
        presentGameViewController(game: game)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Es tu turno"
        case 1:
            return "Esperando tu turno"
        default:
            return nil
        }
    }
}








