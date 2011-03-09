//
//  BookView.h
//  CPL-v99
//
//  Created by Jason Soo on 6/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface BookView : UIViewController {
	Book *book;
	UILabel *bookTitle;
	UILabel *dueDate;
}

@property (retain) Book *book;
@property (retain) IBOutlet UILabel *bookTitle;
@property (retain) IBOutlet UILabel *dueDate;

@end
