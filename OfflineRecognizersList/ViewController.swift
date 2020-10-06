//
//  ViewController.swift
//  OfflineRecognizersList
//
//  Created by Arthur Alvarez on 06/10/20.
//

import UIKit
import Speech

class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var retryButton: UIButton!
    
    // MARK: - Properties
    
    var recognizers: [SFSpeechRecognizer] = []
    
    // MARK: - Actions
    
    @IBAction func retryTapped() {
        fetchOnDeviceRecognizers()
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchOnDeviceRecognizers()
    }
    
    @objc private func fetchOnDeviceRecognizers() {
        activityIndicator.startAnimating()
        retryButton.isEnabled = false
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            // Fetch recognizers available for on-device transcriptions
            let onDeviceRecognizers = SFSpeechRecognizer.supportedLocales().compactMap { SFSpeechRecognizer(locale: $0) }.filter { $0.supportsOnDeviceRecognition }
            
            print("Got \(onDeviceRecognizers.count) on-device recognizers")
            
            DispatchQueue.main.async {
                self?.recognizers = onDeviceRecognizers
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
                self?.retryButton.isEnabled = true
            }
        }
    }
}

// MARK: - UITableView Data Source

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recognizers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = recognizers[indexPath.row].locale.languageCode
        return cell
    }
}
