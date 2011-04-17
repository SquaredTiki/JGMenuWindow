//
//  StatusItemAppDelegate.m
//  StatusItem
//
//  Created by Joshua Garnham on 07/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StatusItemAppDelegate.h"

@implementation StatusItemAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	menuController = [[[JGMenuWindowController alloc] initWithWindowNibName:@"JGMenuWindow"] retain];
	[menuController setHeaderView:customView];
	[menuController setMenuDelegate:self];
/*	NSMutableArray *items = [[NSMutableArray alloc] init];
	for (int i = 0; i < 6; i++)
		[items addObject:[NSString stringWithFormat:@"Result %i", i]];
	[menuController setMenuItems:items]; 
	[items release]; */
}

- (void)applicationDidResignActive:(NSNotification *)aNotification {
	[menuController closeWindow];
}

#pragma mark JGMenuWindowDelegate

- (void)didSelectMenuItemAtIndex:(int)index {
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert addButtonWithTitle:@"Coolio!"];
	[alert setMessageText:@"You Selected a Menu Item"];
	[alert setInformativeText:[NSString stringWithFormat:@"To be more precise you selected the item at index %i", index]];
	[alert setAlertStyle:NSInformationalAlertStyle];
	[alert runModal];	
}

#pragma mark Showing and Hiding Table

- (void)showTableView {
	NSMutableArray *items = [[NSMutableArray alloc] init];
	for (int i = 0; i < 6; i++) {
		if (i==3)
			[items addObject:[JGMenuWindowController seperatorItem]];
		[items addObject:[NSString stringWithFormat:@"Result %i", i]];
	}
	[menuController setMenuItems:items];
	[items release];
}

- (void)hideTableView {
	[menuController setMenuItems:nil];
}

#pragma mark NSControlTextEditingDelegate

- (BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor {
	if (![searchField.stringValue isEqualToString:@""]) {
		[self showTableView];
	}
	return YES;
}

- (void)controlTextDidChange:(NSNotification *)obj {
	if (![searchField.stringValue isEqualToString:@""]) {
		[self showTableView];
	} else {
		[self hideTableView];
	}
}

@end
