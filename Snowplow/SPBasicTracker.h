//
//  SPBasicTracker.h
//  Snowplow
//
//  Copyright © 2019 Snowplow Analytics Ltd. All rights reserved.
//
//  This program is licensed to you under the Apache License Version 2.0,
//  and you may not use this file except in compliance with the Apache License
//  Version 2.0. You may obtain a copy of the Apache License Version 2.0 at
//  http://www.apache.org/licenses/LICENSE-2.0.
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the Apache License Version 2.0 is distributed on
//  an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
//  express or implied. See the Apache License Version 2.0 for the specific
//  language governing permissions and limitations there under.
//
//  Authors: Michael Hadam
//  Copyright: Copyright (c) 2019 Snowplow Analytics Ltd
//  License: Apache License Version 2.0
//
//

@class SPEmitter;
@class SPPayload;
@class SPSubject;
@class SPSession;
@class SPPageView;
@class SPStructured;
@class SPUnstructured;
@class SPScreenView;
@class SPTiming;
@class SPEcommerce;
@class SPSelfDescribingJson;
@class SPConsentWithdrawn;
@class SPConsentGranted;
@class SPPushNotification;
@class SPForeground;
@class SPBackground;

/*!
 @brief The builder for SPBasicTracker.
 */
@protocol SPBasicTrackerBuilder <NSObject>

/*!
 @brief Tracker builder method to set the app ID.

 @param appId The tracker's app ID.
 */
- (void) setAppId:(NSString *)appId;

/*!
 @brief Tracker builder method to set the tracker namespace.

 @param trackerNamespace The tracker's namespace.
 */
- (void) setNamespace:(NSString *)trackerNamespace;

/*!
 @brief Tracker builder method to set the tracker namespace.

 @param endpoint The endpoint that the tracker will send events.
 */
- (void) setEndpoint:(NSString *)endpoint;

@end


/*!
 @class SPBasicTracker
 @brief The basic tracker class.

 This class is a limited form of the tracker for quick setup.
 */
@interface SPBasicTracker : NSObject <SPBasicTrackerBuilder>

/*! @brief The emitter used to send events. */
@property (readonly, nonatomic, retain) SPEmitter * emitter;
/*! @brief The subject used to represent the current user and persist user information. */
@property (readonly, nonatomic, retain) SPSubject * subject;
/*! @brief The object used for sessionization, i.e. it characterizes user activity. */
@property (nonatomic, retain) SPSession * session;
/*! @brief A unique identifier for an application. */
@property (readonly, nonatomic, retain) NSString *  appId;
/*! @brief The identifier for the current tracker. */
@property (readonly, nonatomic, retain) NSString *  trackerNamespace;
/*! @brief Whether to use Base64 encoding for events. */
@property (readonly, nonatomic)         BOOL        base64Encoded;

/*!
 @brief Method that allows for builder pattern in creating the tracker.
 */
+ (instancetype) build:(void(^)(id<SPBasicTrackerBuilder>builder))buildBlock;

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

/*!
 @brief Pauses all event tracking, storage and session checking.
 */
- (void) pauseEventTracking;

/*!
 @brief Resumes all event tracking and restarts the session checking.
 */
- (void) resumeEventTracking;

/*!
 @brief Returns the current session index count.

 @return A count of sessions that have occurred - also identifies the current session.
 */
- (NSInteger) getSessionIndex;

/*!
 @brief Returns whether the application is in the background or foreground.

 @return Whether application is suspended.
 */
- (BOOL) getInBackground;

/*!
 @brief Returns whether the tracker is currently collecting data.

 @return Whether the tracker is tracking.
 */
- (BOOL) getIsTracking;

/*!
 @brief Returns the session's userId.

 @return UUID for userID.
 */
- (NSString*) getSessionUserId;

/*!
 @brief Returns whether lifecyle events is enabled.

 @return Whether background and foreground events are sent.
 */
- (BOOL) getLifecycleEvents;

/*!
 @brief Constructs the final event payload that is sent to the emitter.

 @warning This function is only used for testing purposes; should never be called in production.

 @param pb The event payload without any decoration.
 @param contextArray The array of SelfDescribingJsons to add to the context JSON.
 @param eventId The event's eventId which will be used to generate the session JSON.
 @return The final complete payload ready for sending.
 */
- (SPPayload *) getFinalPayloadWithPayload:(SPPayload *)pb andContext:(NSMutableArray *)contextArray andEventId:(NSString *)eventId;

/*!
 @brief Tracks a page view event.

 @param event A page view event.
 */
- (void) trackPageViewEvent:(SPPageView *)event;

/*!
 @brief Tracks a structured event.

 @param event A structured event.
 */
- (void) trackStructuredEvent:(SPStructured *)event;

/*!
 @brief Tracks an unstructured event.

 @param event An unstructured event.
 */
- (void) trackUnstructuredEvent:(SPUnstructured *)event;

/*!
 @brief Tracks an self-describing event.

 @note This is an alias for trackUnstructuredEvent:event.

 @param event An self-describing JSON.
 */
- (void) trackSelfDescribingEvent:(SPSelfDescribingJson *)event;

/*!
 @brief Tracks an screenview event.

 @param event A screenview event.
 */
- (void) trackScreenViewEvent:(SPScreenView *) event;

/*!
 @brief Tracks a timing event.

 @param event A timing event.
 */
- (void) trackTimingEvent:(SPTiming *) event;

/*!
 @brief Tracks an ecommerce event.

 @param event An ecommerce event.
 */
- (void) trackEcommerceEvent:(SPEcommerce *)event;

/*!
 @brief Tracks a consent withdrawn event.

 @param event A consent withdrawn event.
 */
- (void) trackConsentWithdrawnEvent:(SPConsentWithdrawn *)event;

/*!
 @brief Tracks a consent granted event.

 @param event A consent granted event.
 */
- (void) trackConsentGrantedEvent:(SPConsentGranted *)event;

/*!
 @brief Tracks a push notification event.

 @param event A push notification event.
 */
- (void) trackPushNotificationEvent:(SPPushNotification *)event;

/*!
 @brief Tracks a foreground event.

 @param event A foreground event.
 */
- (void) trackForegroundEvent:(SPForeground *)event;

/*!
 @brief Tracks a background event.

 @param event A background event.
 */
- (void) trackBackgroundEvent:(SPBackground *)event;

@end
