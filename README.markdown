# JGMenuWindow

The main aim of this project was to create a `NSWindow` and `NSTableView` with the appearance of a normal `NSMenu`. The benefits of this means that you can have a text field in what appears to be an `NSMenu`.

This project allows you to do this as you have an option to set a header view as well as the menu items, the header view will appear at the top and with the items just below much alike to Spotlight. 

# How To Use

Simply copy the required files to your project and initialise the controller like so:

    menuController = [[[JGMenuWindowController alloc] initWithWindowNibName:@"JGMenuWindow"] retain];

This will create the status item in the menu bar and set up all the actions for it. From there just set the properties you want like the `menuItems` and/or the `headerView`.

# Demo App

The project is simply a demo which shows how it can be used in a similar fashion to Spotlight. If you are unsure how to use it just check the demo out.

# What Makes it better than a normal NSMenu?

The main advantages over a normal NSMenu are:

- live updating of menu items
- fully responsive text fields (or anything that uses a field editor)
- has option to appear as an Apple Pro menu

But most importantly it is **fully customizable** which the Apple Pro menu option stands an example of.

# Limitations

As this was only a quick project there are some limitations: 

- you cannot set a custom view for each item (because of `NSTableView`)

# Screenshot

![Screen](http://idzr.org/xd4e)

# Attribution

If you are using JGMenuWindow in your project please make sure you leave credit where credit is due.