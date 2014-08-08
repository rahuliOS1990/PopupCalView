//
//  CalView.h
//  PopupCalView
//
//  Created by R. Sharma on 8/7/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalViewDataSource <NSObject>

-(NSArray*)alertArrayForCalWeekView;

@end



@interface CalView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

{
    IBOutlet   UICollectionView *collectionView;
    
    IBOutlet UILabel *lblLeftWeek;
    IBOutlet UILabel *lblRightWeek;
}

@property (weak, nonatomic) id<CalViewDataSource> datasource;

-(void)design;






@end
