//
//  OverdueBookView.h
//  CPL-v69
//
//  Created by Jason Soo on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface OverdueBookView : UIViewController {
	Book *book;
	UILabel *titleLabel;
	UILabel *dueDateLabel;
}

@property (retain) Book *book;
@property (retain) IBOutlet UILabel *titleLabel;
@property (retain) IBOutlet UILabel *dueDateLabel;

@end
