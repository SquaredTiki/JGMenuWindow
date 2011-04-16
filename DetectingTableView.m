
#import "DetectingTableView.h"

@implementation DetectingTableView

- (void)awakeFromNib
{
	[[self window] setAcceptsMouseMovedEvents:YES];
	trackingTag = [self addTrackingRect:[self frame] owner:self userData:nil assumeInside:NO];
}

- (void)dealloc
{
	[self removeTrackingRect:trackingTag];
	[super dealloc];
}

- (void)viewDidEndLiveResize
{
	[super viewDidEndLiveResize];
	
	[self removeTrackingRect:trackingTag];
	trackingTag = [self addTrackingRect:[self frame] owner:self userData:nil assumeInside:NO];
}

@end