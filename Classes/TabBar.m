//
//  TabBar.m
//  CPL-v69
//
//  Created by Jason Soo on 6/18/10.
//  Copyright 2010 sosoome. All rights reserved.
//

#import "TabBar.h"

@implementation TabBar

/**
 * Disables the overdue tab so it cannot be clicked
 */
+ (void)disableOverdueTab:(RootViewController *)rvc {
	[[[[[rvc tabBarController] viewControllers] objectAtIndex:1] tabBarItem] setEnabled:NO];
}

/**
 * Enables the overdue tab so it can be clicked
 */
+ (void)enableOverdueTab:(RootViewController *)rvc {
	[[[[[rvc tabBarController] viewControllers] objectAtIndex:1] tabBarItem] setEnabled:YES];
}

/**
 * Updates the bade counts of the overdue and checked out tabs
 */
+ (void)updateBadges:(RootViewController *)rvc chekcedOutCount:(int)coCount overdueCount:(int)odCount {
	[[[[[rvc tabBarController] tabBar] items] objectAtIndex:0] setBadgeValue:[NSString stringWithFormat:@"%i", coCount]];
	[[[[[rvc tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%i", odCount]];
}

/**
 * Hides the badges on the tab bar
 */
+ (void)hideBadges:(RootViewController *)rvc {
	[[[[[rvc tabBarController] tabBar] items] objectAtIndex:0] setBadgeValue:nil];
	[[[[[rvc tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:nil];
}

@end