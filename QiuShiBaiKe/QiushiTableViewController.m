//
//  QiushiTableViewController.m
//  QiuShiBaiKe
//
//  Created by Cheng Yao on 5/3/11.
//  Copyright 2011 Alex Yao. All rights reserved.
//

#import "QiushiTableViewController.h"
#import "Qiushi.h"

@interface QiushiTableViewController (Private) 

@property (nonatomic, retain) NSMutableData *recivedData;

@end


@implementation QiushiTableViewController

@synthesize list;


- (id)initWithParameter:(NSString *)f {
    self = [super initWithTableViewStyle:UITableViewStyleGrouped];
    if (self) {
        parameterF = [f retain];
    }
    return self;
}

- (void)dealloc
{
    if (list != nil && list.count>0) {
        for (Qiushi *qiushi in list) {
            [qiushi release];
        }
        self.list = nil;
    }
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor blackColor];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    
    NSMutableString * urlString = [NSMutableString stringWithString:@"http://www.qiushibaike.com/wap2_index.php"];
    
    if (![parameterF isEqualToString:@""]) {
        [urlString appendFormat:@"?f=%@", parameterF];
    }
    
    // debug
    urlString = [NSMutableString stringWithString:@"http://192.168.1.2/~alex/qiubai.html"];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection connectionWithRequest:req delegate:self];
    NSLog(@"req: %@", urlString);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (NSMutableArray *)list {
    if (list == nil) {
        list = [[NSMutableArray alloc] init];
    }
    return list;
}

- (NSMutableData *)recivedData {
    if (recivedData == nil) {
        recivedData = [[NSMutableData alloc] init];
    }
    return recivedData;
}

#pragma mark - Table view data source

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.list.count;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QiushiCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
    
    Qiushi *qiushi = [self.list objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.textLabel.text = qiushi.content;
    cell.textLabel.numberOfLines = 0;
    
    if (qiushi.thumbURL) {
        if (qiushi.thumbImage == nil) {
            <#statements#>
        } else {
            cell.imageView.image = qiushi.thumbImage;
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Qiushi *qiushi = [self.list objectAtIndex:indexPath.row];;
    
    CGSize s = [qiushi.content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(440, 999) lineBreakMode:UILineBreakModeWordWrap];
    return s.height + CELL_PADDING * 3;
}


#pragma mark - Table view delegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLTableViewController* viewController = [[CLTableViewController alloc] initWithTableViewStyle: UITableViewStylePlain];
    [self pushDetailViewController: viewController];
    [viewController release];
}

#pragma mark - NSURLConnection
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
    assert( [httpResponse isKindOfClass:[NSHTTPURLResponse class]] );
    
    NSLog(@"response status code: %d", [httpResponse statusCode]);
    assert( (httpResponse.statusCode / 100) == 2);
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.recivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSAssert1(0, @"connection did fail with error: %@", error.description);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *html = [[NSString alloc] initWithData:self.recivedData encoding:NSUTF8StringEncoding];
//    NSLog(@"html: %@", html);
    NSArray *temp = [html componentsSeparatedByString:@"<div class=\"qiushi\">"];
    NSMutableArray *components = [NSMutableArray arrayWithArray:temp];
    [components removeObjectAtIndex:0];
    [components removeLastObject];
    
    for (NSString *qiushiHTML in components) {
        Qiushi *qiushi = [[Qiushi alloc] initWithFlatHTML:qiushiHTML];
        [self.list addObject:qiushi];
        [qiushi release];
    }
    
    NSLog(@"components: %d", components.count);
    
    [html release];
    
    [self.tableView reloadData];
}

@end
