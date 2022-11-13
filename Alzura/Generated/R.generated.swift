//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map(Locale.init)
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `README.md`.
    static let readmeMd = Rswift.FileResource(bundle: R.hostingBundle, name: "README", pathExtension: "md")

    /// `bundle.url(forResource: "README", withExtension: "md")`
    static func readmeMd(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.readmeMd
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 2 images.
  struct image {
    /// Image `logout`.
    static let logout = Rswift.ImageResource(bundle: R.hostingBundle, name: "logout")
    /// Image `sort`.
    static let sort = Rswift.ImageResource(bundle: R.hostingBundle, name: "sort")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "logout", bundle: ..., traitCollection: ...)`
    static func logout(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.logout, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sort", bundle: ..., traitCollection: ...)`
    static func sort(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sort, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 2 nibs.
  struct nib {
    /// Nib `LoginViewController`.
    static let loginViewController = _R.nib._LoginViewController()
    /// Nib `OrdersViewController`.
    static let ordersViewController = _R.nib._OrdersViewController()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "LoginViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.loginViewController) instead")
    static func loginViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.loginViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "OrdersViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.ordersViewController) instead")
    static func ordersViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.ordersViewController)
    }
    #endif

    static func loginViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.loginViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func ordersViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.ordersViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 3 localization tables.
  struct string {
    /// This `R.string.login` struct is generated, and contains static references to 1 localization keys.
    struct login {
      /// Value: Username and password is mandatory.
      static let emptyCredentialsError = Rswift.StringResource(key: "emptyCredentialsError", tableName: "Login", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: Username and password is mandatory.
      static func emptyCredentialsError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("emptyCredentialsError", tableName: "Login", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Login", preferredLanguages: preferredLanguages) else {
          return "emptyCredentialsError"
        }

        return NSLocalizedString("emptyCredentialsError", tableName: "Login", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    /// This `R.string.ordersViewController` struct is generated, and contains static references to 0 localization keys.
    struct ordersViewController {
      fileprivate init() {}
    }

    /// This `R.string.orders` struct is generated, and contains static references to 4 localization keys.
    struct orders {
      /// Value: Loading...
      static let loadingMessage = Rswift.StringResource(key: "loadingMessage", tableName: "Orders", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Orders
      static let title = Rswift.StringResource(key: "title", tableName: "Orders", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Pay by
      static let paymentMethod = Rswift.StringResource(key: "paymentMethod", tableName: "Orders", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Price
      static let price = Rswift.StringResource(key: "price", tableName: "Orders", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: Loading...
      static func loadingMessage(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("loadingMessage", tableName: "Orders", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Orders", preferredLanguages: preferredLanguages) else {
          return "loadingMessage"
        }

        return NSLocalizedString("loadingMessage", tableName: "Orders", bundle: bundle, comment: "")
      }

      /// Value: Orders
      static func title(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("title", tableName: "Orders", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Orders", preferredLanguages: preferredLanguages) else {
          return "title"
        }

        return NSLocalizedString("title", tableName: "Orders", bundle: bundle, comment: "")
      }

      /// Value: Pay by
      static func paymentMethod(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("paymentMethod", tableName: "Orders", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Orders", preferredLanguages: preferredLanguages) else {
          return "paymentMethod"
        }

        return NSLocalizedString("paymentMethod", tableName: "Orders", bundle: bundle, comment: "")
      }

      /// Value: Price
      static func price(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("price", tableName: "Orders", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Orders", preferredLanguages: preferredLanguages) else {
          return "price"
        }

        return NSLocalizedString("price", tableName: "Orders", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _LoginViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "LoginViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    struct _OrdersViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "OrdersViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
