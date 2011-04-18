//
//  CustomStatusItemView.m
//  StatusItem
//
//  Created by Joshua Garnham on 14/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomStatusItemView.h"

@implementation CustomStatusItemView
@synthesize statusItem, target, selectingAction, deselectingAction;
@dynamic highlighted, image, alternateImage;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	NSImage *drawnImage = nil;
	if(highlighted)	{
		[[NSColor selectedMenuItemColor] set];
		[NSBezierPath fillRect:[self bounds]];
		drawnImage = alternateImage;
	} else {
		drawnImage = image;
	}
	
	NSRect centeredRect = NSMakeRect(0, 0, [drawnImage size].width, [drawnImage size].height);
	centeredRect.origin.x = NSMidX([self bounds]) - ([drawnImage size].width / 2);
	centeredRect.origin.y = NSMidY([self bounds]) - ([drawnImage size].height / 2);
	centeredRect = NSIntegralRect(centeredRect);
	[drawnImage drawInRect:centeredRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	if (!highlighted && image == nil) {
		NSRect fullBounds = NSMakeRect([self bounds].origin.x, [self bounds].origin.y + 1, [self bounds].size.width, [self bounds].size.height - 1);
		[[NSColor grayColor] set];
		NSRectFill( fullBounds );	
	}
}

#pragma mark Image Resizing

- (void)_resizeToFitIfNeeded
{
    if([statusItem length] == NSVariableStatusItemLength)
    {
        NSRect newFrame = [self frame];
        newFrame.size.width = [[self image] size].width + 8; // 12 px padding, 6 on each side maybe? not sure what might be the usual
        [self setFrame:newFrame];
    }
}

#pragma mark Receiving mouse events

- (void)mouseDown:(NSEvent *)theEvent
{
	if (highlighted) {
		[self setHighlighted:NO];
		[target performSelector:deselectingAction];
		return;
	}
	[self setHighlighted:YES];
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

- (NSImage *)image {
	return image;
}

- (void)setImage:(NSImage *)newImage
{
	if(newImage != image)
	{
		[image release];
		image = [newImage copy];
        [self _resizeToFitIfNeeded];
		[self setNeedsDisplay:YES];
	}
}

- (NSImage *)alternateImage {
	return alternateImage;
}

- (void)setAlternateImage:(NSImage *)newAltImage
{
	if(newAltImage != alternateImage)
	{
		[alternateImage release];
		alternateImage = [newAltImage copy];
		[self setNeedsDisplay:YES];
	}
}

@end
