//
//  CustomStatusItemView.m
//  StatusItem
//
//  Created by Joshua Garnham on 14/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomStatusItemView.h"

@implementation CustomStatusItemView
@synthesize target, selectingAction, deselectingAction;
@dynamic highlighted;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	if (highlighted) {
		NSRect fullBounds = [self bounds];
		[[NSColor selectedMenuItemColor] set];
		NSRectFill( fullBounds );
	} else {
		NSRect fullBounds = NSMakeRect([self bounds].origin.x, [self bounds].origin.y + 1, [self bounds].size.width, [self bounds].size.height - 1);
		[[NSColor grayColor] set];
		NSRectFill( fullBounds );
	}
}

- (void)mouseDown:(NSEvent *)theEvent
{
	if (highlighted) {
		[self setHighlighted:NO];
		[target performSelector:deselectingAction];
		return;
	}
	[target performSelector:selectingAction];
}

#pragma mark Dynamics

- (BOOL)highlighted {
	return highlighted;
}

- (void)setHighlighted:(BOOL)highlight {
	highlighted = highlight;
	[self setNeedsDisplay:YES];
}

@end
