//
//  OnboardingViewController.swift
//  Onlyfans Tracker
//
//  Created by Karon Bell on 1/31/24.
//


import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, QuestionViewControllerDelegate {
    func didTapBackButton() {
        
    }
    

    var questions: [String] = ["Are you a Manager or Model?", "How many models do you have?", "What's your manager's name?"]
    var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "OFM Role"
        dataSource = self
        delegate = self
        showQuestion()
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

        // Show the next question
        showQuestion()
    }
}
