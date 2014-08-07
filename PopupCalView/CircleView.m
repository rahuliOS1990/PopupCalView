//
//  CircleView.m
//  PopupCalView
//
//  Created by R. Sharma on 8/7/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    /*
    CGFloat lineWidth = 4;
    CGRect borderRect = CGRectMake(self.frame.size.width/2, self.frame.size.height - 20, 10.0, 10.0);
    borderRect = CGRectInset(borderRect, lineWidth * 0.5, lineWidth * 0.5);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 85.0/255.0, 143.0/255.0, 220.0/255.0, 1.0);
   CGContextSetRGBFillColor(context, 115.0/255.0, 143.0/255.0, 120.0/255.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    CGContextFillEllipseInRect (context, borderRect);
    CGContextStrokeEllipseInRect(context, borderRect);

    CGContextFillPath(context);
    
   
    
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // Set the border width
    CGContextSetLineWidth(contextRef, 1.0);
    
    // Set the circle fill color to GREEN
    CGContextSetRGBFillColor(contextRef, 0.0, 255.0, 0.0, 1.0);
    
    // Set the cicle border color to BLUE
    CGContextSetRGBStrokeColor(contextRef, 0.0, 0.0, 255.0, 1.0);
    
    // Fill the circle with the fill color
    CGContextFillEllipseInRect(contextRef, rect);
    
    // Draw the circle border
    CGContextStrokeEllipseInRect(contextRef, rect);
    
      */
    
    // Get the graphics context that we are currently executing under
    
    
    // Save the current graphics context settings
    
    
    // Set the color in the current graphics context for future draw operations
  
    
    // Create our circle path
    
    

    CGRect box = CGRectInset(self.bounds, self.bounds.size.width * 0.1f, self.bounds.size.height * 0.1f);
    UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithOvalInRect:box];
    [[UIColor whiteColor] setStroke];
    [[UIColor greenColor] setFill]; // Green here to show the black area
    [ballBezierPath stroke];
    [ballBezierPath fill];
    [self setBackgroundColor:[UIColor clearColor]];
   
   
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
