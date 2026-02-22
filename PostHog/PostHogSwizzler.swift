//
//  PostHogSwizzler.swift
//  PostHog
//
//  Created by Manoel Aranda Neto on 26.03.24.
//

import Foundation

func swizzle(forClass: AnyClass, original: Selector, new: Selector) {
    guard let originalMethod = class_getInstanceMethod(forClass, original),
          let swizzledMethod = class_getInstanceMethod(forClass, new) else { return }

    if class_addMethod(forClass, original, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
        class_replaceMethod(forClass, new, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

func addMethod(forClass: AnyClass, selector: Selector, implementation: IMP, types: String) {
    class_addMethod(forClass, selector, implementation, types)
}
