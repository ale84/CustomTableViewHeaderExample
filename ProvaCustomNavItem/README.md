#CustomTableViewHeaderExample
An example of how to implement a table view controller with a fading header view and nav bar title like the one in Music App.  

![alt text](example.gif "example")

##Details
- The header view is moved by updating the constant value of the constraint that ties it to the navigation bar in the scrollView delegate. 
- The alpha value for the header view and nav bar title is updated while scrolling based on the scrolled amount and the contentOffset.
- The tableView content is inset to adjusted to account for the presence of the header view. 
