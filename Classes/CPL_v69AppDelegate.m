//
//  TabBar_Messing_AroundAppDelegate.m
//  TabBar-Messing-Around
//
//  Created by Jason Soo on 6/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "CPL_v69AppDelegate.h"

@implementation CPL_v69AppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize settings;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	// Setup the path the default plist file in our app bundle
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *finalPath = [path stringByAppendingPathComponent:@"settings.plist"];
	
	// Setup the path to the documents dir, where the plist should reside
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"settings.plist"];
	NSLog(@"Documents path: %@", plistPath);
	
	// Check and see if the plist file exists in the documents dir
	NSFileManager *fileManger = [NSFileManager defaultManager];
	if ( ![fileManger fileExistsAtPath:plistPath] ) {
		NSLog(@"Doesn't exist");
		NSError *error;
		// If not, copy our plist file to that location
		[[NSFileManager defaultManager] copyItemAtPath:finalPath toPath:plistPath error:error];
	}
	if ( ![fileManger fileExistsAtPath:plistPath] ) {
		NSLog(@"Still doesn't exist");
	}
	
	// Now lets only look at the plist file in the docs
	finalPath = plistPath;

	// Read account information	

	NSDictionary *settingsDict = [[NSDictionary dictionaryWithContentsOfFile:finalPath] retain];
	
	NSUserDefaults *plistSettings = [NSUserDefaults standardUserDefaults];
	[plistSettings registerDefaults:settingsDict];
	
	NSDictionary *loginInfo = [plistSettings dictionaryForKey:@"Login"];
	NSLog(@"%@", finalPath);
	NSLog(@"%@", loginInfo);
	NSLog(@"Zip Code: %@", [loginInfo objectForKey:@"zipCode"]);

	
	settings = Settings.getSettingsObject;
	settings.zipCode = (int)[loginInfo objectForKey:@"zipCode"];
	settings.accountNumber = [loginInfo objectForKey:@"accountNumber"];
	
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

