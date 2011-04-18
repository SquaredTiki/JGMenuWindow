//
//  CustomStatusItemView.m
//  StatusItem
//
//  Created by Joshua Garnham on 14/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomStatusItemView.h"

@implementation CustomStatusItemView
@synthesize statusItem, target, selectingAction, deselectingAction, _attributedTitle;
@dynamic highlighted, image, alternateImage, title;

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
	
	NSRect centeredRect = NSMakeRect(0, 0, 0, 0);
	if (drawnImage) {
		centeredRect = NSMakeRect(0, 0, [drawnImage size].width, [drawnImage size].height);
		// align left if we have a title
		if(_attributedTitle) {
			centeredRect.origin.x = 5;
		} else {
			centeredRect.origin.x = NSMidX([self bounds]) - ([drawnImage size].width / 2);
		}
		centeredRect.origin.y = NSMidY([self bounds]) - ([drawnImage size].height / 2);
		centeredRect = NSIntegralRect(centeredRect);
		[drawnImage drawInRect:centeredRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
	
	if(_attributedTitle)
	{
		NSRect titleRect = NSMakeRect(5 + centeredRect.size.width + centeredRect.origin.x, centeredRect.origin.y - 1, [self bounds].size.width - (centeredRect.size.width + 2) , [self bounds].size.height - centeredRect.origin.y);
		NSMutableAttributedString *attrTitle = [_attributedTitle mutableCopy];
		if(highlighted)
		{
			NSColor *color = [NSColor selectedMenuItemTextColor];
			[attrTitle addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [attrTitle length])];
		}
		else {
			NSShadow *textShadow = [[NSShadow alloc] init];
			[textShadow setShadowColor:[NSColor colorWithCalibratedWhite:1.0f alpha:0.6f]];
			[textShadow setShadowOffset:NSMakeSize(0, -1)];
			[attrTitle addAttribute:NSShadowAttributeName value:textShadow range:NSMakeRange(0, [attrTitle length])];
			[textShadow release];
		}
		[attrTitle drawInRect:titleRect];
		[attrTitle release];
	}
	
	if (!highlighted && image == nil && title == nil) {
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
		if (image != nil && title == nil) {
			NSRect newFrame = [self frame];
			newFrame.size.width = [[self image] size].width + 8; // 12 px padding, 6 on each side maybe? not sure what might be the usual
			[self setFrame:newFrame];
		} else if (image == nil && title != nil) {
			NSSize size = [title sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont menuBarFontOfSize:[NSFont systemFontSize] + 2.0f] forKey:NSFontAttributeName]];
			NSRect newFrame = [self frame];
			newFrame.size.width = size.width + 10;
			[self setFrame:newFrame];
		} else if (image != nil && title != nil) {
			NSSize size = [title sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont menuBarFontOfSize:[NSFont systemFontSize] + 2.0f] forKey:NSFontAttributeName]];
			NSRect newFrame = [self frame];
			newFrame.size.width = (size.width + 10) + ([[self image] size].width + 8);
			[self setFrame:newFrame];
		}
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

- (NSString *)title {
	return title;
}

- (void)setTitle:(NSString *)newTitle
{
	if(newTitle != title)
	{
		[title release];
		title = [newTitle copy];
		
		NSFont *font = [NSFont menuBarFontOfSize:[NSFont systemFontSize] + 2.0f]; // +2 seemed to make it look right, maybe missed a font method for menu?
		NSColor *color = [NSColor controlTextColor];
		NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
									font, NSFontAttributeName,
									color, NSForegroundColorAttributeName,
									nil];
		NSAttributedString *attrTitle = [[NSAttributedString alloc] initWithString:self.title attributes:attributes];
		_attributedTitle = [attrTitle copy];
		[attrTitle release];
		
		[self _resizeToFitIfNeeded];
		[self setNeedsDisplay:YES];
	}
}

@end
