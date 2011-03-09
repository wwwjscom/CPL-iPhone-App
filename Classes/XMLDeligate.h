//
//  XMLDeligate.h
//  RSSReader
//
//  Created by Jason Soo on 2/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface XMLDeligate : NSObject <NSXMLParserDelegate> {
//@interface XMLDeligate : NSObject {
	bool book_open;
	bool title_open;
	bool due_date_open;
	bool renew_url_open;
	bool status_open;
	NSMutableString *title;
	NSMutableString *due_date;
	NSMutableString *renew_url;
	NSMutableString *status;
	Book *book;
	NSMutableArray *checkedOutBooks;
	NSMutableArray *overdueBooks;

}

@property (retain) NSMutableString *title;
@property (retain) NSMutableString *due_date;
@property (retain) NSMutableString *renew_url;
@property (retain) NSMutableString *status;
@property (retain) Book *book;
@property (retain) NSMutableArray *checkedOutBooks;
@property (retain) NSMutableArray *overdueBooks;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;

@end
