//
//  JGMenuWindowController.h
//  StatusItem
//
//  Created by Joshua Garnham on 15/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CustomStatusItemView.h"
#import "RoundWindowFrameView.h" 
#import "DetectingTableView.h"
#import "BorderlessWindow.h"

@interface JGMenuWindowController : NSWindowController <TableDetectionDelegate, NSApplicationDelegate> {	
	NSStatusItem *statusItem; // The Primary Status Item
	CustomStatusItemView *customStatusView; // The Custom view within the status item
	
	NSArray *menuItems; // An array of menuItems which can be set and which will be displayed
	NSView *headerView; // An optional headerView to be displayed at the top of the menu in a similar way to spotlight
	
	NSTableView *itemsTable; // PRIVATE: The table where the items are displaye
	int mouseOverRow; // PRIVATE: Used to store which row the mouse is hovering over
	
	NSView *_headerView; // PRIVATE: The header view conainer
}

@property (assign) IBOutlet NSTableView *itemsTable;
@property (assign, readonly) IBOutlet NSView *_headerView;
@property (nonatomic, retain) NSArray *menuItems;
@property (nonatomic, retain) NSView *headerView;

- (void)loadHeights;
- (void)closeWindow;

@end
