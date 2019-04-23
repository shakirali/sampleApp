//
//  ViewController.swift
//  DogApp
//
//  Created by Shakir Ali on 13/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import UIKit

protocol ViewControllerConfigurable {
  func configure(withDataProvider: DogDataProviding,
                 localizedDataProvider: LocalizedDataProviding)
}

class VotingViewController: UIViewController {

  @IBOutlet private var imageView: UIImageView!
  @IBOutlet private var activityIndicator: UIActivityIndicatorView!
  @IBOutlet private var name: UILabel!
  @IBOutlet private var breedGroupStackView: UIStackView!
  @IBOutlet private var temperamentStackView: UIStackView!
  @IBOutlet private var originStackView: UIStackView!
  @IBOutlet private var breedGroupTitleLabel: UILabel!
  @IBOutlet private var temperamentTitleLabel: UILabel!
  @IBOutlet private var originTitleLabel: UILabel!
  @IBOutlet private var breedGroupValueLabel: UILabel!
  @IBOutlet private var temperamentValueLabel: UILabel!
  @IBOutlet private var originValueLabel: UILabel!

  //It is assumed that the configure would be called on ViewController before the view is being presented.
  //The configure function would set following providers and viewModels.
  private var dataProvider: DogDataProviding!
  private var localizedDataProvider: LocalizedDataProviding!
  private var votingViewModel: VotingViewModel!
  
  private var currentDog: Dog?
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    fetchData()
  }
  
  private func fetchData() {
    
    activityIndicator.startAnimating()
    
    dataProvider.randomDog { [weak self] result in
  
      guard let self = self else { return }
      
      self.activityIndicator.stopAnimating()
      
      switch result {
      case .success(let dog):
        self.currentDog = dog
        self.votingViewModel.setup(with: dog)
        self.setupControls(for: dog)
        self.configureImageView(for: dog)
      case .failure:
        break
      }
    }
  }
  
  private func setupControls(for dog: Dog) {
    
    name.text = votingViewModel.name
    
    breedGroupStackView.isHidden = votingViewModel.breedGroup == .none
    breedGroupTitleLabel.text = votingViewModel.breedGroupTitle
    breedGroupValueLabel.text = votingViewModel.breedGroup

    temperamentStackView.isHidden = votingViewModel.temperament == .none
    temperamentTitleLabel.text = votingViewModel.temperamentTitle
    temperamentValueLabel.text = votingViewModel.temperament
    
    originStackView.isHidden = votingViewModel.origin == .none
    originTitleLabel.text = votingViewModel.originTitle
    originValueLabel.text = votingViewModel.origin
  }
  
  private func configureImageView(for dog: Dog) {
    
    dataProvider.image(for: dog) { result in
      switch result {
      case .success(let image):
        self.imageView.image = image
      case .failure:
        break
      }
    }
  }
  
  @IBAction func nextBtnTapped() {
    
    imageView.image = nil
    fetchData()
  }
  
  @IBAction func upVoteBtnTapped() {
    
    guard let dog = currentDog else { return }
    upVote(up: true, for: dog)
  }
  
  @IBAction func downVoteBtnTapped() {
    
    guard let dog = currentDog else { return }
    upVote(up: false, for: dog)
  }
  
  private func upVote(up: Bool, for dog: Dog) {
    
    dataProvider.vote(up: up, for: dog.id) { [weak self] result in
      
      guard let self = self else { return }
      
      switch result {
      case .success(let votecast):
        self.displayAlert(message: votecast.message)
      case .failure(let error):
        self.displayAlert(message: error.localizedDescription)
      }
    }
  }
  
  private func displayAlert(message: String) {
    let alert = UIAlertController(title: localizedDataProvider.voteTitle, message: localizedDataProvider.voteSuccessMessage, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: localizedDataProvider.voteAction, style: .default, handler: nil))
    self.present(alert, animated: true)
  }
}


extension VotingViewController: ViewControllerConfigurable {
  
  func configure(withDataProvider dataProvider: DogDataProviding,
                 localizedDataProvider: LocalizedDataProviding) {
    
    self.dataProvider = dataProvider
    self.localizedDataProvider = localizedDataProvider
    votingViewModel = VotingViewModel(localizedProvider: LocalizedDataProvider())
  }
}
