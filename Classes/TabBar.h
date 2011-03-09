//
//  TabBar.h
//  CPL-v69
//
//  Created by Jason Soo on 6/18/10.
//  Copyright 2010 sosoome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootViewController.h"


@interface TabBar : NSObject {
}

+ (void)disableOverdueTab:(RootViewController *)rvc;
+ (void)enableOverdueTab:(RootViewController *)rvc;
+ (void)updateBadges:(RootViewController *)rvc chekcedOutCount:(int)coCount overdueCount:(int)odCount;
+ (void)hideBadges:(RootViewController *)rvc;

@end
