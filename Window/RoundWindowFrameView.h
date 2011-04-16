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

#define WINDOW_FRAME_PADDING 0

@protocol TableDetectionDelegate

- (void)mouseMovedIntoLocation:(NSPoint)loc;

@end


@interface RoundWindowFrameView : NSView
{
	id <TableDetectionDelegate> tableDelegate;
}

@property (nonatomic, retain) id <TableDetectionDelegate> tableDelegate;

@end
