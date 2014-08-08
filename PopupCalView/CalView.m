//
//  CalView.m
//  PopupCalView
//
//  Created by R. Sharma on 8/7/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#import "CalView.h"
#import "AppDelegate.h"
#import "CircleView.h"


@interface CalView ()
{
    BOOL isDraw;
    NSDate *strtDate;
    NSDateComponents *dC;
    NSCalendar *gregorian;
    
}


@end

@implementation CalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
              // Initialization code
        

      

        collectionView.pagingEnabled=YES;
        
    
        
        NSArray *arrObjects=[[NSBundle mainBundle] loadNibNamed:@"CalView" owner:self options:nil];
        self=[arrObjects objectAtIndex:0];
        
        [collectionView registerNib:[UINib nibWithNibName:@"CalCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CalViewCollectionCell"];
    

        
        [self design];
    }
    return self;
}


-(void)design
{
    /*
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:date];
    NSInteger month = [dateComponents month];
    
    NSInteger week=[dateComponents week];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    NSString *monthName = [[df monthSymbols] objectAtIndex:(month-1)];
    UIFont *fontMonth=[UIFont fontWithName:@"AvenirNext-Medium" size:15.0f];
    NSDictionary *attr = @{NSFontAttributeName: fontMonth};
    
    NSString *strWeek=[[df weekdaySymbols] objectAtIndex:(week-1)];
    
    NSLog(@"week no, %d ster week %@",week,strWeek);
    
    
    
    CGRect frameMonth=[monthName boundingRectWithSize:CGSizeMake(3000, 20) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    NSLog(@"frame monteh %@",NSStringFromCGRect(frameMonth));
    isDraw=YES;
    //[self drawRect:frameMonth];
    
    CGRect backgroundLabel=frameMonth;
    backgroundLabel.size.width+=10;
    
           // Draw whatever you like
        UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithRect:backgroundLabel];
        [[UIColor whiteColor] setStroke];
        [[UIColor greenColor] setFill]; // Green here to show the black area
        [ballBezierPath stroke];
        [ballBezierPath fill];
 
    frameMonth.origin.x+=8;
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:frameMonth];
    lbl.text=monthName;
    lbl.font=fontMonth;
    lbl.textColor=[UIColor whiteColor];
    [self addSubview:lbl];
    
    
   // CGRect box = CGRectInset(self.bounds, self.bounds.size.width * 0.1f, self.bounds.size.height * 0.1f);
   
    
    */

    
    NSDate *date = [NSDate date];
    gregorian = [NSCalendar currentCalendar];
    [gregorian setTimeZone:[NSTimeZone defaultTimeZone]];
    

    NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:date];
    NSInteger month = [dateComponents month];
    
    NSInteger week=[dateComponents weekOfMonth];
    
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    NSString *monthName = [[df monthSymbols] objectAtIndex:(month-1)];
    UIFont *fontMonth=[UIFont fontWithName:@"AvenirNext-Medium" size:15.0f];
    NSDictionary *attr = @{NSFontAttributeName: fontMonth};
    
    
    
    NSInteger day=[dateComponents weekday];
    
    NSString *strday=[[df weekdaySymbols] objectAtIndex:(day-1)];
    
    NSLog(@"week no, %d ster week %@",week,strday);
    
    
    NSDateComponents *dateComponentStartWeek=[[NSDateComponents  alloc] init];
    [dateComponentStartWeek setWeekday:2];
    [dateComponentStartWeek setWeekOfMonth:dateComponents.weekOfMonth];
    [dateComponentStartWeek setMonth:dateComponents.month];
    [dateComponentStartWeek setYear:dateComponents.year];
    [dateComponentStartWeek setHour:dateComponents.hour];
    [dateComponentStartWeek setMinute:dateComponents.minute];
    
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init] ;
    
    [componentsToAdd setDay:14];
    
    NSDate *newDate2 = [gregorian dateByAddingComponents:componentsToAdd toDate:[gregorian dateFromComponents:dateComponentStartWeek] options:0];
    
    NSDateComponents *dateComponentEndWeek=[gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayCalendarUnit) fromDate:newDate2];
    
    strtDate=[gregorian dateFromComponents:dateComponentStartWeek];
    NSLog(@"date start %@ date end %@",[gregorian dateFromComponents:dateComponentStartWeek],[gregorian dateFromComponents:dateComponentEndWeek]);
 
    [collectionView reloadData];

    
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code

    
    //[self design];
   
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (strtDate) {
      
    
    return 14;
    }
    else
        return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"CalViewCollectionCell";
    UICollectionViewCell *cell=[collectionView1 dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell==nil) {
        
        NSArray *arrObjects=[[NSBundle mainBundle] loadNibNamed:@"CalCollectionCell" owner:self options:nil];
        cell=[arrObjects objectAtIndex:0];

                
    
    }
    
    int selected=indexPath.row%7;
    UILabel *lblWeekDay=[labels objectAtIndex:selected];
    NSLog(@"selected %@",lblWeekDay.text);
    
    
    
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:indexPath.row];
    

    // create a calendar

    
    NSDate *newDate2 = [gregorian dateByAddingComponents:components toDate:strtDate options:0];

    dC=[gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:newDate2];
    UILabel *lbl=(UILabel*)[cell viewWithTag:110];
    lbl.text=[NSString stringWithFormat:@"%d",dC.day];
    
    
    NSInteger numberOfEvents=[self numberOfEventinCalendarOnDate:dC];
    
    switch (numberOfEvents) {
        case 0:
            
            break;
         case 1:
            [self addCircleWithFrame:lblWeekDay.frame numberOfCircle:numberOfEvents];
            break;
        case 2:
                        [self addCircleWithFrame:lblWeekDay.frame numberOfCircle:numberOfEvents];
            break;
        case 3:
                        [self addCircleWithFrame:lblWeekDay.frame numberOfCircle:numberOfEvents];
            break;
            
        default:
                        [self addCircleWithFrame:lblWeekDay.frame numberOfCircle:3];
            break;
    }
    NSLog(@"number of events %d",numberOfEvents);

    
    NSLog(@"farame  %@  offset of frame ",NSStringFromCGRect(cell.frame));
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
}
-(NSInteger)numberOfEventinCalendarOnDate:(NSDateComponents*)dateComponenets
{
    
    AppDelegate *del=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [dateComponenets setHour:0];
    [dateComponenets setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSLog(@"print date %@",[gregorian dateFromComponents:dateComponenets]);
    

    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:23];
    [components setMinute:59];
    
    
    // create a calendar
    
    
    NSDate *endDate = [gregorian dateByAddingComponents:components toDate:[gregorian dateFromComponents:dateComponenets] options:0];
   
    
    NSPredicate *predicate = [del.eventStore predicateForEventsWithStartDate:[gregorian dateFromComponents:dateComponenets]
                                                                 endDate:endDate
                                                               calendars:nil];
    
    // Fetch all events that match the predicate
    NSArray *events = [del.eventStore eventsMatchingPredicate:predicate];
    
    return events.count;

    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat pageWidth = collectionView.frame.size.width;
    //pageControl.currentPage = collectionView.contentOffset.x / pageWidth;
    NSLog(@"page control  %f",collectionView.contentOffset.x / pageWidth);
}


#pragma mark- Add Circle

-(void)addCircleWithFrame:(CGRect)frame numberOfCircle:(NSInteger)count
{
   NSInteger circleHeight=10;
    NSInteger circleWidth=10;
    NSInteger width=frame.size.width;
    NSInteger startXaxis=frame.origin.x+(width- count*circleWidth)/2;
    NSInteger startYaxis=frame.origin.y-13;
    
    while (count!=0) {
       
        CircleView *viewCirlce=[[CircleView alloc] initWithFrame:CGRectMake(startXaxis,startYaxis , circleWidth, circleHeight)];
        
        [viewCirlce setBackgroundColor:[UIColor clearColor]];
        [self addSubview:viewCirlce];
        count--;

        startXaxis+=circleWidth;
        
    }
    
    

}

@end
