//
//  RootViewController.m
//  CPL-v99
//
//  Created by Jason Soo on 6/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "Book.h"
#import "BookView.h"
#import "XMLDeligate.h"
#import "SettingsView.h"
#import "TabBar.h"

@implementation RootViewController

@synthesize checkedOutBooks, settings, spinner, overdueBooks;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationItem.title = @"Checked out";
	[self.tableView reloadData];

	[TabBar hideBadges:self];
	updating = NO;
}

/**
 * Prompts the user for their login info for the CPL
 */
- (void)requestLoginInfo {
	SettingsView *settingsView = [[SettingsView alloc] initWithNibName:@"SettingsView" bundle:nil];
	[self.navigationController presentModalViewController:settingsView animated:YES];
	[settingsView release];
}

/**
 * Contacts our server with the login info provided by the user.
 * Logs into the CPL site, parses the data, returns the XML to the iPhone.
 * Then this function parses the XML and puts it into the table.
 */
- (void)parseBooks {
	
	// Threads need their onw threadpool
	NSAutoreleasePool *threadPool = [[NSAutoreleasePool alloc] init];
	
	updating = YES;
	
	[TabBar disableOverdueTab:self];
	
	// Start Parsing the books
	NSLog(@"Parsing...");
	// Contact @jsoo or @cpl_app for directions on how to use the APIs
	NSString *URL = [NSString stringWithFormat:@"---API-URL-REACTED---", settings.accountNumber, settings.zipCode];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[[[NSURL alloc] initWithString:URL] autorelease]];
	XMLDeligate *aXMLDelegate = [[XMLDeligate alloc] init];
	[parser setDelegate:aXMLDelegate];
	[parser parse];
	
	settings.checkedOutBooks = aXMLDelegate.checkedOutBooks;
	settings.overdueBooks = aXMLDelegate.overdueBooks;
	NSLog(@"%@", [settings overdueBooks]);
	
	[self.tableView reloadData];
	
	[spinner stopAnimating];

	[TabBar updateBadges:self chekcedOutCount:[[settings checkedOutBooks] count] overdueCount:[[settings overdueBooks] count]];
	
	updating = NO;
	
	[TabBar enableOverdueTab:self];
	
	[threadPool release];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	settings = [Settings getSettingsObject];
	
	// Prompt user for login info if its blank
	if ([settings.accountNumber isEqualToString:@""]) {
		self.requestLoginInfo;
	} else {
		// Parse books if login info isn't blank and books haven't been parsed yet & we aren't updating atm
		if ([[settings checkedOutBooks] count] == 0 && !updating) {
			self.prepareToParseBooks;
		}
	}
}

/*
 * Setups the the spinner icon and calls parse books in a new thread
 */
- (void)prepareToParseBooks {
	spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[spinner setCenter:CGPointMake(150, 150)];
	[self.view addSubview:spinner];
	[spinner startAnimating];
	
	[self performSelectorInBackground:@selector(parseBooks) withObject:nil];
}

/*
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}
*/

/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[settings checkedOutBooks] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	cell.textLabel.text = [[[settings checkedOutBooks] objectAtIndex:indexPath.row] title];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Due Date: %@", [[[settings checkedOutBooks] objectAtIndex:indexPath.row] due_date]];

    return cell;
}




// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Navigation logic may go here -- for example, create and push another view controller.
	NSLog(@"Click at @%i", indexPath.row);
	BookView *bookView = [[BookView alloc] initWithNibName:@"BookView" bundle:nil];
	bookView.book = [[settings checkedOutBooks] objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:bookView animated:YES];
	[bookView release];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

