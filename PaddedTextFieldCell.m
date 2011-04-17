//
//  PaddedTextFieldCell.m
//  StatusItem
//
//  Created by Joshua Garnham on 17/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PaddedTextFieldCell.h"


@implementation PaddedTextFieldCell

#define kLeftMargin 15.0

- (void)drawInteriorWithFrame:(NSRect)cellFrame
					   inView:(NSView *)controlView
{
	cellFrame.origin.x += kLeftMargin;
	cellFrame.size.width -= kLeftMargin;
	[super drawInteriorWithFrame:cellFrame
						  inView:controlView];
}

- (void)selectWithFrame:(NSRect)aRect
				 inView:(NSView *)controlView
				 editor:(NSText *)textObj
			   delegate:(id)anObject
				  start:(NSInteger)selStart
				 length:(NSInteger)selLength
{
	aRect.origin.x += kLeftMargin;
	aRect.size.width -= kLeftMargin;
	[super selectWithFrame:aRect
					inView:controlView
					editor:textObj
				  delegate:anObject
					 start:selStart
					length:selLength];
}

- (NSRect)_focusRingFrameForFrame:(NSRect)frame
						cellFrame:(NSRect)cellFrame
{
	return [[self controlView] bounds];
}

@end
