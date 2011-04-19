//
//  JGMenuItem.h
//  StatusItem
//
//  Created by Joshua Garnham on 17/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface JGMenuItem : NSObject {
	NSString *title;
	id target;
	SEL action;
	NSImage *image;
	BOOL enabled;
}

@property (nonatomic, retain, readonly) NSString *title;
@property (nonatomic, assign, readonly) id target;
@property (nonatomic, assign, readonly) SEL action;
@property (nonatomic, copy) NSImage *image;
@property (nonatomic, assign) BOOL enabled;
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (NSString *)seperatorItem; 

@end
