
#import "PageContentViewController.h"
#import "SubjectTableViewCell.h"

@interface PageContentViewController () <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

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
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectTableViewCell"];
    
    cell.nameLabel.text = @"name";
    cell.roomLabel.text = @"room";
    cell.timeLabel.text = @"time";
    cell.teacherLabel.text = @"teacher";
    
    return cell;
}

@end
