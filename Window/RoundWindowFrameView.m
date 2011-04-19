//
//  RoundWindowFrameView.m
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

#import "RoundWindowFrameView.h"
#import "NSBezierPath+PXRoundedRectangleAdditions.h"

@implementation RoundWindowFrameView
@synthesize tableDelegate;
@dynamic allCornersRounded, proMode;

//
// drawRect:
//
// Draws the frame of the window.
//
- (void)drawRect:(NSRect)rect
{	
	[[NSColor clearColor] set];
	NSRectFill(rect);
	
	if (proMode == NO) {
		NSBezierPath *path;
		
		if (allCornersRounded)
			path = [NSBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:5];
		else
			path = [NSBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:5 inCorners:OSBottomLeftCorner | OSBottomRightCorner];
		
		
		NSGradient* aGradient = [[[NSGradient alloc] initWithColorsAndLocations:
					[NSColor colorWithDeviceWhite:1 alpha:0.97], (CGFloat)0.0,
					[NSColor colorWithDeviceWhite:1 alpha:0.97], (CGFloat)1.0,
					nil] autorelease];
		[aGradient drawInBezierPath:path angle:90];
	} else {
		NSBezierPath *path;
		
		if (allCornersRounded)
			path = [NSBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:5];
		else
			path = [NSBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:5 inCorners:OSBottomLeftCorner | OSBottomRightCorner];

		NSGradient* aGradient = [[[NSGradient alloc] initWithColorsAndLocations:
								  [NSColor colorWithDeviceWhite:0 alpha:0.97], (CGFloat)0.0,
								  [NSColor colorWithDeviceWhite:0 alpha:0.97], (CGFloat)1.0,
								  nil] autorelease];
		[aGradient drawInBezierPath:path angle:90];
	}
}

#pragma mark Dynamics

- (BOOL)allCornersRounded {
	return allCornersRounded;
}

- (void)setAllCornersRounded:(BOOL)flag {
	allCornersRounded = flag;
	[self setNeedsDisplay:YES];
}

- (BOOL)proMode {
	return proMode;
}

- (void)setProMode:(BOOL)flag {
	proMode = flag;
	[self setNeedsDisplay:YES];
}

#pragma mark Events

- (void)mouseMoved:(NSEvent*)theEvent
{
	NSPoint location = [theEvent locationInWindow];
	
	if (location.x > 0 && location.y > 0) {
		if ([tableDelegate respondsToSelector:@selector(mouseMovedIntoLocation:)])
			 [tableDelegate mouseMovedIntoLocation:location];	
	} else {
		if ([tableDelegate respondsToSelector:@selector(mouseMovedOutOfView)])
			[tableDelegate mouseMovedOutOfView];	
	}
}

- (void)mouseDownInTableViewWithEvent:(NSEvent *)event {	
	NSPoint location = [event locationInWindow];
	
	if (location.x > 0 && location.y > 0) {
		if ([tableDelegate respondsToSelector:@selector(mouseDownAtLocation:)])
			[tableDelegate mouseDownAtLocation:location];	
	}
}

- (void)keyUp:(NSEvent *)event {
    NSString *chars = [event characters];
    unichar character = [chars characterAtIndex: 0];
	
    if (character == 27) {
		if ([tableDelegate respondsToSelector:@selector(escapeKeyPressed)])
			[tableDelegate escapeKeyPressed];	
    }
	
	[super keyUp:event];
}

@end
