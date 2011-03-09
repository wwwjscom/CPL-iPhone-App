//
//  TabBar_Messing_AroundAppDelegate.h
//  TabBar-Messing-Around
//
//  Created by Jason Soo on 6/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "Settings.h"

@interface CPL_v69AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	Settings *settings;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (retain) Settings *settings;

@end
