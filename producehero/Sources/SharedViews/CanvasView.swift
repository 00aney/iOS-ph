//
//  CanvasView.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-16.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

final class CanvasView: UIView {
  
  // MARK: Properties
  
  fileprivate var lines: [[CGPoint]] = []
  var signedImage: UIImage?
  
  override func draw(_ rect: CGRect) {
    // custom drawing
    super.draw(rect)
    
    guard let context = UIGraphicsGetCurrentContext() else { return }
    
    context.setStrokeColor(UIColor.black.cgColor)
    context.setLineWidth(8)
    context.setLineCap(.butt)
    
    lines.forEach { (line) in
      for (index, point) in line.enumerated() {
        if index == 0 {
          context.move(to: point)
        } else {
          context.addLine(to: point)
        }
      }
    }
    
    context.strokePath()
    setNeedsDisplay()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    lines.append([CGPoint]())
  }
  
  // track the finger as user move across screen
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let point = touches.first?.location(in: nil),
      var lastLine = lines.popLast() else { return }
    
    lastLine.append(point)
    lines.append(lastLine)
    
    setNeedsDisplay()
  }
  
  
  // public functions
  
  func clear() {
    lines.removeAll()
    setNeedsDisplay()
  }
  
  func save() -> UIImage? {
    let renderer = UIGraphicsImageRenderer(size: bounds.size)
    signedImage = renderer.image(actions: { context in
      drawHierarchy(in: bounds, afterScreenUpdates: true)
    })
    
    return signedImage
  }
}
