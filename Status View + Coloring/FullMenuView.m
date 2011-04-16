//
//  FullMenuView.m
//  StatusItem
//
//  Created by Joshua Garnham on 07/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FullMenuView.h"

@implementation FullMenuView
@synthesize fieldEditor;

- (void) drawRect:(NSRect)dirtyRect
{
    NSRect fullBounds = [self bounds];
/*    fullBounds.size.height += 4;
    [[NSBezierPath bezierPathWithRect:fullBounds] setClip]; */
	
    // Then do your drawing, for example...
	NSGradient* aGradient =
	[[[NSGradient alloc]
	  initWithColorsAndLocations:
	  [NSColor colorWithDeviceRed:0.212 green:0.369 blue:0.949 alpha:1.000], (CGFloat)0.0,
	  [NSColor colorWithDeviceRed:0.416 green:0.529 blue:0.961 alpha:1.000], (CGFloat)1.0,
	  nil]
	 autorelease];
	[aGradient drawInRect:fullBounds angle:90];
}


@end
