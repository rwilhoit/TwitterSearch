{\rtf1\ansi\ansicpg1252\cocoartf1187\cocoasubrtf340
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 Implementation Steps:\
1) Add a Search History Button to the view.\
2) Create a TweetHistory.h NSObject, which stores the searched term and the number of results returned.\
3) When a term is searched, the term and the number of results returned is stored in a global NSMutable array, which is declared in Globals.h. This implementation ensured that I didn't lose any data when switching between views, which was the biggest issue with this project.\
4) I made it so that when the user presses the Search History button, the current view is hidden and a new UITableView is programmatically drawn and populated using the same view controller as the main view and the global array.\
\
Issues:\
1) There is a maximum of 100 results that can be returned.}