//
//  TweakLibrary.swift
//  SwiftTweaks
//
//  Created by Bryan Clark on 11/6/15.
//  Copyright © 2015 Khan Academy. All rights reserved.
//

import Foundation

/// Create a public struct in your application that conforms to this protocol to declare your own tweaks!
public protocol TweakLibraryType {
	static var defaultStore: TweakStore { get }
}

public extension TweakLibraryType {
	/// Returns the current value for a tweak from the TweakLibrary's default store.
	static func assign<T>(_ tweak: Tweak<T>) -> T {
		return self.defaultStore.currentValueForTweak(tweak)
	}

	/// Immediately binds the currentValue of a given tweak, and then continues to update whenever the tweak changes.
    static func bind<T>(_ tweak: Tweak<T>, observeInitialValue: Bool = true, binding: @escaping (T) -> Void) -> TweakBindingIdentifier {
        return self.defaultStore.bind(tweak, observerInitialValue: observeInitialValue, binding: binding)
	}

	/// Unbinds the identified binding, stops delivering updates and releases the closure.
	static func unbind(identifier: TweakBindingIdentifier) {
		self.defaultStore.unbind(identifier)
	}

	//  Accepts a collection of Tweaks, and immediately calls the updateHandler.
	/// The updateHandler is then re-called each time any of the collection's tweaks change.
	/// Inside the updateHandler, you'll need to use `assign` to get the tweaks' current values.
    static func bindMultiple(_ tweaks: [TweakType], observeInitialValue: Bool = true, binding: @escaping () -> Void) -> MultiTweakBindingIdentifier {
		return self.defaultStore.bindMultiple(tweaks, observeInitialValue: observeInitialValue, binding: binding)
	}

	/// Unbinds the identified binding, stops delivering updates and releases the closure.
	static func unbindMultiple(identifier: MultiTweakBindingIdentifier) {
		self.defaultStore.unbindMultiple(identifier)
	}
}
