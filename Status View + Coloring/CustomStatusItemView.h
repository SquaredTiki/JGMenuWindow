//
//  CustomStatusItemView.h
//  StatusItem
//
//  Created by Joshua Garnham on 14/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CustomStatusItemView : NSView {
	NSStatusItem *statusItem;

	id target;
	SEL selectingAction;
	SEL deselectingAction;
	
	BOOL highlighted;
	
	NSImage *image;
	NSImage *alternateImage;
	
	NSString *title;
	
	NSAttributedString *_attributedTitle;
}

@property (nonatomic, retain) NSStatusItem *statusItem;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selectingAction;
@property (nonatomic, assign) SEL deselectingAction;
@property (nonatomic, assign) BOOL highlighted;
@property (copy, nonatomic) NSImage *image;
@property (copy, nonatomic) NSImage *alternateImage;
@property (copy, nonatomic) NSString *title;
@property (nonatomic, retain) NSAttributedString *_attributedTitle;

@end
