//
//  CustomActivityIndicator.swift
//  Core
//
//  Created by Dimas Wicaksono on 06/01/22.
//

import SwiftUI

public struct CustomActivityIndicator: UIViewRepresentable {
    
    public init() {}

  public func makeUIView(
    context: UIViewRepresentableContext<CustomActivityIndicator>
  ) -> UIActivityIndicatorView {
    return UIActivityIndicatorView(style: .large)
  }
  
  public func updateUIView(
    _ uiView: UIActivityIndicatorView,
    context: UIViewRepresentableContext<CustomActivityIndicator>
  ) {
    uiView.startAnimating()
  }

}
