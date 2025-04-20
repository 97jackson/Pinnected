//
//  ViewControllerHolder.swift
//  Pinnected
//
//  Created by Jackson Patrick on 20/04/25.
//

import SwiftUI

struct ViewControllerHolder {
    weak var value: UIViewController?
    
    init(_ value: UIViewController?) {
        self.value = value
    }
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder { return ViewControllerHolder(UIApplication.shared.windows.first?.rootViewController ) }
}

extension EnvironmentValues {
    var viewController: ViewControllerHolder {
        get { return self[ViewControllerKey.self] }
        set { self[ViewControllerKey.self] = newValue }
    }
}

extension ViewControllerHolder {
    func present<Content: View>(style: UIModalPresentationStyle = .overCurrentContext,
                                transitionStyle: UIModalTransitionStyle = .coverVertical,
                                animated: Bool = true,
                                completion: @escaping () -> Void = {},
                                @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = UIColor.clear
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, ViewControllerHolder(toPresent))
        )
        DispatchQueue.main.async {
            self.value?.present(toPresent, animated: animated, completion: completion)
        }
    }
    
    func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
        value?.dismiss(animated: animated, completion: completion)
    }
}

