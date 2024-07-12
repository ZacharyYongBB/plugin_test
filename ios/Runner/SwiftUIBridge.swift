//
//  SwiftUIBridge.swift
//  Runner
//
//  Created by Zachary on 13/7/24.
//

import SwiftUI
import Flutter

struct SwiftUIViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let hostingController = UIHostingController(rootView: LocationView())
        return hostingController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
