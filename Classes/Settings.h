//
//  Settings.h
//  CPL-v69
//
//  Created by Jason Soo on 6/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Settings : NSObject {
	NSString *accountNumber;
	NSNumber *zipCode;
	NSMutableArray *overdueBooks;
	NSMutableArray *checkedOutBooks;
}

@property (retain) NSString *accountNumber;
@property (retain) NSNumber *zipCode;
@property (retain) NSMutableArray *overdueBooks;
@property (retain) NSMutableArray *checkedOutBooks;

+ (Settings*)getSettingsObject;

@end
