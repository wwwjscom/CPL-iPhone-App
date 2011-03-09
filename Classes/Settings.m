//
//  Settings.m
//  CPL-v69
//
//  Created by Jason Soo on 6/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

static Settings *settings = nil;

@implementation Settings

@synthesize accountNumber, zipCode, overdueBooks, checkedOutBooks;
//@synthesize accountNumber, overdueBooks, checkedOutBooks;

+ (Settings*)getSettingsObject
{
	if (settings == nil) 
	{
		@synchronized(self)
		{
			if (settings == nil)
				settings = [[Settings alloc] init];
		}
	}
    return settings;
}

@end