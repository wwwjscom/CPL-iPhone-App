//
//  RootViewController.h
//  CPL-v99
//
//  Created by Jason Soo on 6/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Settings.h"

@interface RootViewController : UITableViewController {
	bool updating;
	NSMutableArray *checkedOutBooks;
	NSMutableArray *overdueBooks;
	Settings *settings;
	UIActivityIndicatorView *spinner;
}

@property (retain) NSMutableArray *checkedOutBooks;
@property (retain) NSMutableArray *overdueBooks;
@property (retain) Settings *settings;
@property (retain) UIActivityIndicatorView *spinner;

- (void)requestLoginInfo;
- (void)parseBooks;
- (void)prepareToParseBooks;
@end
