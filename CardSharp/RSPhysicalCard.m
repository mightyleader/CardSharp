//
//  RSPhysicalCard.m
//  CardSharp
//
//  Created by Robert Stearn on 14.05.12.
//  Copyright (c) 2012 Apple UK Retail. All rights reserved.
//

#import "RSPhysicalCard.h"

#define kLox CGRectGetMinX (rect)
#define kMix CGRectGetMidX (rect)
#define kMax CGRectGetMaxX (rect)
#define kLoy CGRectGetMinY (rect)
#define kMiy CGRectGetMidY (rect)
#define kMay CGRectGetMaxY (rect)
#define kCorner 20.0


@implementation RSPhysicalCard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
	{
		[self setBackgroundColor:[UIColor clearColor]];  
		CALayer *layer = self.layer;
		layer.shadowColor = [[UIColor blackColor] CGColor];
		layer.shadowOffset = CGSizeMake(2.0f,5.0f);
		layer.shadowOpacity = .7f;
		layer.shadowRadius = 10.0f;
	}
	
    return self;
}


- (void)drawRect:(CGRect)rect
{
	CGContextRef current_context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(current_context);
	UIBezierPath *cardPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:kCorner];
	[cardPath addClip];
	CGContextSetRGBFillColor(current_context, 1.0, 1.0, 1.0, 1.0);
	[cardPath fill];
	[self applyNoise];
	CGContextRestoreGState(current_context); 
	[self setNeedsDisplay];
	
}


@end
