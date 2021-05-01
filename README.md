# xcb

XCB (Xcode boilerplate) is a boilerplate code generator.
This is my first program ever in Ruby, I literally googled every line. You are welcome to improve it if you are a Ruby master!

# Installation

Clone the repository and run ```./install.sh``` in your terminal.

# How to

All you have to do is specify in the template folders the subfolders and the files that you want to be generated. You can find an mvp example by default in the template folder.

Run the following command to access the template folder

```open ~/.xcb/template```

# Usage 

If you want to create a new module just go to your project directory and run

```sh ~/.xcb/xcb.sh Home```

this will create at the top level of your project a folder called Home and all the boilerplate files

If you want to specify the targets of the files just run

```sh ~/.xcb/xcb.sh Home targets=target1,target2```

If you want to specify a folder under your main target just run

```sh ~/.xcb/xcb.sh Home folder=MyFolder```

# Placeholders

Supported placeholders that you can use for the text right now:

```template``` will be replaced with the name of the module

```dd``` will be replaced by the day of creation

```mm``` will be replaced by the month of creation

```yy``` will be replaced by the year of creation

```project_name``` will be replaced by the project name

```user_name``` will be replaced by the user name of the system



