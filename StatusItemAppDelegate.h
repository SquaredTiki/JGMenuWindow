//
//  StatusItemAppDelegate.h
//  StatusItem
//
//  Created by Joshua Garnham on 07/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JGMenuWindowController.h"

@interface StatusItemAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	
	IBOutlet NSView *customView;
	IBOutlet NSSearchField *searchField;
	
	JGMenuWindowController *menuController;
}

@property (assign) IBOutlet NSWindow *window;

@end
