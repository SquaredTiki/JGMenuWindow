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
#import "JGMenuItem.h"

@protocol JGMenuWindowDelegate <NSObject>

@optional
- (void)menuWillOpen;
- (void)menuWillClose;
- (BOOL)shouldCloseMenuAfterSelectingRow:(int)row;

@end


@interface JGMenuWindowController : NSWindowController <NSWindowDelegate, TableDetectionDelegate> {	
	@private /* PRIVATE VARIABLES */
	
	NSStatusItem *statusItem; // The Primary Status Item
	CustomStatusItemView *customStatusView; // PRIVATE: The Custom view within the status item
	
	NSTableView *itemsTable; // PRIVATE: The table where the items are displaye
	int mouseOverRow; // PRIVATE: Used to store which row the mouse is hovering over
	
	NSView *_headerView; // PRIVATE: The header view conainer
	
	NSTimer *timer; // PRIVATE: Used for fade out.
	
	@public
	
	NSArray *menuItems; // An array of JGMenuItem's which can be set and which will be displayed
	NSView *headerView; // An optional headerView to be displayed at the top of the menu in a similar way to spotlight
	
	id <JGMenuWindowDelegate> menuDelegate; // The delegate which will recieve the optional method calls
}

@property (assign) IBOutlet NSTableView *itemsTable;
@property (assign, readonly) IBOutlet NSView *_headerView;
@property (nonatomic, retain) NSArray *menuItems;
@property (nonatomic, retain) NSView *headerView;
@property (nonatomic, retain) id <JGMenuWindowDelegate> menuDelegate;

- (void)highlightMenuItemAtIndex:(int)rowIndex; // Forcefully highlight a menu item
- (void)closeWindow; // Close window with fade out

@end
