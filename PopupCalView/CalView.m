//
//  CalView.m
//  PopupCalView
//
//  Created by R. Sharma on 8/7/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#define APP_COLOR [UIColor colorWithRed:153/255.0f green:204/255.0f blue:0/255.0f alpha:1.0f]

#import "CalView.h"
#import "AppDelegate.h"
#import "CircleView.h"
#import "LSCalCollectionCell.h"
#import "LSAlert.h"

@interface CalView ()
{
    
    BOOL isDraw;
    NSDate *strtDate;
    NSDateComponents *dC;
    NSCalendar *gregorian;
    NSDateFormatter *dateformatter;
    
}

@property(nonatomic,strong)NSArray *arrEvents;

@end

@implementation CalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        NSArray *arrObjects=[[NSBundle mainBundle] loadNibNamed:@"CalView" owner:self options:nil];
        self=[arrObjects objectAtIndex:0];
        frame.size.width=self.frame.size.width;
        frame.size.height=self.frame.size.height;
        [self setFrame:frame];
        [collectionView registerNib:[UINib nibWithNibName:@"CalCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CalViewCollectionCell"];
        
        
        
       
    }
    return self;
}


-(void)design
{
   
    
    dateformatter= [[NSDateFormatter alloc] init] ;
    
    NSDate *date = [NSDate date];
    gregorian = [NSCalendar currentCalendar];
    [gregorian setTimeZone:[NSTimeZone defaultTimeZone]];
    
    
    NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:date];
    
    _arrEvents=[self.datasource alertArrayForCalWeekView];
    

    
    
    
   
    
    
    NSDateComponents *dateComponentStartWeek=[[NSDateComponents  alloc] init];
    [dateComponentStartWeek setWeekday:2];
    [dateComponentStartWeek setWeekOfMonth:dateComponents.weekOfMonth];
    [dateComponentStartWeek setMonth:dateComponents.month];
    [dateComponentStartWeek setYear:dateComponents.year];
    [dateComponentStartWeek setHour:00];
    [dateComponentStartWeek setMinute:1];
    
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init] ;
    
    [componentsToAdd setDay:14];
    
    NSDate *endDate = [gregorian dateByAddingComponents:componentsToAdd toDate:[gregorian dateFromComponents:dateComponentStartWeek] options:0];
    
    NSDateComponents *dateComponentEndWeek=[gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayCalendarUnit) fromDate:endDate];
    
    strtDate=[gregorian dateFromComponents:dateComponentStartWeek];
    
    
    NSDateComponents *dCForMonth=[gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayCalendarUnit) fromDate:strtDate];
    
    NSInteger week=[dCForMonth weekOfMonth];
    NSInteger month = [dCForMonth month];
    
    NSString *monthName = [[dateformatter monthSymbols] objectAtIndex:(month-1)];
    lblLeftWeek.text=monthName.uppercaseString;
    
    
    
    
    monthName=[[dateformatter monthSymbols] objectAtIndex: (int)dateComponentEndWeek.month-1];
    lblRightWeek.text=monthName.uppercaseString;
    
    UIFont *fontMonth=[UIFont fontWithName:@"AvenirNext-Medium" size:15.0f];
    NSDictionary *attr = @{NSFontAttributeName: fontMonth};
    
    CGRect frameMonth=[lblLeftWeek.text boundingRectWithSize:CGSizeMake(3000, 20) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    CGRect leftWeekFrame=lblLeftWeek.frame;
    leftWeekFrame.size.width=frameMonth.size.width+17;
    [lblLeftWeek setFrame:leftWeekFrame];
    
    
    frameMonth=[lblRightWeek.text boundingRectWithSize:CGSizeMake(3000, 20) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    CGRect rightWeekFrame=lblRightWeek.frame;
    rightWeekFrame.size.width=frameMonth.size.width+17;
    rightWeekFrame.origin.x=self.frame.size.width-(frameMonth.size.width+17);
    [lblRightWeek setFrame:rightWeekFrame];
    
    
    
    monthName=[[dateformatter monthSymbols] objectAtIndex:dateComponents.month-1];
    if ([lblRightWeek.text isEqualToString:lblLeftWeek.text]) {
        [lblRightWeek setHidden:YES];
    }
    
    if ([lblLeftWeek.text isEqualToString:monthName.uppercaseString]) {
        
        [lblLeftWeek setBackgroundColor:[UIColor colorWithRed:153/255.0f green:204/255.0f blue:0/255.0f alpha:1.0f]];
        [lblRightWeek setBackgroundColor:[UIColor lightGrayColor]];
        
        
    }
    else
    {
        [lblRightWeek setBackgroundColor:[UIColor colorWithRed:153/255.0f green:204/255.0f blue:0/255.0f alpha:1.0f]];
        [lblLeftWeek setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    lblRightWeek= (UILabel*)[self roundCornersOnView:lblRightWeek onTopLeft:YES topRight:NO bottomLeft:YES bottomRight:NO radius:4.0f];
    lblLeftWeek=(UILabel*)[self roundCornersOnView:lblLeftWeek onTopLeft:NO topRight:YES bottomLeft:NO bottomRight:YES radius:4.0f];
    // lblLeftWeek.layer.cornerRadius=4.0f;
    // lblRightWeek.layer.cornerRadius=4.0f;
    
    [collectionView reloadData];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
    [self design];
    
    
}



#pragma mark- Collection View Datasource & Delegates

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
    {
        return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"CalViewCollectionCell";
    LSCalCollectionCell *cell=[collectionView1 dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell==nil) {
        
        NSArray *arrObjects=[[NSBundle mainBundle] loadNibNamed:@"CalCollectionCell" owner:self options:nil];
        cell=[arrObjects objectAtIndex:0];
        
        
        
    }
    
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:indexPath.row];
    
    
 
    
    
    NSDate *newDate2 = [gregorian dateByAddingComponents:components toDate:strtDate options:0];
    
    dC=[gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:newDate2];
    
    
    
    
    cell.lblWeekDay.text=[[[dateformatter weekdaySymbols] objectAtIndex:dC.weekday-1] substringToIndex:3];
    cell.lblDay.text=[NSString stringWithFormat:@"%d",dC.day];
    [cell.lblDay setBackgroundColor:[UIColor clearColor]];
    
    
    cell.lblDay.textColor=[UIColor whiteColor];
    
    cell.lblWeekDay.textColor=[UIColor whiteColor];
    
    BOOL checkSameDay=[self isSameDay:[NSDate date] otherDay:newDate2];
    if (checkSameDay) {
        cell.lblDay.layer.cornerRadius=4.0f;
        [cell.lblDay setBackgroundColor:[UIColor whiteColor]];
        cell.lblDay.textColor=APP_COLOR;
    }
    else if (![self isSameMonth:[NSDate date] otherMonth:newDate2])
    {
        [cell.lblDay setBackgroundColor:[UIColor clearColor]];
        cell.lblDay.textColor=[UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1.0f];
        
        cell.lblWeekDay.textColor=[UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1.0f];
        
    }
    
    
    
    
    
    
    for (UIView *view in cell.contentView.subviews) {
        if (![view isKindOfClass:NSClassFromString(@"UILabel")]) {
            [view removeFromSuperview];
        }
    }
    
    NSArray *arrEventOnthisDate; //=[[NSMutableArray alloc] init];
    
    /*
    for (LSAlert *alert in _arrEvents) {
        if ([self isSameDay:alert.date otherDay:newDate2]) {
            [arrEventOnthisDate addObject:alert];
        }
    }
    */
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setHour:23];
    [componentsToAdd setMinute:59];
    [componentsToAdd setTimeZone:[NSTimeZone defaultTimeZone]];
    
    
   
    
    
    NSDate *endDate = [gregorian dateByAddingComponents:componentsToAdd toDate:newDate2 options:0];
    
    
    NSPredicate *predicate=[NSPredicate
                  predicateWithFormat:@"date >= %@ AND date <= %@"
                  , newDate2
                            , endDate];
    
    arrEventOnthisDate=[_arrEvents filteredArrayUsingPredicate:predicate];
    
    
    
    
    /*
     This is for number of events in Calendar on this date
     
    NSInteger numberOfEvents=[self numberOfEventinCalendarOnDate:dC];
     */
   
    NSInteger numberOfEvents=arrEventOnthisDate.count;
    
    switch (numberOfEvents) {
        case 0:
            
            break;
        case 1:
            [self addCircleWithFrame:cell.lblWeekDay.frame numberOfCircle:numberOfEvents onCell:cell];
            break;
        case 2:
            [self addCircleWithFrame:cell.lblWeekDay.frame numberOfCircle:numberOfEvents onCell:cell];
            break;
        case 3:
            [self addCircleWithFrame:cell.lblWeekDay.frame numberOfCircle:numberOfEvents onCell:cell];
            break;
            
        default:
            [self addCircleWithFrame:cell.lblWeekDay.frame numberOfCircle:3 onCell:cell];
            break;
    }
    
    
  
    
    
    
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
}
-(NSInteger)numberOfEventinCalendarOnDate:(NSDateComponents*)dateComponenets
{
    
    AppDelegate *del=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [dateComponenets setHour:00];
    [dateComponenets setMinute:1];
    [dateComponenets setTimeZone:[NSTimeZone defaultTimeZone]];
    
    
    
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:23];
    [components setMinute:59];
    [components setTimeZone:[NSTimeZone defaultTimeZone]];
    
    
    // create a calendar
    
    
    NSDate *endDate = [gregorian dateByAddingComponents:components toDate:[gregorian dateFromComponents:dateComponenets] options:0];
    
    NSLog(@"print date %@ end date %@ datecomponetn ************ %@",[gregorian dateFromComponents:dateComponenets],endDate,dateComponenets);
    
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

-(void)addCircleWithFrame:(CGRect)frame numberOfCircle:(NSInteger)count onCell:(LSCalCollectionCell*)cell
{
    NSInteger circleHeight=10;
    NSInteger circleWidth=10;
    NSInteger width=frame.size.width;
    NSInteger startXaxis=frame.origin.x+(width- count*circleWidth)/2;
    NSInteger startYaxis=frame.origin.y-13;
    
    while (count!=0) {
        
        //  CircleView *viewCirlce=[[CircleView alloc] initWithFrame:CGRectMake(startXaxis,startYaxis , circleWidth, circleHeight)];
        
        CircleView *viewCirlce=[CircleView circleViewWithFrame:CGRectMake(startXaxis,startYaxis , circleWidth, circleHeight) andFillColor:APP_COLOR];
        
        [viewCirlce setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:viewCirlce];
        count--;
        
        startXaxis+=circleWidth;
        
    }
    
    
    
}




- (BOOL)isSameDay:(NSDate*)date1 otherDay:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

-(BOOL)isSameMonth:(NSDate*)date1 otherMonth:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return  [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}



-(UIView *)roundCornersOnView:(UIView *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius {
    
    if (tl || tr || bl || br) {
        
        UIRectCorner corner; //holds the corner
        //Determine which corner(s) should be changed
        if (tl) {
            corner = UIRectCornerTopLeft;
        }
        if (tr) {
            UIRectCorner add = corner | UIRectCornerTopRight;
            corner = add;
        }
        if (bl) {
            UIRectCorner add = corner | UIRectCornerBottomLeft;
            corner = add;
        }
        if (br) {
            UIRectCorner add = corner | UIRectCornerBottomRight;
            corner = add;
        }
        
        UIView *roundedView = view;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:roundedView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = roundedView.bounds;
        maskLayer.path = maskPath.CGPath;
        roundedView.layer.mask = maskLayer;
        return roundedView;
    } else {
        return view;
    }
    
}

@end
