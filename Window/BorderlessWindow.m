//
//  BorderlessWindow.m
//  IDZR
//
//  Created by Joshua Garnham on 27/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BorderlessWindow.h"
#import "RoundWindowFrameView.h"

@implementation BorderlessWindow

- (id)initWithContentRect:(NSRect)contentRect 
                styleMask:(NSUInteger)aStyle 
                  backing:(NSBackingStoreType)bufferingType 
                    defer:(BOOL)flag
{
    if ((self = [super initWithContentRect:contentRect 
								 styleMask:NSBorderlessWindowMask
								   backing:bufferingType
									 defer:flag]))
    {    
		[self setOpaque:NO];
		[self setBackgroundColor:[NSColor clearColor]];
		[self setLevel:NSPopUpMenuWindowLevel+1];
    }
	
    return(self);
}

// setContentView:
//
// Keep our frame view as the content view and make the specified "aView"
// the child of that.
//
- (void)setContentView:(NSView *)aView
{
	if ([childContentView isEqualTo:aView])
	{
		//return;
	}
	
	NSRect bounds = [self frame];
	bounds.origin = NSZeroPoint;
	
	RoundWindowFrameView *frameView = [super contentView];
	if (!frameView)
	{
		frameView = [[[RoundWindowFrameView alloc] initWithFrame:bounds] autorelease];
		
		[super setContentView:frameView];
	}
	
	childContentView = aView;
	[childContentView setFrame:[self contentRectForFrameRect:bounds]];
	[childContentView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
	[frameView addSubview:childContentView];
}

- (NSView *)contentView
{
	return childContentView;
}

- (BOOL) canBecomeKeyWindow { return YES; }
- (BOOL) canBecomeMainWindow { return YES; }
- (BOOL) acceptsFirstResponder { return YES; }
- (BOOL) becomeFirstResponder { return YES; }
- (BOOL) resignFirstResponder { return YES; }

@end
