//
//  QiushiTableViewController.h
//  QiuShiBaiKe
//
//  Created by Cheng Yao on 5/3/11.
//  Copyright 2011 Alex Yao. All rights reserved.
//

#define CELL_PADDING 10.0f

#import <UIKit/UIKit.h>
#import "CLTableViewController.h"


@interface QiushiTableViewController : CLTableViewController {
    NSString *parameterF;
    NSMutableArray *list;
    NSMutableData *recivedData;
}

@property (nonatomic, retain) NSMutableArray *list;

- (id)initWithParameter:(NSString *)f;

@end
