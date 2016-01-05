//
//  ViewController.swift
//  TicTacToeApp
//
//  Created by Spencer Carvill on 12/28/15.
//  Copyright © 2015 scarvill. All rights reserved.
//

import UIKit

public class ViewController: UIViewController {
  var mark = "X"

  override public func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBOutlet weak var boardButton0: UIButton!

  @IBAction public func makeMove(button: UIButton) {
    button.setTitle(mark, forState: UIControlState.Normal)
    mark = toggleMark(mark)
    button.enabled = false
  }

  private func toggleMark(mark: String) -> String {
    return mark == "X" ? "O" : "X"
  }
}

