//
//  OverdueBooksView.h
//  CPL-v69
//
//  Created by Jason Soo on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverdueBookView.h"


@interface OverdueBooksView : UITableViewController {
	NSMutableArray *overdueBooks;
}

@property (retain) NSMutableArray *overdueBooks;

@end
