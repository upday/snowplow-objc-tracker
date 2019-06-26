//
//  DemoUtils.swift
//  SnowplowSwiftDemo
//
//  Created by Michael Hadam on 1/19/18.
//  Copyright © 2018 snowplowanalytics. All rights reserved.
//

import Foundation
import SnowplowTracker

class DemoUtils {
    static func trackAll() {
        self.trackPageView()
        //self.trackScreenView()
        self.trackStructuredEvent()
        self.trackUnstructuredEvent()
        self.trackTimingWithCategory()
        self.trackEcommerceTransaction()
        self.trackPushNotification()
    }
    
    static func trackPageView() {
        let tracker = Analytics.getTracker()
        let event = SPPageView.build { (builder: SPPageViewBuilder?) -> Void in
            builder!.setPageTitle("pageTitle")
            builder!.setPageUrl("pageUrl")
            builder!.setReferrer("demoReferrer")
        }
        tracker?.trackPageViewEvent(event)
    }
    
    static func trackStructuredEvent() {
        let tracker = Analytics.getTracker()
        var event = SPStructured.build({ (builder : SPStructuredBuilder?) -> Void in
            builder!.setCategory("DemoCategory")
            builder!.setAction("DemoAction")
            builder!.setLabel("DemoLabel")
            builder!.setProperty("DemoProperty")
            builder!.setValue(5)
        })
        tracker?.trackStructuredEvent(event)
        
        event = SPStructured.build({ (builder : SPStructuredBuilder?) -> Void in
            builder!.setCategory("DemoCategory")
            builder!.setAction("DemoAction")
            builder!.setLabel("DemoLabel")
            builder!.setProperty("DemoProperty")
            builder!.setValue(5)
            builder!.setTimestamp(1243567890)
        })
        tracker?.trackStructuredEvent(event)
        
        event = SPStructured.build({ (builder : SPStructuredBuilder?) -> Void in
            builder!.setCategory("DemoCategory")
            builder!.setAction("DemoAction")
            builder!.setLabel("DemoLabel")
            builder!.setProperty("DemoProperty")
            builder!.setValue(5)
            builder!.setContexts(self.getCustomContext())
        })
        tracker?.trackStructuredEvent(event)
        
        event = SPStructured.build({ (builder : SPStructuredBuilder?) -> Void in
            builder!.setCategory("DemoCategory")
            builder!.setAction("DemoAction")
            builder!.setLabel("DemoLabel")
            builder!.setProperty("DemoProperty")
            builder!.setValue(5)
            builder!.setTimestamp(1243567890)
        })
        tracker?.trackStructuredEvent(event)
    }
    
    // these will be BAD events since schema doesn't exist
    static func trackUnstructuredEvent() {
        let tracker = Analytics.getTracker()
        let data: NSDictionary = [ "level": 23, "score": 56473]
        let sdj = SPSelfDescribingJson(schema: "iglu:com.acme_company/demo_ios_event/jsonschema/1-0-0", andData: data);
        var event = SPUnstructured.build({ (builder : SPUnstructuredBuilder?) -> Void in
            builder!.setEventData(sdj!)
        })
        tracker?.trackUnstructuredEvent(event)
        
        event = SPUnstructured.build({ (builder : SPUnstructuredBuilder?) -> Void in
            builder!.setEventData(sdj!)
            builder!.setContexts(self.getCustomContext())
        })
        tracker?.trackUnstructuredEvent(event)
        
        event = SPUnstructured.build({ (builder : SPUnstructuredBuilder?) -> Void in
            builder!.setEventData(sdj)
            builder!.setTimestamp(1243567890)
            builder!.setContexts(self.getCustomContext())
        })
        tracker?.trackUnstructuredEvent(event)
        
        event = SPUnstructured.build({ (builder : SPUnstructuredBuilder?) -> Void in
            builder!.setEventData(sdj)
            builder!.setTimestamp(1243567890)
        })
        
        tracker?.trackUnstructuredEvent(event)
    }
    
    /*static func trackScreenView(_ tracker: SPTracker) {
        var event = SPScreenView.build({ (builder : SPScreenViewBuilder?) -> Void in
            builder!.setName("DemoScreenName")
            builder!.setId("DemoScreenId")
        })
        tracker.trackScreenViewEvent(event)
        
        event = SPScreenView.build({ (builder : SPScreenViewBuilder?) -> Void in
            builder!.setName("DemoScreenName")
            builder!.setId("DemoScreenId")
            builder!.setTimestamp(1243567890)
        })
        tracker.trackScreenViewEvent(event)
        
        event = SPScreenView.build({ (builder : SPScreenViewBuilder?) -> Void in
            builder!.setName("DemoScreenName")
            builder!.setId("DemoScreenId")
            builder!.setContexts(self.getCustomContext())
        })
        tracker.trackScreenViewEvent(event)
        
        event = SPScreenView.build({ (builder : SPScreenViewBuilder?) -> Void in
            builder!.setName("DemoScreenName")
            builder!.setId("DemoScreenId")
            builder!.setContexts(self.getCustomContext())
            builder!.setTimestamp(1243567890)
        })

        tracker.trackScreenViewEvent(event)
    }*/
    
