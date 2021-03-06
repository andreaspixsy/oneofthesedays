# Gone are the days of a handful of simple html pages to make up a website. Projects can consist of many, many files and, especially with multiple people involved, this can become difficult to manage. From graphics to documentation to source code, a version control system (VCS) is an easy way to manage your project and ensure that nothing important is ever lost. This tutorial will take you through the basics of version control, setting up Subversion server on your PC, and lastly we'll look at how you keep track of your files.

### What is a Version Control System (VCS)?
# If you've ever asked yourself the question "how can I get back this change that I've overwritten", "this program used to work better before we added that feature" or, "can you send me the latest copy of your code before I make changes", then a VCS is your answer to them.  

# A VCS consists of a central repository which stores all of your project files. It keeps track of the files that are added and will store of all the changes that are made to them. This means that when you update a file, any previously saved work can be recovered by undoing particular updates. Multiple people can save to this same repository and so the VCS also takes care (with some user help, as we shall see) of managing files to ensure that no one can overwrite anyone elses work. Essentially, a VCS is turbo-charged undo/redo history for your computer.

# Before we get into setting up a VCS for ourselves, let's take a look at a common problem with VCS and how it's solved. Called the "Lost Update" problem, it occurs when 2 people are editing the same file at the same time and both want to save their changes. The image below is from the Subversion Book, which is the user guide for a common VCS.

# Obviously we don't want something like this happening and fortunately, VCS provide us with 2 methods of ensuring that it doesn't. The first method is called "Locking" (also known as "Reserved Checkouts") and involves 'locking' a file before editing it. 'Locking' the file means that no one else is able to edit the file until it is released again. This ensures that changes cannot be overwritten as there is only ever one person editing the file at a time. While this can cause problems, it offers complete assurance that work will not be overwritten.

# The second method is called "Merging" (also known as "Unreserved Checkouts") and involves merging copies of work when the same file has been edited. If the parts of the file that were edited are in different locations then the two files can automatically be merged by the system. If 'overlap' between edited parts occurs however then it is up to the user to manually combine the files. The code examples below illustrates two files that are to be merged both with, and without overlap.

#### Edit without overlap

#####Edit 1:
$edit1 = "The cat sat";
#rest of the code

#####Edit 2:

#rest of the code
$edit2 = "on the mat";


#As both edits are in different areas of the code, they can be merged with no conflicts. 

$edit1 = "The cat sat";
#rest of the code
$edit2 = "on the mat";

#### Edit with overlap

##### Edit 1:
$edit1 = "The cat sat";

##### Edit 2:
$edit1 =  "on the mat";


#In this case, the same line has been changed in both edits and so they cannot be automatically merged. Differencing tools can be used to find out what exactly is different between the files and so the desired parts of each can be chosen.

# Now that you have a basic understanding of what a VCS is and how they can help, let's look at setting one up and using it


### Installing Subversion
# There are 2 big version control systems (VCS) in use today, Concurrent Versions System (CVS) and Subversion (SVN). We'll be using SVN because CVS seems to be going out of fashion. 
# SVN itself does not have a graphical user interface and so to make things more familiar, we'll be using a program called TortoiseSVN to interact with it.

# If you have Apache 2.0 or greater installed then you can grab this release, <a href="http://subversion.tigris.org/files/documents/15/44049/Setup-Subversion-1.5.3.msi">here</a> 
# If you don't have Apache then you can get a standalone version from Slik SVN, <a href="http://www.sliksvn.com/pub/Slik-Subversion-1.5.4-win32.msi">here</a>. This is the version that we'll be using in this tutorial.

# Also download TortoiseSVN from <a href="http://downloads.sourceforge.net/tortoisesvn/TortoiseSVN-1.5.5.14361-win32-svn-1.5.4.msi?download">here</a>

# Once your chosen version of SVN and TortoiseSVN have been downloaded, double click to start installing. Choose the typical install for both programs.

# That's all there is to it! You now have a working VCS on your system and a great graphical interface to go with it. There is no program to start up to use SVN as TortoiseSVN integrates straight into the context (right-click) menu in windows explorer. Now let's get right into using it.

### Using SVN
# First of all we need to create a repository. This is where all of the saved project files and version information is kept. Create a new folder on your system and call it 'MyProject'. Right click on this folder and click TortoiseSVN -> Create repository here.

# Now we need to do what is called "checking out" the repository. This will create a working directory for us to add files and make changes. Think of this as downloding files from your FTP server in order to work on them locally.
# Right click on your desktop and click TortoiseSVN -> Checkout repository. A dialog box will open asking for the location of your repository. Enter in the path to where you created this. You can also specify what you would like to call your checked out folder. Click OK when you're done. You should now see a newly created folder with a green tick on it. This green tick is a TortoiseSVN icon that means the contents of your folder have the latest versions from the repository. 


# You may be wondering why we have to create our repository in one place, and check it out in another. The repository is not meant to be edited manually. It contains a number of files and folders which SVN uses to keep track of the changes. You could store this repository anywhere (including on another computer) and check it out in the same way.

# Now let's create a file. We'll deal with a very basic example to demonstrate the key actions so create a text file called numbers.txt in the checked out folder, and paste in the following text 

1
2
3
4
5
# Now that we've made some changes, we need to let SVN know about it. Right click in the folder and click on SVN Commit.

# 
# A dialog box will open asking you for a message to save along with the file. It is good practice to always comment on each commit you make. This will allow you to easily see what changes you've made and is especially helpful when you have multiple people working from the same repository. Enter in a quick sentance about what the file is (TortoiseSVN will give you hints for filenames as you type), tick the check box next to the file and then click OK.


# Your file has now been saved to the repository and a dialog box will open confirming this. Note that it says "Completed at revision 1", each time you commit the revision number will update. 

# Now we're able to keep track of our own changes, but what if we want to bring someone else into the project?. Right click on the desktop and checkout the repository again giving it the name 'DifferentUser'. Notice how the icon is not a green tick this time but a red exclamation mark. This means that our folder is not in sync with the repository as we have added a file from the first checkout. Go into this new folder, right click and click SVN Update. 

# You should now see the numbers.txt file in this folder. Let's make a change to this file. Open it up and replace the number 5 with the number 6. Let's also change the file in the first checkout we created, MyProject. Open the file and add the number 6 after the number 5 on a new line. We've now created a situation where 2 users have made different changes to the same file at the same time. Commit the changes in MyProject and the folder icon should have a green tick. Now go into the second folder and try to commit. You will get a dialog box pop up informing you that there is a conflict.

# We can now use TortoiseSVN to help us resolve this conflict. Right click in the folder and click TortoiseSVN -> Resolve conflicts. This brings up the TortoiseMerge window with which we can do this. The file on the left labelled 'Theirs' is what is in the repository. This should contain the file that we committed from MyProject. The file on the right labelled 'Mine' is what we're trying to commit. The area below labeled 'Merged' is what will be committed once we've made our changes. There are various options such as appending the files together, taking just one file or manually edit changes. We will manually edit the file in the 'Merged' window and take this to be our new version. 

# In the 'Merged' section, edit it so that it looks like the code below

1
2
3
4
5
6



# Now we can save our changes. 
# We have successfully resolved the conflict and both folders should have green ticks.

# While this example was rather trivial, you should now have a grasp on what version control is and how you can use SVN to help manage your projects.

