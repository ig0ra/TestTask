//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

final class QuotesListViewController: UIViewController {
    
    private let dataManager: IDataManager
    private let tableView = UITableView()
    private var market = Market() {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(dataManager: IDataManager) {
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = market.marketName
        getMarket()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}

private extension QuotesListViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuoteTableViewCell.self)
        tableView.allowsMultipleSelection = false
    }
    
    func getMarket() {
        Task {
            let quotes = try await dataManager.fetchQuotes()
            let market = Market()
            market.quotes = quotes
            self.market = market
        }
    }
}

extension QuotesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        market.quotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let quote = market.quotes?[indexPath.item] else {
            return UITableViewCell()
        }
        
        let isFavoriteQuote = dataManager.isFavorite(quote: quote)

        let cell: QuoteTableViewCell = tableView.dequeueCell(indexPath: indexPath)
        cell.nameLabel.text = quote.name
        cell.lastLabel.text = quote.last
        cell.lastChangePercentLabel.text = quote.readableLastChangePercent
        cell.currencyLabel.text = quote.currency
        cell.setFavoriteImageView(isFavorite: isFavoriteQuote)
        
        if let variantColor = quote.variationColor {
            cell.variantColor = .init(rawValue: variantColor)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let quote = market.quotes?[indexPath.item] else { return }
        let vc = QuoteDetailsViewController(dataManager: dataManager, quote: quote)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

