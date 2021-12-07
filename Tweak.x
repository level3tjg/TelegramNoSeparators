#import <UIKit/UIKit.h>

@interface ASDisplayNode : NSObject
@property id supernode;
- (BOOL)isSeparatorNode;
@end

@interface CALayer (AsyncDisplayKit)
@property ASDisplayNode *asyncdisplaykit_node;
@end

%hook CALayer
- (void)setBackgroundColor:(CGColorRef)color {
	if ([self.asyncdisplaykit_node isSeparatorNode])
		color = UIColor.clearColor.CGColor;
	%orig;
}
%end

%hook ASDisplayNode
%new
- (BOOL)isSeparatorNode {
	for (NSString *name in @[
		@"separatorNode",
		@"topSeparatorNode",
		@"bottomSeparatorNode",
		@"topStripeNode",
		@"bottomStripeNode"
	]) {
		if ([self isEqual:object_getIvar(self.supernode, class_getInstanceVariable(object_getClass(self.supernode), name.UTF8String))]) {
			return YES;
		}
	}
	return NO;
}
%end