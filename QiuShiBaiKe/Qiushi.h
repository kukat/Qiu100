//
//  Qiushi.h
//  QiuShiBaiKe
//
//  Created by Cheng Yao on 5/4/11.
//  Copyright 2011 Alex Yao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LazyTableImageDelegate
-(void)LazyTableImageDidDownload:(NSIndexPath *)indexPath;
@end


@interface Qiushi : NSObject {
    NSString *content;
    NSString *mediumURL;
    NSString *thumbURL;
    NSString *author;
    NSArray *tag;
    NSInteger like;
    NSInteger unlike;
    NSInteger numberOfComments;
    
    UIImage *thumbImage;
    UIImage *mediumImage;
    
    id<LazyTableImageDelegate> lazyImageDelegate;
}

@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *mediumURL;
@property (nonatomic, retain) NSString *thumbURL;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSArray *tag;
@property (nonatomic) NSInteger like;
@property (nonatomic) NSInteger unlike;
@property (nonatomic) NSInteger numberOfComments;
@property (nonatomic, retain) UIImage *thumbImage;
@property (nonatomic, retain) UIImage *mediumImage;
@property (nonatomic, assign) id <LazyTableImageDelegate> lazyImageDelegate;

- (id)initWithFlatHTML:(NSString *)html;
- (NSString *)plantTextByFilterAndSetImage:(NSString *)html;

- (void)startDownloadImageWithURL:(NSString *)imageURL forIndexPath:(NSIndexPath *)indexpath;

@end
