//
//  RoundWindowFrameView.h
//  RoundWindow
//
//  Created by Matt Gallagher on 12/12/08.
//  Copyright 2008 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <Cocoa/Cocoa.h>

@protocol TableDetectionDelegate <NSObject>

- (void)mouseMovedIntoLocation:(NSPoint)loc;
- (void)mouseMovedOutOfViewToLoc:(NSPoint)loc;
- (void)mouseDownAtLocation:(NSPoint)loc;
- (void)escapeKeyPressed;

@end

#import "JGMenuWindowController.h"

@interface RoundWindowFrameView : NSView
{
	id <TableDetectionDelegate> tableDelegate;
	BOOL allCornersRounded;
	BOOL proMode;
	
	BOOL _isSubmenu;
	int _submenuSide;
}

@property (nonatomic, retain) id <TableDetectionDelegate> tableDelegate;
@property (nonatomic, assign) BOOL allCornersRounded;
@property (nonatomic, assign) BOOL proMode;

- (void)setIsSubmenuOnSide:(int)side; // 0 == left. 1 == right.

@end
