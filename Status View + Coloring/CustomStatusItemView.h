//
//  CustomStatusItemView.h
//  StatusItem
//
//  Created by Joshua Garnham on 14/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CustomStatusItemView : NSView {
	id target;
	SEL selectingAction;
	SEL deselectingAction;
	
	BOOL highlighted;
}

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selectingAction;
@property (nonatomic, assign) SEL deselectingAction;
@property (nonatomic, assign) BOOL highlighted;

@end
