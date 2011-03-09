//
//  SettingsView.m
//  CPL-v69
//
//  Created by Jason Soo on 6/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsView.h"

@implementation SettingsView

@synthesize accountNumberField, zipCodeField;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	// Setup the background image
	self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background.png"]];
}


- (void)viewWillAppear:(BOOL)animated {

	// Redisplay the login credentials if they've been set.
	// Mask the account number if its been set
	Settings *s = [Settings getSettingsObject];
	if (![s.accountNumber isEqualToString:@""]) {
		if ([s.accountNumber length] > 7) {
			self.accountNumberField.text = [NSString stringWithFormat:@"*******%@", [s.accountNumber substringFromIndex:7]];
		}
	}
	if ([[s zipCode] intValue] != 0) {
		self.zipCodeField.text = [[NSString alloc] initWithFormat:@"%@", s.zipCode];
	}

	s = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)done {
	
	// Verify that all the fields have been filled in
	if ([self.accountNumberField.text isEqualToString:@""] || [self.zipCodeField.text isEqualToString:@""]) {
		UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Form Error" message: @"Please fill in all parts of the form" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
		
		[someError show];
		[someError release];
	} else {
		
		self.didFinishEditing;
		
		// Write the new login info to the plist
		
		// Prepare path
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"settings.plist"];
		NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
		NSMutableDictionary *login = [plistDict objectForKey:@"Login"];
		
		// Update values
        [login setValue:[Settings getSettingsObject].accountNumber forKey:@"accountNumber"];
		[login setValue:[Settings getSettingsObject].zipCode forKey:@"zipCode"];
		
		// Commit updates
        [plistDict writeToFile:plistPath atomically: YES];	
		
		NSLog(@"Act Num: %@", [Settings getSettingsObject].accountNumber);
		NSLog(@"Zip Code: %@", [Settings getSettingsObject].zipCode);
		
		self.tabBarController.selectedIndex = 0;
		[[self parentViewController] dismissModalViewControllerAnimated:NO];
	}	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

/* Update the singleton with the values of the text fields */
- (void)didFinishEditing {
	// Don't update the account number if its just a masked value
	if(![self.accountNumberField.text hasPrefix:@"*******"]) {
		[Settings getSettingsObject].accountNumber = self.accountNumberField.text;
	}
	[Settings getSettingsObject].zipCode = [[[NSNumberFormatter alloc] init] numberFromString:self.zipCodeField.text];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
