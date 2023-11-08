//
//  MobFlowSdk_SwiftUIApp.swift
//  MobFlowSdk-SwiftUI
//
//  Created by Vishnu  on 08/11/23.
//

import SwiftUI
import MobFlowiOS

@main
struct MobFlowSdk_SwiftUIApp: App {
    @StateObject var appEnvironment = AppEnvironment()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}

class AppEnvironment: ObservableObject {
    var mobflow: MobiFlowSwift?

    static let shared = AppEnvironment()

    init() {
        // Initialize MobFlow with necessary parameters
        let oneSignalToken = "1961112e-0d5b-450a-ad78-cc84eecb464c"
        let appLovinKey = "gvcyZqhgCmHnI7I-DHWLXoVhQkrqbHzcltIZAATT0RH-cWpBip16xde9wnuZq-I0CTLsqKAoe6z7U_6TdF12bx"
        let bannerID = "f59c6bf373839e72"
        let interestialID = "4a96308674bab468"
        let rewardedID = "1c2d16d6eb65dedf"
        let appOpenAdID = "f519fab40e5eba7e"
        
        self.mobflow = MobiFlowSwift(initDelegate: self, oneSignalToken: oneSignalToken, appLovinKey: appLovinKey, bannerId: bannerID, interestialId: interestialID, rewardedId: rewardedID, appOpenAdId: appOpenAdID, launchOptions: nil)
        // Note: launchOptions might need to be handled differently in SwiftUI
    }
    
   

    func showBannerAd() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let mainWindow = windowScene.windows.first
            // Use 'mainWindow' as needed
            if let rootVC = mainWindow?.rootViewController {
                mobflow?.showBannerAd(vc: rootVC)
            }
        }
    }

    func showInterestialAd(onClose: @escaping (Bool) -> Void) {
        mobflow?.showInterestialAd(onClose: onClose)
    }

    func showRewardedAd(onClose: @escaping (Bool) -> Void) {
        mobflow?.showRewardedAd(onClose: onClose)
    }
}


extension AppEnvironment: MobiFlowDelegate {
    func present(dic: [String : Any]) {
        
        DispatchQueue.main.async { [self] in
            //Here once the MobFlow SDK is loaded, and present delegate is called, show here intro/main app content in main thread.
            debugPrint("--------------- MobiFlowDelegate present called ---------------")

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let mainWindow = windowScene.windows.first
                // Use 'mainWindow' as needed
                
                let vc = UIHostingController(rootView: ContentView().environmentObject(self))
                mainWindow?.rootViewController = vc
                mainWindow?.makeKeyAndVisible()
                
            }

        }
    }

    func unloadUnityOnNotificationClick() {
        // Handle unloading Unity on notification click.
    }
}

struct SplashView: View {
    @State var toContent: Bool = false
    var body: some View {
        ZStack{
            Image("splash")
                .resizable()
                .aspectRatio( contentMode: .fill)
                .ignoresSafeArea(edges: .all)
        }
       
    }
}
