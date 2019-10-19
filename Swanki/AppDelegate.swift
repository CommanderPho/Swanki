// Copyright © 2019 Brian's Brain. All rights reserved.

import Logging
import UIKit

private let logger: Logger = {
  var logger = Logger(label: "org.brians-brain.Swanki")
  logger.logLevel = .debug
  return logger
}()

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    LoggingSystem.bootstrap(StreamLogHandler.standardError)
    let directory = ("~/Documents" as NSString).expandingTildeInPath
    logger.info("Documents directory: \(directory)")
    if let url = Bundle.main.url(forResource: "AncientHistory", withExtension: "apkg", subdirectory: "SampleData") {
      do {
        let tempFile = try Importer.importPackage(url)
        logger.info("Extracted database to \(tempFile.fileURL)")
        try tempFile.deleteDirectory()
      } catch {
        logger.error("Unexpected error importing package: \(error)")
      }
    }
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
}
