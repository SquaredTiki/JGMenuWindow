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
#import "PaddedTextFieldCell.h"

#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

@protocol JGMenuWindowDelegate <NSObject>

@optional
- (void)menuWillOpen;
- (void)menuWillClose;
- (BOOL)shouldCloseMenuAfterSelectingRow:(int)row;

@end

@class JGMenuItem;

@interface JGMenuWindowController : NSWindowController <NSWindowDelegate, TableDetectionDelegate> {	
	@private /* PRIVATE VARIABLES */
	
	NSStatusItem *statusItem; // The Primary Status Item
	CustomStatusItemView *customStatusView; // PRIVATE: The Custom view within the status item
	
	NSTableView *itemsTable; // PRIVATE: The table where the items are displaye
	int mouseOverRow; // PRIVATE: Used to store which row the mouse is hovering over
	
	NSView *_headerView; // PRIVATE: The header view conainer
	
	NSTimer *timer; // PRIVATE: Used for fade out.
	
	float timeHovering; // PRIVATE: Amount of time hovering on a single point USED TO PREVENT DRAWING ISSUE
	BOOL isSelecting; // PRIVATE: Whether or not is selecting
	
	JGMenuItem *itemWithOpenSubmenu;
	JGMenuWindowController *parentMenu; 
	BOOL isMovingBackToParent;
	
	@public
	
	NSArray *menuItems; // An array of JGMenuItem's which can be set and which will be displayed
	NSView *headerView; // An optional headerView to be displayed at the top of the menu in a similar way to spotlight
	
	id <JGMenuWindowDelegate> menuDelegate; // The delegate which will recieve the optional method calls
	
	NSImage *statusItemImage; // Relayed to the customStatusView to set the Status Item image
	NSImage *statusItemAlternateImage; // Relayed to the customStatusView to set the Status Item alternate image
	NSString *statusItemTitle; // Relayed to the customStatusView to set the Status Item title
	
	BOOL isStatusItem; // Default is YES
	BOOL proMode; // Want your menu to look like those in the Apple Pro apps? then set this to YES!
}

@property (assign) IBOutlet NSTableView *itemsTable;
@property (assign, readonly) IBOutlet NSView *_headerView;
@property (nonatomic, retain) NSArray *menuItems;
@property (nonatomic, retain) NSView *headerView;
@property (nonatomic, retain) id <JGMenuWindowDelegate> menuDelegate;
@property (nonatomic, copy) NSImage *statusItemImage;
@property (nonatomic, copy) NSImage *statusItemAlternateImage;
@property (nonatomic, copy) NSString *statusItemTitle;
@property (nonatomic, assign) BOOL isStatusItem;
@property (nonatomic, assign) BOOL proMode;
@property (nonatomic, retain) JGMenuWindowController *parentMenu; // PRIVATE: Even though this is a property it should only be accessed by another menu controller
@property (nonatomic, assign) int mouseOverRow; // PRIVATE: Even though this is a property it should only be accessed by another menu controller


- (void)highlightMenuItemAtIndex:(int)rowIndex; // Forcefully highlight a menu item
- (void)closeWindow; // Close window with fade out
- (void)popUpContextMenuAtPoint:(NSPoint)point; // Pop up the menu at a specific point

@end
