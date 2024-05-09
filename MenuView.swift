//
//  MenuView.swift
//  iOS-A3-Fitness Challenge
//
//  Created by miles peter on 8/5/2024.
//
import UIKit
import SwiftUI

class MenuView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set background image
        addBackground()
        
        // Add title label
        let titleLabel = UILabel()
        titleLabel.text = "Run Tracker"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 20, y: 50, width: view.bounds.width - 40, height: 40)
        view.addSubview(titleLabel)
        
        // Create squares for the first 6 buttons
        let squareSize: CGFloat = 80
        let squareSpacing: CGFloat = 20
        let totalWidth = 3 * squareSize + 2 * squareSpacing  // Total width of 3 squares with 2 spacings
        let xOffset = (view.bounds.width - totalWidth) / 2   // Calculate starting x-position
        
        let yOffset: CGFloat = 150
        
        for (index, distance) in ["5k", "10k", "20k", "Marathon", "Sprints", "Walk & Run"].enumerated() {
            let buttonFrame = CGRect(x: xOffset + CGFloat(index % 3) * (squareSize + squareSpacing),
                                     y: yOffset + CGFloat(index / 3) * (squareSize + squareSpacing),
                                     width: squareSize, height: squareSize)
            let squareView = UIView(frame: buttonFrame)
            squareView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            squareView.layer.cornerRadius = 10
            view.addSubview(squareView)
            
            let button = UIButton(type: .system)
            button.setTitle(distance, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.setTitleColor(.white, for: .normal)
            button.frame = buttonFrame
            view.addSubview(button)
            
            // Customize editable buttons (first three)
            if index < 3 {
                button.addTarget(self, action: #selector(editDistance(_:)), for: .touchUpInside)
            }
        }
        
        // Create "Start run" button
        let startButton = createButton(title: "Start run", yPosition: yOffset + 3 * (squareSize + squareSpacing), height: 60)
        view.addSubview(startButton)
        
        // Create "Routes" button
        let routesButton = createButton(title: "Routes", yPosition: startButton.frame.maxY + squareSpacing, height: 60)
        view.addSubview(routesButton)
        
        let statsButton = UIButton(type: .system)
               statsButton.setTitle("Stats", for: .normal)
               statsButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
               statsButton.setTitleColor(.white, for: .normal)
               statsButton.frame = CGRect(x: 20, y: view.bounds.height - 100, width: view.bounds.width - 40, height: 40)
               statsButton.addTarget(self, action: #selector(openStats), for: .touchUpInside)
               view.addSubview(statsButton)
    }
    @objc func openStats() {
           // Navigate to StatsView using SwiftUI Navigation
           let statsView = StatsView()
           let hostingController = UIHostingController(rootView: statsView)
           navigationController?.pushViewController(hostingController, animated: true)
       }
    
    // Helper function to create custom buttons
    private func createButton(title: String, yPosition: CGFloat, height: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 20, y: yPosition, width: view.bounds.width - 40, height: height)
        return button
    }
    
    // Function to handle editing of custom distances
    @objc func editDistance(_ sender: UIButton) {
        // Implement custom distance editing logic here
        // For example, show a text field for the user to input a new distance
    }
    
    // Function to add background image
    func addBackground() {
        guard let image = UIImage(named: "home_background") else {
            print("Error: Unable to load background image")
            return
        }
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }
}
