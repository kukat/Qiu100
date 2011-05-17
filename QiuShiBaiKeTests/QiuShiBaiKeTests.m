//
//  QiuShiBaiKeTests.m
//  QiuShiBaiKeTests
//
//  Created by Cheng Yao on 5/3/11.
//  Copyright 2011 Alex Yao. All rights reserved.
//

#import "QiuShiBaiKeTests.h"
#import "Qiushi.h"


@implementation QiuShiBaiKeTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    Qiushi* qiushi = [[Qiushi alloc] initWithFlatHTML:@"最近工作不顺，陷入困境，求RP，求早点走出困境，求过。 "
                      "<br>………………哥斯拉……………… "
                      "<br>昨天在商场看到的，这是个神马牌子啊 "
                      "<br>让我想起了晖、晃、炅、晁、昆等YD的字<br/>"
                      "<a href=\"http://www.qiushibaike.com/system/pictures/919440/medium/20110504174417977.jpg\">"
                      "<img  src=\"http://www.qiushibaike.com/system/pictures/919440/small/20110504174417977.jpg\" />"
                      "</a>"
                      "<br/>"
                      "<p class=\"tags\" >"
                      "<span>标签</span>&nbsp;<a href=\"/groups/2/tag/%E6%97%A5%E7%A5%9E\" rel=\"tag\">日神</a>&nbsp;<a href=\"/groups/2/tag/%E6%98%AF%E4%B8%AA%E7%A5%9E%E9%A9%AC%E5%A4%A7%E7%A5%9E\" rel=\"tag\">是个神马大神</a>&nbsp;</p>"
                      "<p class=\"vote\">"
                      "<img src=\"/images/qiushi/good.gif?1\" alt=\"支持\"/>0  &nbsp;|&nbsp;<img src=\"/images/qiushi/bad.gif?1\" alt=\"囧\"/>-1  &nbsp;|&nbsp;<a href=\"/wap2_comments.php?id=919440\">"
                      "<strong>0</strong>条评论</a>"
                      "</p>"
                      "</div>"];
    [qiushi release];
    
    STFail(@"Unit tests are not implemented yet in QiuShiBaiKeTests");
}

@end
