Author: Mark Buck (Kaivalagi) <m_buck@hotmail.com>

PREREQUISITES
=============

It is expected that the user is already familiar with Conky.

Any conky specific help can be found by either visiting the conky website here:

    http://conky.sourceforge.net

Alternatively there is a large user base, various helpful posts are available
at http://www.ubuntuforums.org

For example, to see various incarnations of conky setups, or to ask technical
questions you could go here:
    
        Post your .conkyrc files w/ screenshots

        http://ubuntuforums.org/showthread.php?t=281865 

If you are not familiar with conky there is help available here:

    HOW TO: A Beginners Guide to Setting up Conky

    http://ubuntuforums.org/showthread.php?t=867076


EXAMPLE USE
===========

In the /usr/share/conkyrhythmbox/example folder you'll find 2 files, conkyrc and
conkyrhythmbox.template

Conky can be run using these example files as follows:

    conky -c /usr/share/conkyrhythmbox/example/conkyrc &
    
Make sure Rhythmbox is running first...


COMMAND OPTIONS
===============

A break down of all the options available are below. The same details can be
found by running conkyRhythmbox --help

Usage: conkyRhythmbox [options]
Options:
  -h, --help            show this help message and exit
  -t FILE, --template=FILE
                        define a template file to generate output in one call.
                        A displayable item in the file is in the form
                        [--datatype=TI]. The following are possible options
                        within each item: --datatype,--ratingchar. Note that
                        the short forms of the options are not currently
                        supported! None of these options are applicable at
                        command line when using templates.
  -d DATATYPE, --datatype=DATATYPE
                        [default: TI] The data type options are: ST (status),
                        TI (title), AL (album), AR (artist), GE (genre), GE
                        (genre), YR (year), TN (track number), FN (file name),
                        LE (length), PP (current position in percent), PT
                        (current position in time), VO (volume), RT (rating).
                        Not applicable at command line when using templates.
  -r CHAR, --ratingchar=CHAR
                        [default: *] The output character for the ratings
                        scale. Command line option overridden if used in
                        templates.
  -s TEXT, --statustext=TEXT
                        [default: Playing,Paused,Stopped] The text must be
                        comma delimited in the form 'A,B,C'. Command line
                        option overridden if used in templates.
  -n, --nounknownoutput
                        Turn off unknown output such as "Unknown" for title
                        and "0:00" for length. Command line option overridden
                        if used in templates.
  -m LENGTH, --maxlength=LENGTH
                        [default: 0] Define the maximum length of any
                        datatypes output, if truncated the output ends in
                        "..."
  -v, --verbose         Request verbose output, not a good idea when running
                        through conky!
  -V, --version         Displays the version of the script.
  --errorlogfile=FILE   If a filepath is set, the script appends errors to the
                        filepath.
  --infologfile=FILE    If a filepath is set, the script appends info to the
                        filepath.



TEMPLATE FILES
==============

A template file is included in the example files and there are also details on
the template option in the command options listed above.

Note that you can combine standard font output with other fonts in a single
template, but must use execp or execpi conky commands to do so.

Please take a look at the example template provided. You will see that anything
inside the square brackets are options, anything outside standard text that will
be output as conky would normally handle it.


FURTHER HELP
============

If you have an issue and are not sure, try running the same command in the
terminal window and add the option --verbose, you should then see lots of
information about what the script is doing, any warnings or errors should also
be displayed.

If after doing the above you are still stuck, further help can be found by 
visiting this thread on ubuntuforums.org:

	Conky Rhythmbox Python Script
	
	http://ubuntuforums.org/showthread.php?p=5843297

Note that it is best to post --verbose output of your script call, as well as
the conkyrc you are using. This way the issue can be understood quickly and
easily.

ENJOY :)


