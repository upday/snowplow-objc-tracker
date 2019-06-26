//
//  SnowplowTracker.swift
//  SnowplowSwiftDemo
//
//  Created by Michael Hadam on 6/21/19.
//  Copyright © 2019 snowplowanalytics. All rights reserved.
//

import Foundation
import SnowplowTracker

protocol AnalyticsSubscriber {
    func respondToEventSending(successes: Int, failures: Int)
}

class Analytics: NSObject, SPRequestCallback {
    
    static let sharedInstance: Analytics = Analytics()
    private var emitter: SPEmitter?
    private var tracker: SPTracker?
    private var subject: SPSubject?
    private var uri: String = ""
    private var protocolType: SPProtocol = .https
    private var methodType: SPRequestOptions = .post
    private var subscribers: Array<AnalyticsSubscriber> = [AnalyticsSubscriber]()
    static public var successCount: Int = 0
    static public var failureCount: Int = 0
    
    override private init() {
        super.init()
        self.emitter = SPEmitter.build({ [weak self] (builder : SPEmitterBuilder?) -> Void in
            builder!.setUrlEndpoint("0.0.0.0")
            builder!.setHttpMethod(.post)
            builder!.setCallback(self)
            builder!.setEmitRange(500)
            builder!.setEmitThreadPoolSize(2)
            builder!.setByteLimitPost(52000)
            builder!.setProtocol(.https)
        })
        self.subject = SPSubject(platformContext: true, andGeoContext: false)
        self.tracker = SPTracker.build { [weak self] (builder : SPTrackerBuilder?) -> Void in
            builder!.setAppId("iOSDemo")
            builder!.setTrackerNamespace("Snowplow")
            builder!.setBase64Encoded(false)
            builder!.setSessionContext(true)
            builder!.setSubject(self?.subject)
            builder!.setLifecycleEvents(true)
            builder!.setAutotrackScreenViews(false)
            builder!.setScreenContext(false)
            builder!.setApplicationContext(true)
            builder!.setExceptionEvents(true)
            builder!.setInstallEvent(true)
            builder!.setEmitter(self?.emitter)
        }
    }
    
    internal func onSuccess(withCount successCount: Int) {
        NSLog("Sent %ul successfully", successCount)
        Analytics.successCount += successCount
        for subscriber in subscribers {
            subscriber.respondToEventSending(successes: successCount, failures: 0)
        }
    }
    
    internal func onFailure(withCount failureCount: Int, successCount: Int) {
        NSLog("Failed to send %ul", failureCount)
        Analytics.failureCount += failureCount
        if successCount > 0 {
            NSLog("%ul", successCount)
            Analytics.successCount += successCount
        }
        for subscriber in subscribers {
            subscriber.respondToEventSending(successes: successCount, failures: failureCount)
        }
    }
    
    static func subscribe(subscriber: AnalyticsSubscriber) {
        Analytics.sharedInstance.subscribers.append(subscriber)
    }
    
    static func getTracker() -> SPTracker? {
        return Analytics.sharedInstance.tracker
    }
    
    static func getEmitter() -> SPEmitter? {
        return Analytics.sharedInstance.emitter
    }
    
    static func getCollectorUrl() -> String {
        let emitter = Analytics.getEmitter()
        if emitter?.urlEndpoint.host != nil {
            if emitter?.urlEndpoint.port != nil {
                return (emitter?.urlEndpoint.host)! + "\((emitter?.urlEndpoint.port)!)"
            } else {
                return (emitter?.urlEndpoint.host)!
            }
        }
        return ""
    }
    
    static func updateProtocol(protocolType: SPProtocol) {
        Analytics.sharedInstance.emitter?.setProtocol(protocolType)
    }
    
    static func updateMethod(methodType: SPRequestOptions) {
        Analytics.sharedInstance.emitter?.setHttpMethod(methodType)
    }
    
    static func updateURI(uri: String) {
        Analytics.sharedInstance.uri = uri
        Analytics.sharedInstance.emitter?.setUrlEndpoint(uri)
    }
}
