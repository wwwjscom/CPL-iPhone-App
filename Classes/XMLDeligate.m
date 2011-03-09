//
//  XMLDeligate.m
//  RSSReader
//
//  Created by Jason Soo on 2/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "XMLDeligate.h"

@implementation XMLDeligate

@synthesize title, book, checkedOutBooks, due_date, renew_url, status, overdueBooks;

- (id)init {
	checkedOutBooks = [[NSMutableArray alloc] init];
	overdueBooks = [[NSMutableArray alloc] init];
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
		
	if ([elementName isEqualToString:@"record"]) {
		book_open = YES;
		book = [[Book alloc] init];
	} else if ([elementName isEqualToString:@"title"]) {
		title_open = YES;
		title = [[NSMutableString alloc] init];
	} else if ([elementName isEqualToString:@"due-date"]) {
		due_date_open = YES;
		due_date = [[NSMutableString alloc] init];
	} else if ([elementName isEqualToString:@"renew-url"]) {
		renew_url_open = YES;
		renew_url = [[NSMutableString alloc] init];
	} else if ([elementName isEqualToString:@"status"]) {
		status_open = YES;
		status = [[NSMutableString alloc] init];
	} else if ([elementName isEqualToString:@"login-failed"]) {
		UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Login Error" message: @"Please check your login credentials." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
		[someError show];
		[someError release];
	}

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if (title_open) {
		[title appendString:string];
	} else if (due_date_open) {
		[due_date appendString:string];
	} else if (renew_url_open) {
		[renew_url appendString:string];
	} else if (status_open) {
		[status appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if ([elementName isEqualToString:@"record"]) {
		book_open = NO;
		/* Add the book to the correct array */
		if ([book.status isEqualToString:@"checked-out"]) {
			[checkedOutBooks addObject:book];
		} else if ([book.status isEqualToString:@"overdue"]) {
			[overdueBooks addObject:book];
		}
		[book release];
	} else if ([elementName isEqualToString:@"title"]) {
		title_open = NO;
		book.title = [title substringToIndex:[title length]-2]; // Remove the pesky / at the end of all book titles, thanks CPL!
		[title release];
	} else if ([elementName isEqualToString:@"due-date"]) {
		due_date_open = NO;
		book.due_date = due_date;
		[due_date release];
	} else if ([elementName isEqualToString:@"renew-url"]) {
		renew_url_open = NO;
		book.renew_url = renew_url;
		[renew_url release];
	} else if ([elementName isEqualToString:@"status"]) {
		status_open = NO;
		book.status = status;
		[status release];
	}
}

@end
