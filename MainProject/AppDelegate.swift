//
//  AppDelegate.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/09.
//

import UIKit
import Firebase
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    let userNotificationCenter = UNUserNotificationCenter.current()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        registerForRemoteNotifications()


        return true
    }

    private func registerForRemoteNotifications() {

            // 1. 푸시 center (유저에게 권한 요청 용도)
            let center = UNUserNotificationCenter.current()
            center.delegate = self // push처리에 대한 delegate - UNUserNotificationCenterDelegate
            let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            center.requestAuthorization(options: options) { (granted, error) in

                guard granted else {
                    return
                }

                DispatchQueue.main.async {
                    // 2. APNs에 디바이스 토큰 등록
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
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

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        print(deviceTokenString)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    // 앱이 foreground상태 일 때, 알림이 온 경우 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        // 푸시가 오면 alert, badge, sound표시를 하라는 의미
        completionHandler([.alert, .badge, .sound])
    }
    //깃허브
}
