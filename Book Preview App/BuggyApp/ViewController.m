

#import "ViewController.h"
#import "Story.h"

@implementation ViewController

UIImageView *coverImg;
UILabel *titleLabel;
UILabel *authorLabel;
NSString *next;
NSMutableString *next2;

UIImage *downloadedImage;

float height;
float width;

- (void) fetchData {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.wattpad.com/api/v3/stories?limit=1&fields=stories(id%2Ctitle%2Clength%2Ccover%2Ctags%2Cdescription%2Cuser)&fields=stories(id%2Ctitle%2Clength%2Ccover%2Ctags%2Cdescription%2Cuser)"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    
    NSURLSessionDataTask *task = [[self getURLSession] dataTaskWithRequest:request completionHandler:^( NSData *data, NSURLResponse *response, NSError *error )
                                  {
                                      NSError *jsonError;
                                      NSArray *parsedJSONArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                                      NSString *title = [[parsedJSONArray valueForKey:@"stories"][0]valueForKey:@"title"];
                                      
                                      NSString *author = [[[parsedJSONArray valueForKey:@"stories"][0]valueForKey:@"user"]valueForKey:@"name"];
                                      NSString *cover = [[parsedJSONArray valueForKey:@"stories"][0]valueForKey:@"cover"];
                                      
                                      __block Story *storyObj = [[Story alloc]
                                                                 initWithTitle:title
                                                                 author:author cover:cover];
                                      
                                      downloadedImage = [UIImage imageWithData:
                                                         [NSData dataWithContentsOfURL:[NSURL URLWithString:storyObj.cover]]];
                                      
                                      NSString *authortag = @"Author: ";
                                      NSString *authorline = [authortag stringByAppendingString:storyObj.author];
                                      
                                      next = [parsedJSONArray valueForKey:@"nextUrl"];

                                      dispatch_async( dispatch_get_main_queue(),
                                                     ^{
                                                        // parse returned JSON array
                                                         
                                                         
                                                         
                                                         [titleLabel setText:storyObj.title];
                                                         [authorLabel setText:authorline];
                                                         coverImg.image = downloadedImage;
                                                         
                                                         
                                                     } );
                                      
                                      
                                  }];
    
    [task resume];
    
}

- ( NSURLSession * )getURLSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken,
                  ^{
                      NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                      session = [NSURLSession sessionWithConfiguration:configuration];
                  } );
    
    return session;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    
    height = [[UIScreen mainScreen] bounds].size.height;
    
    width = [[UIScreen mainScreen] bounds].size.width;
    
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, height/7, width , height/10)];//Set frame of label in your viewcontroller.
    [titleLabel setBackgroundColor:[UIColor lightGrayColor]];//Set background color of label.
    [titleLabel setTextColor:[UIColor blackColor]];//Set text color in label.
    [titleLabel setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
    [titleLabel.layer setBorderWidth:1.0f];
    [titleLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
    [titleLabel setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
    [titleLabel setNumberOfLines:1];//Set number of lines in label.
    [self.view addSubview:titleLabel];
    
    authorLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, height/4, width, height/10)];//Set frame of label in your viewcontroller.
    [authorLabel setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
    [authorLabel.layer setBorderWidth:1.0f];
    [self.view addSubview:authorLabel];
    
    
    coverImg=[[UIImageView alloc]initWithFrame:CGRectMake(width/6, height/2.5, width/1.5, height/1.8)];//Set frame of label in your viewcontroller.
    [coverImg.layer setBorderWidth:2.0f];//Set border width of label.
    [self.view addSubview:coverImg];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(width/6, height/2.5, width/1.5, height/1.8); // position and width and height for the button.
    [btn setTitle:@"" forState:UIControlStateNormal];
    
    
    [btn addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self fetchData];

    
}
- (IBAction)showAlert:(id)sender {
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end
