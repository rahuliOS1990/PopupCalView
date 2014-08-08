//
//  CircleView.m
//  PopupCalView
//
//  Created by R. Sharma on 8/7/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#import "CircleView.h"
@interface CircleView()
{
    
}
@property(nonatomic,strong)UIColor *colorFill;
@end

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

+(CircleView *)circleViewWithFrame:(CGRect)frame andFillColor:(UIColor *)color
{
    CircleView *view=[[CircleView alloc] initWithFrame:frame];
    [view setColorFill:color];
    [view setNeedsDisplay];
    return view;
}

- (void)drawRect:(CGRect)rect {
    
    
    if (_colorFill) {
        
    
    CGRect box = CGRectInset(self.bounds, self.bounds.size.width * 0.1f, self.bounds.size.height * 0.1f);
    UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithOvalInRect:box];
    [_colorFill setStroke];
        [_colorFill setFill];
        [ballBezierPath stroke];
    [ballBezierPath fill];
    [self setBackgroundColor:[UIColor clearColor]];
   
    }
    
}




@end
