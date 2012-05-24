//
//  BCSpade.m
//  CardSharp
//
//  Created by Robert Stearn on 22/05/2012.
//  Copyright (c) 2012 All rights reserved.
//

#import "BCSpade.h"

#define PI 22/7
#define max CGRectGetMaxX(self.bounds)
#define mix CGRectGetMidX(self.bounds)
#define lox CGRectGetMinX(self.bounds)
#define may CGRectGetMaxY(self.bounds)
#define miy CGRectGetMidY(self.bounds)
#define loy CGRectGetMinY(self.bounds)

@implementation BCSpade

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
	{
		[self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	CGContextSaveGState(currentContext);
	CGContextSetRGBStrokeColor(currentContext, 0.0, 0.0, 0.0, 1.0);
	CGContextSetRGBFillColor(currentContext, 0.0, 0.0, 0.0, 1.0);
	UIBezierPath *spadePath = [UIBezierPath bezierPath];
	[spadePath setLineWidth:1];
	[spadePath addArcWithCenter:CGPointMake(max * 0.725, may * 0.659) radius:max * 0.275 startAngle:5.657 endAngle:	2.566 clockwise:YES];
	[spadePath addArcWithCenter:CGPointMake(max * 0.275, may * 0.659) radius:max * 0.275 startAngle:0.593 endAngle:	3.7 clockwise:YES];
	[spadePath addLineToPoint:CGPointMake(mix, may*0.09)];
	[spadePath closePath];
	[spadePath fill];
	
	UIBezierPath *footPath = [UIBezierPath bezierPath];
	[footPath addArcWithCenter:CGPointMake(max*0.275, may*0.775) radius:max*0.225 startAngle:0.0 endAngle:1.571 clockwise:YES];
	[footPath addLineToPoint:CGPointMake(max*0.725, may * 0.963 )];
	[footPath addArcWithCenter:CGPointMake(max*0.725, may*0.775) radius:max*0.225 startAngle:1.571 endAngle:3.142 clockwise:YES];
	[footPath closePath];
	[footPath fill];
	CGContextRestoreGState(currentContext);
}


@end
