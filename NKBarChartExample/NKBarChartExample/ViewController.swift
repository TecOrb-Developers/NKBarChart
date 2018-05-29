//
//  ViewController.swift
//  NKBarChartExample
//
//  Created by TecOrb on 29/05/18.
//  Copyright © 2018 Nakul Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var graphContainner : UIView!

    var graphConstraints = [NSLayoutConstraint]()
    var graphView: NKBarChart!
    var decimalPlaces = 2
    var labels = ["Apr 30","May 1","May 2","May 3","May 4","May 5","May 6","May 7","May 8","May 9","May 10","May 11","May 12","May 13","May 14","May 15","May 16","May 17","May 18","May 19","May 20","May 21","May 22","May 23","May 24","May 25","May 26","May 27","May 28","May 29"]
    var data = [12.89,43,44,45.66,66.66,89.98,90.90,54.66,56,56.6,65.67,99,79,66,44,44,5,6,88,23,54.5,66,75,67,6.78,55,67.7,67.66,78.89,90]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createAndSetupGraph(self.graphContainner.frame)
    }





    private func setupConstraints() {
        self.graphView.translatesAutoresizingMaskIntoConstraints = false
        graphConstraints.removeAll()

        let topConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.graphContainner, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.graphContainner, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.graphContainner, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.graphContainner, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        //let heightConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)

        graphConstraints.append(topConstraint)
        graphConstraints.append(bottomConstraint)
        graphConstraints.append(leftConstraint)
        graphConstraints.append(rightConstraint)
        //graphConstraints.append(heightConstraint)
        self.view.addConstraints(graphConstraints)
    }


    func createAndSetupGraph(_ frame: CGRect){
        if self.graphView == nil{
            graphView = NKBarChart(frame: frame)
        }else{
            graphView.removeFromSuperview()
            graphView = NKBarChart(frame: frame)
        }
        graphView.decimalplaces = self.decimalPlaces
        self.graphContainner.addSubview(graphView)
        self.setupConstraints()
        self.setupBarChart(yValues:self.data, labels: self.labels)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController{

    func setupBarChart(yValues:Array<Double>,labels: Array<String>){
        let dataEntries = self.generateDataEntries(dataValues: yValues, labels: labels)
        self.graphView.space = 35
        self.graphView.barWidth = 20.0
        self.graphView.barColor = UIColor.blue
        self.graphView.textFont = UIFont.systemFont(ofSize: 12)
        self.graphView.yValueColor = .black
        self.graphView.labelColor = .black
        self.graphView.dataEntries = dataEntries
    }

    func generateDataEntries(dataValues:Array<Double>,labels:Array<String>) -> [NKBarEntry] {
        var result: [NKBarEntry] = []
        for count in 0..<dataValues.count{
            let height = dataValues[count]/Double(dataValues.max() ?? 0.001)
            result.append(NKBarEntry(height: Float(height), yValue: dataValues[count], title: labels[count]))
        }
        return result
    }

}
