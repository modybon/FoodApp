//
//  Delay.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-26.
//

import Foundation
import MapKit
class Delay {
    private var timer: Timer?
    var onFire: (() -> Void)?
    var isRunning: Bool {
        timer != nil && timer!.isValid
    }
    @objc fileprivate func handleTimerEvent() {
        onFire?()
    }
    
    func start(withTimeInterval timeInterval: TimeInterval,
               repeats: Bool = true,
               caller: Any,
               onFire: @escaping () -> Void
               ) {
        guard !isRunning else { return }
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: caller,
                                     selector: #selector(handleTimerEvent),
                                     userInfo: nil, repeats: repeats)
        
        self.onFire = onFire
    }
    
    func stop(){
        timer?.invalidate()
        timer = nil
        onFire = nil
    }
}
