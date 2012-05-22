
#import "BCHeart.h"
#import <QuartzCore/QuartzCore.h>

#define PI 22/7
#define max CGRectGetMaxX(self.bounds)
#define mix CGRectGetMidX(self.bounds)
#define lox CGRectGetMinX(self.bounds)
#define may CGRectGetMaxY(self.bounds)
#define miy CGRectGetMidY(self.bounds)
#define loy CGRectGetMinY(self.bounds)

@implementation BCHeart

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
    CGContextSetRGBStrokeColor(currentContext, 255.0, 0.0, 0.0, 1.0);
    CGContextSetRGBFillColor(currentContext, 255.0, 0.0, 0.0, 1.0);
    UIBezierPath *heartPath = [UIBezierPath bezierPath];
    [heartPath setLineWidth:1];
    [heartPath addArcWithCenter:CGPointMake(max * 0.275, may * 0.341) radius:max * 0.275 startAngle:2.514 endAngle:5.692 clockwise:YES];
    [heartPath addArcWithCenter:CGPointMake(max * 0.725, may * 0.341) radius:max * 0.275 startAngle:3.736 endAngle:0.628 clockwise:YES];
    [heartPath addLineToPoint:CGPointMake(mix, may * 0.91)];
    [heartPath closePath];
    [heartPath fill];
    CGContextRestoreGState(currentContext);
}


@end
