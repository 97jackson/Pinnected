//
//  UITextFieldRepresentable.swift
//  Pinnected
//
//  Created by Jackson Patrick on 20/04/25.
//

import SwiftUI
import UIKit

struct UITextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String

    // MARK: - Customization
    var placeholder: String = ""
    var placeholderColor: UIColor? = nil
    var placeholderFont: UIFont? = nil
    var textColor: UIColor = .label
    var font: UIFont = .systemFont(ofSize: 16)
    var cursorColor: UIColor = .primaryButtonColor
    var borderStyle: UITextField.BorderStyle = .none
    var contentInset: CGFloat = 0

    // MARK: - Behavior
    var isFirstResponder: Bool = false
    var isSecureTextEntry: Bool = false
    var keyboardType: UIKeyboardType = .default
    var textAlignment: NSTextAlignment = .left
    var autocapitalization: UITextAutocapitalizationType = .sentences
    var returnKeyType: UIReturnKeyType = .default

    // MARK: - Callbacks
    var onCommit: (() -> Void)? = nil
    var onEditingBegan: (() -> Void)? = nil
    var onEditingEnded: (() -> Void)? = nil

    func makeUIView(context: Context) -> UITextField {
//        let textField = InsetTextField(inset: contentInset)
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textChanged(_:)), for: .editingChanged)
        
        configure(textField)
        setClearButtonMode(textField, context)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text

        // Update dynamic styles if needed
        uiView.textColor = textColor
        uiView.font = font
        uiView.textAlignment = textAlignment
        uiView.keyboardType = keyboardType
        uiView.returnKeyType = returnKeyType
        uiView.autocapitalizationType = autocapitalization
        uiView.isSecureTextEntry = isSecureTextEntry
        uiView.borderStyle = borderStyle
        uiView.tintColor = cursorColor
        
        if isFirstResponder && !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        } else if !isFirstResponder && uiView.isFirstResponder {
            uiView.resignFirstResponder()
        }
        
        if uiView.placeholder != placeholder {
            setPlaceholder(uiView)
        }
        uiView.rightViewMode = uiView.text?.isEmpty ?? true ? .never : .whileEditing
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    private func configure(_ textField: UITextField) {
        textField.textColor = textColor
        textField.font = font
        textField.tintColor = cursorColor
        textField.textAlignment = textAlignment
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.autocapitalizationType = autocapitalization
        textField.isSecureTextEntry = isSecureTextEntry
        textField.borderStyle = borderStyle

        setPlaceholder(textField)
    }
    
    private func setClearButtonMode(_ textField: UITextField, _ context: Context) {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(named: "imgClearGray"), for: .normal)
        clearButton.addTarget(context.coordinator, action: #selector(Coordinator.clearButtonTapped(_:)), for: .touchUpInside)
        textField.rightView = clearButton
        textField.rightViewMode = .never
    }

    private func setPlaceholder(_ textField: UITextField) {
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        if let placeholderColor = placeholderColor {
            attributes[.foregroundColor] = placeholderColor
        }
        
        if let placeholderFont = placeholderFont {
            attributes[.font] = placeholderFont
        }

        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: attributes
        )
    }


    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: UITextFieldRepresentable

        init(_ parent: UITextFieldRepresentable) {
            self.parent = parent
        }

        @objc func textChanged(_ sender: UITextField) {
            parent.text = sender.text ?? ""
            sender.rightViewMode = sender.text?.isEmpty ?? true ? .never : .whileEditing
        }
        
        @objc func clearButtonTapped(_ sender: UIButton) {
            parent.text = ""
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.onEditingBegan?()
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.onEditingEnded?()
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.onCommit?()
            textField.resignFirstResponder()
            return true
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.parent.text = textField.text ?? ""
            }
        }
    }
}

// MARK: - Optional InsetTextField
class InsetTextField: UITextField {
    private var textInset: CGFloat

    init(inset: CGFloat) {
        self.textInset = inset
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        self.textInset = 0
        super.init(coder: aDecoder)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: textInset, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: textInset, dy: 0)
    }
}
