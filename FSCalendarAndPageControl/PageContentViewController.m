
#import "PageContentViewController.h"

@interface PageContentViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label;

@end


@implementation PageContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.label.text = [self.contentObject description];
}

@end