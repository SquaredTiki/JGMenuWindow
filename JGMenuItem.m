//
//  JGMenuItem.m
//  StatusItem
//
//  Created by Joshua Garnham on 17/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JGMenuItem.h"

@implementation JGMenuItem
@synthesize title, target, action, enabled, submenu;
@dynamic image;

- (id)initWithTitle:(NSString *)str target:(id)trg action:(SEL)act {
	self = [super init];
	if (self) {
		title = [str copy];
		target = trg;
		action = act;
		enabled = YES;
	}
	return self;
}

+ (NSString *)seperatorItem {
	return [[self alloc] initWithTitle:@"--[SEPERATOR]--" target:NULL action:NULL];
}

- (NSImage *)image {
	return image;
}

- (void)setImage:(NSImage *)newImage {
	[image release];
	image = [newImage copy];
}

@end
