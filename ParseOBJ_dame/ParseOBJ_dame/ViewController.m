//
//  ViewController.m
//  ParseOBJ_dame
//
//  Created by Dameion Dismuke on 1/11/23.
//

#import "ViewController.h"

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *listJason;
@property (nonatomic, retain) NSMutableArray *stuff;


@end


@implementation ViewController


-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self stuff = [[NSMutableArray alloc] init];
    
    
    for(int index = 0; index < 5; index++){
        
        [self.stuff addObject:[NSString stringWithFormat:@"Row _stuff #%d", index]];
        
    }
    
    
    self.listJason.delegate = self;
    self.listJason.dataSource = self;
    [self.listJason.reloadData];
    
    
}


- (NSInteger)numberOfSectionsInTableView;(UITableView *) tableView {
    
    return 1; //this is the number of sections, so far
    
    
}

-(NSInteger)tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [self.stuff count]; //this will be the number of rows, obv
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    //this is to configure the cell
    NSString *title = [_stuff objectAtIndex:[indexPath indexAtPosition:1]];
    
    [[cell textLabel] setText:title];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    

    
    return cell;
    
}

-(BOOL)tableView: (UITableView *) tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *newView = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    [self presentingViewController : newView animated: YES completion: nil];
    
}

// THE MAIN PART: JSON PARSING!!!! SHEESH

-(void) getJSONData {
    
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://api.themoviedb.org/3/movie/popular?api_key=653c931d946bb2a9870f4ed725ecd322"]];
    
    NSError *error = nil;
    id response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error];
    
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    } else {
        
        self.stuff = response;
        NSLog(@"%@", self.stuff);
    }
    
    
    
}

@end