    static func trackTimingWithCategory() {
        let tracker = Analytics.getTracker()
        var event = SPTiming.build({ (builder : SPTimingBuilder?) -> Void in
            builder!.setCategory("DemoTimingCategory")
            builder!.setVariable("DemoTimingVariable")
            builder!.setTiming(5)
            builder!.setLabel("DemoTimingLabel")
        })
        tracker?.trackTimingEvent(event)
        
        event = SPTiming.build({ (builder : SPTimingBuilder?) -> Void in
            builder!.setCategory("DemoTimingCategory")
            builder!.setVariable("DemoTimingVariable")
            builder!.setTiming(5)
            builder!.setLabel("DemoTimingLabel")
            builder!.setTimestamp(1243567890)
        })
        tracker?.trackTimingEvent(event)
        
        event = SPTiming.build({ (builder : SPTimingBuilder?) -> Void in
            builder!.setCategory("DemoTimingCategory")
            builder!.setVariable("DemoTimingVariable")
            builder!.setTiming(5)
            builder!.setLabel("DemoTimingLabel")
            builder!.setContexts(self.getCustomContext())
        })
        tracker?.trackTimingEvent(event)
        
        event = SPTiming.build({ (builder : SPTimingBuilder?) -> Void in
            builder!.setCategory("DemoTimingCategory")
            builder!.setVariable("DemoTimingVariable")
            builder!.setTiming(5)
            builder!.setLabel("DemoTimingLabel")
            builder!.setTimestamp(1243567890)
            builder!.setContexts(self.getCustomContext())
        })
        
        tracker?.trackTimingEvent(event)
    }
    
    static func trackEcommerceTransaction() {
        let tracker = Analytics.getTracker()
        let transactionID = "6a8078be"
        let itemArray : [Any] = [ SPEcommerceItem.build({ (builder : SPEcommTransactionItemBuilder?) -> Void in
            builder!.setItemId(transactionID)
            builder!.setSku("DemoItemSku")
            builder!.setName("DemoItemName")
            builder!.setCategory("DemoItemCategory")
            builder!.setPrice(0.75)
            builder!.setQuantity(1)
            builder!.setCurrency("USD")
        }) ]
        
        var event = SPEcommerce.build({ (builder : SPEcommTransactionBuilder?) -> Void in
            builder!.setOrderId(transactionID)
            builder!.setTotalValue(350)
            builder!.setAffiliation("DemoTransactionAffiliation")
            builder!.setTaxValue(10)
            builder!.setShipping(15)
            builder!.setCity("Boston")
            builder!.setState("Massachusetts")
            builder!.setCountry("USA")
            builder!.setCurrency("USD")
            builder!.setItems(itemArray)
        })
        tracker?.trackEcommerceEvent(event)
        
        event = SPEcommerce.build({ (builder : SPEcommTransactionBuilder?) -> Void in
            builder!.setOrderId(transactionID)
            builder!.setTotalValue(350)
            builder!.setAffiliation("DemoTransactionAffiliation")
            builder!.setTaxValue(10)
            builder!.setShipping(15)
            builder!.setCity("Boston")
            builder!.setState("Massachusetts")
            builder!.setCountry("USA")
            builder!.setCurrency("USD")
            builder!.setItems(itemArray)
            builder!.setTimestamp(1243567890)
        })
        tracker?.trackEcommerceEvent(event)
        
        event = SPEcommerce.build({ (builder : SPEcommTransactionBuilder?) -> Void in
            builder!.setOrderId(transactionID)
            builder!.setTotalValue(350)
            builder!.setAffiliation("DemoTransactionAffiliation")
            builder!.setTaxValue(10)
            builder!.setShipping(15)
            builder!.setCity("Boston")
            builder!.setState("Massachusetts")
            builder!.setCountry("USA")
            builder!.setCurrency("USD")
            builder!.setItems(itemArray)
            builder!.setContexts(self.getCustomContext())
        })
        tracker?.trackEcommerceEvent(event)
        
        event = SPEcommerce.build({ (builder : SPEcommTransactionBuilder?) -> Void in
            builder!.setOrderId(transactionID)
            builder!.setTotalValue(350)
            builder!.setAffiliation("DemoTransactionAffiliation")
            builder!.setTaxValue(10)
            builder!.setShipping(15)
            builder!.setCity("Boston")
            builder!.setState("Massachusetts")
            builder!.setCountry("USA")
            builder!.setCurrency("USD")
            builder!.setItems(itemArray)
            builder!.setContexts(self.getCustomContext())
            builder!.setTimestamp(1243567890)
        })

        tracker?.trackEcommerceEvent(event)
    }

    static func trackPushNotification() {
        let tracker = Analytics.getTracker()
        let attachments = [["identifier": "testidentifier",
                            "url": "testurl",
                            "type": "testtype"]]

        var userInfo = Dictionary<String, Any>()
        userInfo["test"] = "test"

        let content = SPNotificationContent.build({(builder : SPNotificationContentBuilder?) -> Void in
            builder!.setTitle("title")
            builder!.setSubtitle("subtitle")
            builder!.setBody("body")
            builder!.setBadge(5)
            builder!.setSound("sound")
            builder!.setLaunchImageName("launchImageName")
            builder!.setUserInfo(userInfo)
            builder!.setAttachments(attachments)
        })

        let event = SPPushNotification.build({(builder : SPPushNotificationBuilder?) -> Void in
            builder!.setTrigger("PUSH") // can be "PUSH", "LOCATION", "CALENDAR", or "TIME_INTERVAL"
            builder!.setAction("action")
            builder!.setDeliveryDate("date")
            builder!.setCategoryIdentifier("category")
            builder!.setThreadIdentifier("thread")
            builder!.setNotification(content)
        })

        tracker?.trackPushNotificationEvent(event)
    }

    // this context schema doesn't exist, therefore makes any event BAD
    static func getCustomContext() -> NSMutableArray {
        let data : NSDictionary = [ "snowplow": "demo-tracker" ]
        let context = SPSelfDescribingJson(schema: "iglu:com.acme_company/demo_ios_event/jsonschema/1-0-0", andData: data)
        let result : NSMutableArray = [ context! ]
        return result
    }
}
