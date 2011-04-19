//
//  PaddedTextFieldCell.m
//  StatusItem
//
//  Created by Joshua Garnham on 17/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PaddedTextFieldCell.h"

@implementation PaddedTextFieldCell
@dynamic leftMargin;

- (void)drawInteriorWithFrame:(NSRect)cellFrame
					   inView:(NSView *)controlView
{
	if (leftMargin == 0)
		leftMargin = 15;
	cellFrame.origin.x += leftMargin;
	cellFrame.size.width -= leftMargin;
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
	aRect.origin.x += leftMargin;
	aRect.size.width -= leftMargin;
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

- (int)leftMargin {
	return leftMargin;
}

- (void)setLeftMargin:(int)newMargin {
	leftMargin = newMargin;
}

@end
