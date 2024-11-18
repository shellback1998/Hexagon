                    Programmer's File Editor 0.07.002
                    ---------------------------------

Welcome to Programmer's File Editor. This file is the place to start looking at
the program: if you've not seen PFE before there's a synopsis of its main
features; and if you've used earlier versions there's some essential
information on major changes.

Below you'll find

	1. ABSTRACT
		A brief list of PFE's main features
	2. USING AND DISTRIBUTING PFE
		The terms on which you can use it and pass it on
	3. CONTACTING THE AUTHOR
		How to pass on your criticisms, suggestions, bug reports
		and maybe even praise
	4. WHERE TO GET PFE
		Places to look for PFE on the Internet and elsewhere
	5. WHICH VERSION SHOULD YOU USE?
		How to pick the most appropriate version
	6. UPGRADING FROM PREVIOUS RELEASES
		Important information if you're currently using an older
		version of PFE
	7. OTHER FILES YOU SHOULD LOOK AT
		The other important text files in this release
	8. THE FILES YOU SHOULD GET
		What should be in your distribution set
	9. INSTALLING PFE
		How to install everything

---

Alan Phillips	( A.Phillips@lancaster.ac.uk )
		( http://www.lancs.ac.uk/people/cpaap/pfe )


-------------------------------------------------------------------------------


1. ABSTRACT
-----------

This is the 0.07.002 release of Programmer's File Editor, a large-capacity
multi-file programming oriented editor for Windows 95, Windows NT 3.51 and
4.0 on Intel platforms, and Windows 3.1x

PFE includes the following features:

- The size of file it can handle is limited only by the total amount of
  virtual memory available
- No arbitrary limit on the number of lines a file can contain
- It can edit multiple files, the number being limited only by the
  available system resources
- Allows multiple edit windows showing the same file
- Multi-level undo facility
- Can read and write files in UNIX format using LF as line terminator, with
  automatic format detection
- Line numbers can be shown in any edit window if required
- Text can be copied and moved by dragging and dropping
- Right-click mouse menus give access to commonly required functions
- DOS commands such as compilers can be run with the output captured
  in an edit window
- Commonly-used text can be inserted in a simple operation from template
  libraries
- Fully-remappable keyboard, including two-key operation similar to MicroEMACS
  and mapping of Alt keys to functions
- Keystrokes and menu commands can be recorded in replayable keyboard macros
  which can be collected into libraries
- Files can be printed either in total, by line range, or selected text only
- Files can be printed with two pages per sheet of paper in landscape mode
  or as booklets
- Automatic line indenting and removal of trailing spaces
- Automatic configuration of edit options depending on file type
- Automatic configuration of tab sizes depending on file type
- Automatic brace alignment when editing C source
- Text indent/undent operations
- Optional automatic text wrapping at configurable margin
- Supports Microsoft IntelliMouse (32-Bit Edition)

Additionally, the editor can be controlled by another application across a
DDE client-server link.


2. USING AND DISTRIBUTING PFE
-----------------------------

PFE may be used in any way, for any purpose, at no cost. In may be distributed
by any means, provided that the original files as supplied by the author remain
intact and no charge is made other than for reasonable distribution costs.

You do not need to register to use PFE, or buy a licence to use it

PFE may be placed on any archive or BBS system

PFE may not be distributed with any commercial product without a prior license
agreement with the author



3. CONTACTING THE AUTHOR
------------------------

I would very much appreciate hearing from you if you use PFE and find problems,
or if you can think of ways it could be improved - and even (or is that
'especially'?) if you just think it's great. Even if the facility you would
like to see appears to be of interest only to you, tell me about it - you'd be
surprised how many ideas in that class have a much wider appeal.

You can contact me by e-mail at

                    A.Phillips@lancaster.ac.uk

I will try to reply to all the mail I receive, but it may take a week or so if
I'm very busy.



4. WHERE TO GET PFE
-------------------

The current version of PFE is distributed in two ZIP files. The names they have
when they are sent out are these:

   pfe0702i.zip      The 32-bit edition for Windows 95, and Windows NT 3.51
                       and 4.0 on Intel platforms
   pfe0702.zip       The 16-bit edition for Windows 3.1x

There is no implementation of this version for Windows NT on PowerPC systems.
However, version 0.07.001 is available for this platform in a file that should
have the name pfe0701p.zip

The distribution files will end up on archives all over the Internet, so a
search for these file names will probably show them somewehere.

The definitive source for new releases, news and useful information is the PFE
Home Page on the World Wide Web; the URL is

                http://www.lancs.ac.uk/people/cpaap/pfe/

Feel free to create links to this page from your own web site if you desire.


5. WHICH VERSION SHOULD YOU USE?
-------------------------------

Although the various editions of PFE will run on platforms other than their
intended ones, not all facilities will be available in some combinations. For
the best result, you should use the versions recommended here:

	System				Edition To Use
	------				--------------
	Windows 95			32-Bit Edition
	Windows NT 4.0 Intel		32-Bit Edition
	Windows NT 3.51 Intel		32-Bit Edition
	Windows 3.1x			16-Bit Edition



6. UPGRADING FROM PREVIOUS RELEASES
-----------------------------------

If you've been using PFE version 0.07.001, then you won't need to take any
special steps to move to 0.07.002

However, if you've been using 0.06.002 or earlier, take a moment to read the
notes below, as there have been some significant changes that you need to
consider before you install the new version.


FOR 32-BIT EDITION USERS ONLY

If you've been using 0.06.002 or earlier of the 32-Bit Edition under Windows 95
or Windows NT, then you'll probably want to take some installation steps before
you start to run the new version of PFE.

PFE now uses the Windows Registry to store configuration information rather
than the PFE32.INI initialisation file; this allows it to support per-user
configuration data and offer some extra facilities.

The INI2REG utility allows you to convert existing initialisation files into
the Windows Registry and explains the new facilities. You should read the text
file UPGRADE.TXT that is part of the distribution set for complete details


FOR ALL USERS

PFE now sets up associations for the file types you want to use it with itself,
using the Options Preferences command. You should begin by using this command
to define your associations, as this will guarantee that they are correctly
defined, and also enable some context menu support for the 32-Bit Edition. Note
that your manually-defined associations will not be shown by PFE when you do
this.

If you're upgrading from version 0.05.007 or earlier, it's best to delete your
existing initialisation files (PFE.INI or PFE32.INI) and begin again with the
new release.



7. OTHER FILES YOU SHOULD LOOK AT
---------------------------------

The distribution set contains several other text files of important
information.

For the answers to some of the common questions that users have, see FAQ.TXT.
Looking in here can save you a lot of worry and experimentation, and save you
from posting your question to newsgroups and mailing lists.

The CHANGES.TXT file tells you what's changed from earlier releases. If you
find something unexpected going on, look in here too - it could be a feature
rather than a bug.

The PROBLEMS.TXT file tells you about any major problems that were discovered
too late to be addressed in this release, and what you can do if you hit them.



8. THE FILES YOU SHOULD GET
---------------------------

There are a small number of files in the PFE distribution. You should find the
following items:

32-bit Intel Edition:

	[For Windows 95, and Windows NT 3.51 and 4.0 on Intel platforms]

	pfe32.exe		The editor itself
	pfe.hlp			The help file
	pfedos32.exe		A helper module, needed to run commands and
				capture output
	readme.txt		This file
	upgrade.txt		Details on how to convert your initialisation
				files into the Windows Registry if you're
                                currently using version 0.06.002 or earlier
	ini2reg.exe		The program that converts your initialisation
				files into the Windows Registry
	changes.txt		Changes from previous releases
	faq.txt			Frequently Asked Questions
	problems.txt		Information on late-breaking problems

16-bit Edition:

	[For Windows 3.1x]

	pfe.exe			The editor itself
	pfe.hlp			The help file
	pfedos.exe		A helper module, needed to run commands and
				capture output
	pfedos.pif		The PIF file for this module
	readme.txt		This file
	changes.txt		Changes from previous releases
	faq.txt			Frequently Asked Questions
	problems.txt		Information on late-breaking problems

[The help file pfe.hlp is identical for the 16-bit and 32-bit editions]



9. INSTALLING PFE
-----------------

There is no setup program for PFE, as it doesn't really need one. Installation
is done by simply copying the supplied files:

32-bit Edition:

 Copy pfe32.exe, pfe.hlp, pfedos32.exe to a suitable directory. This need not
 be on your path; but it's important that all the files are in the same
 directory.

 Next, read upgrade.txt carefully, and if you wish, use the ini2reg utility to
 convert your existing initialisation file PFE32.INI into the Windows Registry

 If you like to have PFE handy on your desktop, make sure that you place a
 shortcut there, rather than a copy of the program file itself. If you make a
 copy, you'll find that you can't run DOS commands, since the pfe.exe executable
 will be in the desktop directory, and the pfedos32.exe helper module will be
 somewhere else.

16-bit Edition:

 Copy pfe.exe, pfe.hlp, pfedos.exe and pfedos.pif to a suitable directory.
 This need not be on your path; but it's important that all the files are
 in the same directory.


It's a good idea to keep the 16-bit and 32-bit editions in the same place; then
you will need only one copy of the help file.

After you've installed PFE, the best thing to do is start it up, then use the
Options Preferences command to explore the customisation options and set it up
to run as you prefer.


