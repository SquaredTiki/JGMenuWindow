# JGWindowMenu

The main aim of this project was to create a `NSWindow` and `NSTableView` with the appearance of a normal `NSMenu`. The benefits of this means that you can have a text field in what appears to be an `NSMenu`.

This project allows you to do this as you have an option to set a header view as well as the menu items, the header view will appear at the top and with the items just below much alike to Spotlight. 

# How To Use

Simply copy the required files to your project and initialise the controller like so:

    menuController = [[[JGMenuWindowController alloc] initWithWindowNibName:@"JGMenuWindow"] retain];

This will create the status item in the menu bar and set up all the actions for it. From there just set the properties you want like the `menuItems` and/or the `headerView`.

The only other thing you need to do is in the `applicationDidResignActive:` method close the menu by adding the line:

    [menuController closeWindow];

You can also receive delegate messages by subscribing to be the delegate like so:

    [menuController setMenuDelegate:self];

This allows you to know when a menu item has been selected.

# Demo App

The project is simply a demo which shows how it can be used in a similar fashion to Spotlight. If you are unsure how to use it just check the demo out.

# Limitations

As this was only a quick project there are some limitations: 

- the status item doesn't have a title and has just a gray background
- you cannot set an image for each item (because of `NSTableView`)
- you cannot set a custom view for each item (because of `NSTableView`)

# Screenshot

![Screen](http://a.yfrog.com/img610/825/66pd.png)