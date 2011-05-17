//
//  Qiushi.m
//  QiuShiBaiKe
//
//  Created by Cheng Yao on 5/4/11.
//  Copyright 2011 Alex Yao. All rights reserved.
//

#import "Qiushi.h"


@implementation Qiushi

@synthesize content;
@synthesize mediumURL;
@synthesize thumbURL;
@synthesize author;
@synthesize tag;
@synthesize like;
@synthesize unlike;
@synthesize numberOfComments;
@synthesize thumbImage;
@synthesize mediumImage;
@synthesize lazyImageDelegate;

- (void)dealloc {
    self.content = nil;
    self.mediumURL = nil;
    self.thumbURL = nil;
    self.author = nil;
    self.tag = nil;
    self.thumbImage = nil;
    self.mediumImage = nil;
    
    [super dealloc];
}

- (id)initWithFlatHTML:(NSString *)html {
    self = [super init];
    if (self) {
        
        NSArray *temp = [html componentsSeparatedByString:@"<p class="];
        
        NSString *_content = [temp objectAtIndex:0];
        _content = [_content stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
        _content = [_content stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
        
        NSRange textRange;
        textRange = [_content rangeOfString:@"<img"];
        if ( textRange.location != NSNotFound) {
            self.content = [self plantTextByFilterAndSetImage:_content];
            NSLog(@"image found\n thumb: %@ \n full: %@", self.thumbURL, self.mediumURL);
        } else {
            self.content = _content;
        }
    }
    return self;
}

- (NSString *)plantTextByFilterAndSetImage:(NSString *)html {
    NSString *text = nil;
    NSArray* parts = [html componentsSeparatedByString:@"<a href="];
    NSLog(@"parts: %@", parts);
    text = [parts objectAtIndex:0];
    NSString *temp = [parts objectAtIndex:1];
    parts = [temp componentsSeparatedByString:@"\""];
    NSLog(@"parts: %@", parts);
    
    self.mediumURL = [parts objectAtIndex:1];
    self.thumbURL = [parts objectAtIndex:3];
    
    return text;
}
/*
- (UIImage *)thumbImage {
    if (thumbImage == nil) {
        thumbImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.thumbURL]]];
    }
    return thumbImage;
}
 */

- (void)startDownloadImageWithURL:(NSString *)imageURL forIndexPath:(NSIndexPath *)indexpath{
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    [NSURLConnection connectionWithRequest:req delegate:self];
}

@end
