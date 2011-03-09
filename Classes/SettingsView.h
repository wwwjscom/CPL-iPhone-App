//
//  SettingsView.h
//  CPL-v69
//
//  Created by Jason Soo on 6/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@interface SettingsView : UIViewController <UITextFieldDelegate> {
	UITextField *accountNumberField;
	UITextField *zipCodeField;
}

@property (retain) IBOutlet UITextField *accountNumberField;
@property (retain) IBOutlet UITextField *zipCodeField;

- (IBAction)done;
- (void)didFinishEditing;

@end
