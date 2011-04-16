//
//  FullMenuView.h
//  StatusItem
//
//  Created by Joshua Garnham on 07/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FullMenuView : NSView {
	NSTextView *fieldEditor;
}

@property (nonatomic, retain) NSTextView *fieldEditor;

@end
