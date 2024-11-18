
README for External Editor
__________________________

-----------------
Legal Notices
-----------------
Copyright ©1998-2005 Intergraph Corporation
All Rights Reserved

Including software, file formats, and audio-visual displays;
may only be used pursuant to applicable software license 
agreement;  contains confidential and proprietary information 
of Intergraph and/or third parties which is protected by 
copyright and trade secret law and may not be provided or 
otherwise made available without proper authorization.

RESTRICTED RIGHTS LEGENDS

Use, duplication, or disclosure by the U.S. Government is subject
to restrictions as set forth in subparagraph (c) (1) (ii) of The 
Rights in Technical Data and Computer Software clause at DFARS 
252.227-7013 or subparagraphs (c) (1) and (2) of Commercial 
Computer Software--Restricted Rights at 48 CFR 52.227-19, as 
applicable.

Unpublished--rights reserved under the copyright laws of the
United States.

Intergraph and INtools are registered trademarks of Intergraph 
Corporation. Other brands and product names are trademarks of 
their respective owners.

Intergraph Corporation
Huntsville, Alabama   35894-0001
--------------------------
End of Legal Notices
--------------------------

----------------------
Table of Contents
----------------------
Version Information
Year 2000 Status
System Requirements
Version Compatibility
Installing and Running External Editor
Documentation
Training
Customer Support
Version and Service Pack List
New Features
New Fixes
Open Problems
------------------------------
End of Table of Contents
------------------------------

------------------------
Version Information
------------------------
Product:        External Editor
Version:        07.00.01.09
Date:           MAR-30-2005
Description:    External Editor is an application that allows you to 
                view and modify specification sheets without the 
                need to use SmartPlant Instrumentation or InfoMaker. 
                You have the option of importing files modified in the 
                External Editor back into SmartPlant Instrumentation. 
                The External Editor comes with its own setup utility 
                for installing all required files on your computer.
-------------------------------
End of Version Information
-------------------------------

----------------------
Year 2000 Status
----------------------
Certified as Year 2000 compliant.
------------------------------
End of Year 2000 Status
------------------------------

--------------------------
System Requirements
--------------------------
Hardware Requirements
---------------------
  * 233 MHz Pentium(R) machine (minimum)
  * 256 MB RAM (minimum)
  * 20 MB free disk space
  * One CD-ROM drive
    - or -
  * An accessible network CD-ROM drive

Operating System and Software Requirements
------------------------------------------
 One of the following Microsoft(R) Windows(R) operating systems:
  * Windows XP
  * Windows 2000
-----------------------------------
End of System Requirements
-----------------------------------

-------------------------
Version Compatibility
-------------------------
 External Editor is compatible with the following versions of the software:
  * SmartPlant Instrumentation Version 7.0, Service Pack 1 (for .isf and .psr 
    specification files)
  
  Note: This version of External Editor does not work with earlier versions 
  of SmartPlant Instrumentation.
----------------------------------
End of Version Compatibility
----------------------------------

------------------------------------------
Installing and Running External Editor 
------------------------------------------
To install External Editor:
 1. Navigate to the External Editor folder containing the 
    Setup.exe file.
 2. Double-click the Setup.exe file.
 3. Follow the instructions in the setup wizard.

For further information, please refer to Online Help file 
'ExtEditor_Help409.chm' or to the document 'External Editor 
User Guide.pdf' (Document number: DINS-07.00.0005B).
-------------------------------------------------
End of Installing and Running External Editor
-------------------------------------------------

------------------
Documentation
------------------
Use the Help menu to access the Help files and Printable 
Guides for this product. To suggest a change or to ask a 
question about the documentation, send an e-mail message 
to PPMdoc@intergraph.com.
---------------------------
End of Documentation
---------------------------

----------
Training
----------
To register for training on Intergraph Process, Power
& Marine products, call Training Registration at 
(800) 766-7701 in the U.S. Outside the U.S., call 
(256) 730-5400 or contact your local Intergraph office.

For current information on training, use a World Wide 
Web browser to connect to Intergraph Process, Power 
& Marine online at http://ppm.intergraph.com/training/.
------------------
End of Training
------------------

--------------------
Customer Support
--------------------
For the latest Support Services information for this 
product, including solutions to known software issues,
use a World Wide Web browser to connect to 
http://ppm.intergraph.com/support/. To open service 
requests outside the U.S., please contact your local 
Intergraph office.
---------------------------
End of Customer Support
---------------------------

-----------------------------
Version and Service Pack List
-----------------------------
This file includes details of fixes and new features for the 
following versions and service packs: 

07.00.01.09
07.00.00.52
06.00.03.03
06.00.02.12
06.00.01.05
------------------------------------
End of Version and Service Pack List
------------------------------------

----------------------------------------
New Features in Service Pack 07.00.01.09
----------------------------------------
  None
-----------------------------------------------
End of New Features in Service Pack 07.00.01.09
-----------------------------------------------

---------------------------------
Fixes in Service Pack 07.00.01.09
---------------------------------
  TR-39167
  If you open a specification in External Editor for which the 
  Mark Changes option was applied in SmartPlant Instrumentation, 
  the changed fields no longer appear highlighted in External 
  Editor.

  TR-51386
  The software no longer displays an error message when 
  selecting an editable field on the Tag List.

  TR-58954
  Adding a model to a manufacturer for which no models 
  were yet defined now works correctly. Previously, 
  the software sometimes failed to add the new model.
----------------------------------------
End of Fixes in Service Pack 07.00.01.09
----------------------------------------

-----------------------------------
New Features in Version 07.00.00.52
-----------------------------------
  None
------------------------------------------
End of New Features in Version 07.00.00.52
------------------------------------------

----------------------------
Fixes in Version 07.00.00.52
----------------------------
  TR-55767
  In External Editor, you can only edit those custom view fields 
  that are marked in Spec Data Dictionary of SmartPlant 
  Instrumentation as Editable in External Editor.

  TR-58917
  In an .ipd file exported from SmartPlant Instrumentation, 
  process data records are now sorted by tag number.
-----------------------------------
End of Fixes in Version 07.00.00.52
-----------------------------------

----------------------------------------
New Features in Service Pack 06.00.03.03
----------------------------------------
  None
-----------------------------------------------
End of New Features in Service Pack 06.00.03.03
-----------------------------------------------

---------------------------------
Fixes in Service Pack 06.00.03.03
---------------------------------
  None
----------------------------------------
End of Fixes in Service Pack 06.00.03.03
----------------------------------------

----------------------------------------
New Features in Service Pack 06.00.02.12
----------------------------------------
  None
-----------------------------------------------
End of New Features in Service Pack 06.00.02.12
-----------------------------------------------

---------------------------------
Fixes in Service Pack 06.00.02.12
---------------------------------
  TR-48531 
  If you protected the notes field of an instrument specification 
  before saving in .isf format, protection of such a field is now 
  correctly implemented in External Editor.
----------------------------------------
End of Fixes in Service Pack 06.00.02.12
----------------------------------------

-----------------------------------
New Features in Version 06.00.01.05
-----------------------------------
  CR-35055
  New functionality allows you to protect fields from editing
  in External Editor.
------------------------------------------
End of New Features in Version 06.00.01.05
------------------------------------------

-------------
Open Problems
-------------
  TR-48645
  Problem:
    If you try to open an .isf file that is not compatible with 
    External Editor, the application closes down.
  Workaround: 
    Not available

  TR-50353
  Problem:
    The 'Mark changes' option does not work on the Multi-tag List 
    and Notes pages.
  Workaround: 
    Not available
--------------------
End of Open Problems
--------------------