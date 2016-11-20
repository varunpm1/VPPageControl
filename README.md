# VPPageControl
This is a custom page control (similar to UIPageControl) for iOS that has different options
for displaying page control views.

## Installation
Drag and drop the VPPageControl into the project file and start using it :)

## Requirements

1. iOS 7.0 or later.
2. ARC memory management.

## Usage
After adding VPPageControl file into your project, there are 2 ways to create page control.

1. By adding an empty view to your xib/storyboard and 
changing the class of the view to VPPageControl. After adding the view
create an outlet.

2. Programmatically set the property for the view.

For the oulet/property of the view set the necessary properties.

The available public properties are:
### pageControlType

This defines how the page control dots would look like. The current available
options are:

* **RoundedFilled** // Circular with filled states. Default UIPageControl type. This is the default type
* **RoundedBorder** // Circular with border type. Only Border and border color will be representing the states
* **RoundedBorderFilledSelected** // Circular with border type. Border color will be representing the unselected state. Filled represents the selected state
* **RoundedFilledBorderSelected** // Circular with filled type. Filled color will be representing the unselected state. Border represents the selected state
* **SquareFilled** // Square with filled states. Fill color represent the states
* **SquareBorder** // Square with border type. Border color will be representing the states
* **SquareBorderFilledSelected** // Square with border type. Border color will be representing the unselected state. Filled represents the selected state
* **SquareFilledBorderSelected** // Square with filled type. Filled color will be representing the unselected state. Border represents the selected state
* **DiamondFilled** // Diamond with filled states. Fill color represent the states
* **DiamondBorder** // Diamond with border type. Border color will be representing the states
* **DiamondBorderFilledSelected** // Diamond with border type. Border color will be representing the unselected state. Filled represents the selected state
* **DiamondFilledBorderSelected** // Diamond with filled type. Filled color will be representing the unselected state. Border represents the selected state

### numberOfPages

This defines the number of page controls that should be present.

### currentPage

This defines which page index is selected. Default will be 0 (indexing starts from 0).

### pageIndicatorTintColor

This defines the color for the page control that isn't selected (unselected page control color).

### currentPageIndicatorTintColor

This defines the color for the page control that is selected (selected page control color).

### delegate

This is used for receiving notifications on changes of page control states.


VPPageControl has one delegate method for handling the changes of states.

### func pageControl(pageControl : VPPageControl, didSelectPageIndex pageIndex : Int)

This is called whenever the page changes for any necessary UI modification.

The following is a sample of VPPageControl options. There are some more similar
options.

# ![Screenshot](/VPPageControl-Screenshot.png)

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

###Version 1.1.0
##Swift 3.0 Support added

Fixed spacing issue in diamond type.

###Version 1.0.0

Stable page control with support for rounded, square and diamond shaped
page control with bordered, filled or both states for representing the 
selected or unselected state.


## License
The MIT License (MIT)

Copyright (c) 2016 Varun P M

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
