//
//  Book.m
//  CPL-v99
//
//  Created by Jason Soo on 6/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Book.h"


@implementation Book

@synthesize title, due_date, renew_url, status;

- (id)initWithTitle:(NSString *)title {
	self.title = title;
	return self;
}

- (void)dealloc {
	self.title = nil;
	self.due_date = nil;
	self.renew_url = nil;
	self.status = nil;
	[super dealloc];
}

@end
