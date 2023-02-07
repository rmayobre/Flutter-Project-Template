# Flutter Project Template (Work in Progress)

**This template is still in early development; expect breaking changes.**

A Flutter templated project with code provided to help abstract implementations of 3rd party library tools. The goal of
this project is not to import 3rd party dependencies and write common code. The real goal is to provide a framework
of code that can be changed without disrupting existing code. 

For example, lets say implement your favorite analytics library. One day you decided you need to start using another 
service for hosting your analytics. They do not support the current analytics library inside your project. Now,
all code using the analytics library has to be updated to the new library.

Inside of the `framework` package, there is an interface for `Analytics`. Instead of updating every part of your project
that implements your original analytics library, you only have to create a new class that inherits the `Analytics` class.
Once you have your new `Analytics` class, construct in the `main` function, and pass to the `ApplicationScope`. Now your
entire project has the updated library!

## Packages

### Framework

This is where the entire project's interfaces rest. Majority of the project will import this package (except for `models`,
`theme`, and `widgets`). You will find many interfaces provided within the `framework` package. Such as: **logging**, **routing**, **storage**, even
**repositories** for managing remote APIs.

### Models

The data structures expected from `Repositories`. This includes the `Event`s to control `Repositories`.

### Pages

This project utilizes flutter's navigation 2.0 implementations. A page represents a full screen widget. A page comes with
a `PageScope` to help store data and perform logging/analytics. Each page also has access to the `ApplicationScope`, where
you can find data/tools to be used throughout the entire app (including `Repositories`).

### Repositories

These are classes that represent async data. Repositories can provided objects in the form of a `Future`, `Stream`,
`ValueListenable`, and a `StateListenable`. A `StateListenable` is like a `ValueListenable`, but provides a `RepoState` 
as the value.

### Theme

The application's theme is declared in this package.

### Toolbox

Majority of framework's interfaces are implemented here. This is to keep the 3rd party library code out of the rest of 
the project, and hide it behind the common interfaces.

### Widgets

Widgets to be used within the `Pages` package. Strictly uses `Flutter` as the only dependency.

## What I am still planning:
* Documentation - I want to have README documentation for each package, explaining how things works, example code, and hopefully diagrams.
* Better Styling - There is templated styling code implemented. I want to include more boilerplate coding to help with adopting M3 designs.
* Optimization - There is a lot of StatelessWidgets, which helps with performance, but here is more to optimization than StatelessWidgets.
* Layouts - I currently have two layouts (ResponsiveScaffold and ListDetail) and plan to include more.
* General Guidance - This is a very opinionated template. Some details into the decision making and how to work with the architecture is always nice.