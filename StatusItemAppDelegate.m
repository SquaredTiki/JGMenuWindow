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
	[menuController setStatusItemTitle:@"Search"];
//	[menuController setStatusItemImage:[NSImage imageNamed:@"img.png"]];
	
/*	NSMutableArray *items = [[NSMutableArray alloc] init];
	for (int i = 0; i < 6; i++) {
		if (i==3)
			[items addObject:[JGMenuItem seperatorItem]];
		JGMenuItem *menuItem = [[JGMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Result %i", i] target:self action:@selector(itemSelected)];
		if (i==2) {
			JGMenuItem *title = [[JGMenuItem alloc] initWithTitle:@"You can't select me." target:nil action:NULL];
			[title setEnabled:NO];
			[items addObject:title];
		}
		if (i==3) {
			[menuItem setImage:[NSImage imageNamed:@"img.png"]];
			JGMenuWindowController *subController = [[JGMenuWindowController alloc] initWithWindowNibName:@"JGMenuWindow"];
			[subController setIsStatusItem:NO];
			JGMenuItem *subItem = [[JGMenuItem alloc] initWithTitle:@"i'm a lone sub item :(" target:self action:NULL];
			[subController setMenuItems:[NSArray arrayWithObject:subItem]];
			[menuItem setSubmenu:subController];
		}
		[items addObject:menuItem];
	} 
	[menuController setMenuItems:items]; */
}

#pragma mark Showing and Hiding Table

- (void)showTableView {
	NSMutableArray *items = [[NSMutableArray alloc] init];
	for (int i = 0; i < 6; i++) {
		if (i==3)
			[items addObject:[JGMenuItem seperatorItem]];
		JGMenuItem *menuItem = [[JGMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Result %i", i] target:self action:@selector(itemSelected)];
		if (i==2) {
			JGMenuItem *title = [[JGMenuItem alloc] initWithTitle:@"You can't select me." target:nil action:NULL];
			[title setEnabled:NO];
			[items addObject:title];
		}
		if (i==3) {
			[menuItem setImage:[NSImage imageNamed:@"img.png"]];
			JGMenuWindowController *subController = [[JGMenuWindowController alloc] initWithWindowNibName:@"JGMenuWindow"];
			[subController setIsStatusItem:NO];
			JGMenuItem *subItem = [[JGMenuItem alloc] initWithTitle:@"i'm a lone sub item :(" target:self action:NULL];
			[subController setMenuItems:[NSArray arrayWithObject:subItem]];
			[menuItem setSubmenu:subController];
		}
		[items addObject:menuItem];
	} 
	[menuController setMenuItems:items];
	[menuController highlightMenuItemAtIndex:0];
}

- (void)hideTableView {
	[menuController setMenuItems:nil];
}

- (void)itemSelected {
	JGMenuWindowController *subController = [[JGMenuWindowController alloc] initWithWindowNibName:@"JGMenuWindow"];
	[subController setIsStatusItem:NO];
	NSMutableArray *items = [[NSMutableArray alloc] init];
	for (int i = 0; i < 6; i++) {
		if (i==3)
			[items addObject:[JGMenuItem seperatorItem]];
		JGMenuItem *menuItem = [[JGMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Result %i", i] target:self action:NULL];
		if (i==4) {
			JGMenuWindowController *subController = [[JGMenuWindowController alloc] initWithWindowNibName:@"JGMenuWindow"];
			[subController setIsStatusItem:NO];
			JGMenuItem *subItem = [[JGMenuItem alloc] initWithTitle:@"i'm another lone sub item" target:self action:NULL];
			[subController setMenuItems:[NSArray arrayWithObject:subItem]];
			[menuItem setSubmenu:subController];
		}
		[items addObject:menuItem];
	} 
	[subController setProMode:YES];
	[subController setMenuItems:items];
	[subController popUpContextMenuAtPoint:NSMakePoint(500, 500)];
}

#pragma mark JGMenuWindowDelegate

- (void)menuWillOpen {
	[searchField becomeFirstResponder]; // Even though it will happen automatically, just to be on the safe side…
}

#pragma mark NSControlTextEditingDelegate

- (BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor {
	if (![searchField.stringValue isEqualToString:@""] && [searchField.stringValue length] <= 1) {
		[self showTableView];
	}
	return YES;
}

- (void)controlTextDidChange:(NSNotification *)obj {
	if (![searchField.stringValue isEqualToString:@""] && [searchField.stringValue length] <= 1) {
		[self showTableView];
	} else if ([searchField.stringValue isEqualToString:@""]) {
		[self hideTableView];
	}
}

@end
