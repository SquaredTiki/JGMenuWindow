//
//  JGMenuWindowController.m
//  StatusItem
//
//  Created by Joshua Garnham on 15/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JGMenuWindowController.h"

@implementation JGMenuWindowController
@synthesize itemsTable, _headerView;
@dynamic menuItems, headerView;

- (id)initWithWindowNibName:(NSString *)windowNibName {
	self = [super initWithWindowNibName:windowNibName];
	if (self) {
		// Set up status item
	    NSStatusBar *bar = [NSStatusBar systemStatusBar];
		
		statusItem = [bar statusItemWithLength:NSVariableStatusItemLength];
		[statusItem retain];
		
		customStatusView = [[CustomStatusItemView alloc] initWithFrame:NSMakeRect(0, 0, 30, 20)];
		[customStatusView setTarget:self];
		[customStatusView setSelectingAction:@selector(statusItemSelected:)];
		[customStatusView setDeselectingAction:@selector(statusItemDeselected:)];
		[statusItem setView:customStatusView];
		
		[(RoundWindowFrameView *)[[self.window contentView] superview] setTableDelegate:self];
	}
	return self;
}

#pragma mark Handling changes to the window

- (void)closeWindow {
	[self.window close];
	[customStatusView setHighlighted:NO];
}

#pragma mark Handling changes to menuItems and headerView

- (NSArray *)menuItems {
	return menuItems;
}

- (void)setMenuItems:(NSArray *)items {
	menuItems = [items copy];
	
	// Work out headerView sizing based on string size
	if (headerView == nil) {
		float width = 0;
		for (NSString *string in menuItems) {
			NSSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName: @"Lucida Grande" size: 13] forKey:NSFontAttributeName]];
			if (size.width > width)
				width = size.width + 10;
		}
		headerView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, width, 0)];	
	}	

	[itemsTable reloadData];
	[self loadHeights];
}

- (NSView *)headerView {
	return headerView;
}

- (void)setHeaderView:(NSView *)view {
	headerView = view;
	[self loadHeights];
}

#pragma mark Handling the Status Item

- (void)loadHeights {	
	NSRect newFrame = [[customStatusView window] frame];
	
	// Work out the _headerView's (basically a container) frame from the actually headerView frame
	
	NSRect _headerViewOldFrame = _headerView.frame;
	_headerViewOldFrame.origin.x = 0;
	_headerViewOldFrame.origin.y = self.window.frame.size.height - headerView.frame.size.height;
	_headerViewOldFrame.size.height = headerView.frame.size.height;
	_headerViewOldFrame.size.width = headerView.frame.size.width;
	[_headerView setFrame:_headerViewOldFrame];

	NSRect headerViewOldFrame = headerView.frame;
	headerViewOldFrame.origin.x = 0;
	headerViewOldFrame.origin.y = 0;
	[headerView setFrame:headerViewOldFrame];
	
	// Add the headerView as a subview to the container
	
	[_headerView addSubview:headerView];
	
	// Work out the height of the cells in the table view
	
	int sizeOfCellsInTableView = 0;
	
	if ([menuItems count] != 0) {
		sizeOfCellsInTableView = (20 * [menuItems count]) + 6;
	}
	
	// Adjust what will be window frame
			
	newFrame.size.width = headerView.frame.size.width;
	newFrame.size.height = sizeOfCellsInTableView + headerView.frame.size.height;
	newFrame.origin.y = newFrame.origin.y - (sizeOfCellsInTableView + headerView.frame.size.height);
	newFrame.origin.x = newFrame.origin.x;
	
	// Decide which side to draw the menu
	
	CGFloat xOrigin = newFrame.origin.x;
	
	BOOL whichSide = 0; // 0 = shown to the right, 1 = shown to the left
	NSRect screenRect = [[NSScreen mainScreen] frame];
	NSRect statusItemRect = [[customStatusView window] frame];
		
	if ((statusItemRect.origin.x + headerView.frame.size.width) > screenRect.size.width)
		whichSide = 1;
		
	if (whichSide) {
		xOrigin = xOrigin - self.window.frame.size.width + customStatusView.frame.size.width;
	}
	
	newFrame.origin.x = xOrigin;
	
	// Set the windows frame
	
	[self.window setFrame:newFrame display:YES];
	
	// Adjust Table view frame, has to be done after window frame change other wise there are some complications with autoresizing
	
	if ([menuItems count] != 0) {
		NSRect tableOldFrame = itemsTable.frame;
		tableOldFrame.origin.x = 0;
		//	if (headerView.size.height = 0)
		tableOldFrame.origin.y = -2;
		tableOldFrame.size.height = sizeOfCellsInTableView;
		tableOldFrame.size.width = headerView.frame.size.width;
		[itemsTable setFrame:tableOldFrame];
		[[[itemsTable superview] superview] setFrame:tableOldFrame];
	}
}

- (void)statusItemDeselected:(id)sender {
	[self.window close];
	[customStatusView setHighlighted:NO];
}

- (void)statusItemSelected:(id)sender {
	[self loadHeights];
	[self.window makeKeyAndOrderFront:self];
	[[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
	[customStatusView setHighlighted:YES];
}

#pragma mark TableDetectionDelegate

- (void)mouseMovedIntoLocation:(NSPoint)loc {
	mouseOverRow = [itemsTable rowAtPoint:[itemsTable convertPoint:loc fromView:nil]];
	[itemsTable reloadData];
}

#pragma mark NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
	return [menuItems count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	return [menuItems objectAtIndex:rowIndex];
}

#pragma mark NSTableViewDelegate

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex {
	return NO;
}

- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{	
	if (mouseOverRow == rowIndex && ([aTableView selectedRow] != rowIndex)) {
		if ([aTableView lockFocusIfCanDraw]) {
			NSRect rowRect = [aTableView rectOfRow:rowIndex];
			NSRect columnRect = [aTableView rectOfColumn:[[aTableView tableColumns] indexOfObject:aTableColumn]];
			
			NSGradient* aGradient =
			[[[NSGradient alloc]
			  initWithColorsAndLocations:
			  [NSColor colorWithDeviceRed:0.416 green:0.529 blue:0.961 alpha:1.000], (CGFloat)0.0,
			  [NSColor colorWithDeviceRed:0.212 green:0.365 blue:0.949 alpha:1.000], (CGFloat)1.0,
			  nil]
			 autorelease];
			NSRect rectToDraw = NSIntersectionRect(rowRect, columnRect);
			rectToDraw.size.height = 18;
			rectToDraw.origin.y = rectToDraw.origin.y + 1;
			[aGradient drawInRect:rectToDraw angle:90];
			[aTableView unlockFocus];
			
			[aCell setTextColor:[NSColor selectedMenuItemTextColor]];
		}
	} else {
		[aCell setTextColor:[NSColor blackColor]];
	}
}

@end
