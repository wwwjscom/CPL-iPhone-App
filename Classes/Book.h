//
//  Book.h
//  CPL-v99
//
//  Created by Jason Soo on 6/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Book : NSObject {
	NSString *title;
	NSString *due_date;
	NSString *renew_url;
	NSString *status;
}

@property (retain) NSString *title;
@property (retain) NSString *due_date;
@property (retain) NSString *renew_url;
@property (retain) NSString *status;

-(id) initWithTitle:(NSString *)title;

@end
