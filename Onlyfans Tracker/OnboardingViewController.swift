//
//  OnboardingViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/31/24.
//


import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, QuestionViewControllerDelegate {
    func didEnterManagerName(_ managerName: String) {
        
    }
    
    func didTapBackButton() {
        
    }
    

    var questions: [String] = ["Are you a Manager or Model?", "How many models do you have?", "What's your manager's name?"]
    var currentIndex: Int = 0
    
    var userData = UserData(
        uid: "", socialInfo: SocialInfo(instagram: "", twitter: "", onlyFansLink: ""),
        role: nil,
        numberOfModels: nil,
        managerName: nil,
        modelData: nil,
        contactInfo: ContactInfo(email: "", phoneNumber: "")
    )


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "OFM Role"
        dataSource = self
        delegate = self
        showQuestion()
        loadUserData()
    }

    func showQuestion() {
        if currentIndex < questions.count {
            let questionViewController = createQuestionViewController(question: questions[currentIndex])
         //   (questionViewController as? QuestionViewController)?.delegate = self
            setViewControllers([questionViewController], direction: .forward, animated: true, completion: nil)
        } else {
            // Handle completion of onboarding
            // For example, navigate to the main content screen
            print("Onboarding completed!")
        }
    }

    func createQuestionViewController(question: String) -> UIViewController {
        let questionViewController = QuestionViewController()
        questionViewController.question = question
        return questionViewController
    }

    // MARK: - UIPageViewControllerDataSource

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // Implement if needed
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // Implement if needed
        return nil
    }

    // MARK: - QuestionViewControllerDelegate

    func didSelectOption(_ option: String) {
        // Handle user selection
        if option == "Manager" {
            // If Manager is selected, move to the next question
            currentIndex += 1
        } else {
            // If Model is selected, skip to the third question
            currentIndex += 2
        }
        
        // Save user's role in the UserData struct
               userData.role = option

        // Show the next question
        showQuestion()
        
      
    }
    // Call this function when onboarding is completed
     func onboardingCompleted() {
         // Save the userData in UserDefaults
         saveUserData()
         
         // Handle completion of onboarding
         // For example, navigate to the main content screen
         print("Onboarding completed!")
         
         print(saveUserData())
     }
    
    func saveUserData() {
          // Assuming you have an instance of UserData called userData
       //   let userData = //... create an instance of UserData

          // Use UserDataPersistence to save the data
          let userDataPersistence = UserDataPersistence()
        userDataPersistence.saveUserData(userData: userData)

      }

      func loadUserData() {
          // Use UserDataPersistence to load the data
          let userDataPersistence = UserDataPersistence()
          if let loadedUserData = userDataPersistence.loadUserData(for: userData.uid) {
              // Handle the loaded user data as needed
              print(loadedUserData.managerName)
              print(loadedUserData.numberOfModels)
              print(loadedUserData.modelData)
          }
      }
}
