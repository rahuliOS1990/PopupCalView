//
//  AppDelegate.h
//  PopupCalView
//
//  Created by R. Sharma on 8/7/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)EKEventStore* eventStore;
@end
