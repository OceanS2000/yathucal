#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]]


classStartTime={{2018,2,26,8,0,0},{2018,2,26,9,50,0},{2018,2,26,13,30,0},{2018,2,26,15,20,0},{2018,2,26,17,5,0},{2018,2,26,19,20,0}};
(*\:6bcf\:8282\:8bfe\:5f00\:59cb\:7684\:65f6\:95f4\:ff0c\:65e5\:671f\:662f\:5b66\:671f\:7684\:7b2c\:4e00\:5929*)
classEndTime={{2018,2,26,9,35,0},{2018,2,26,12,15,0},{2018,2,26,15,5,0},{2018,2,26,16,55,0},{2018,2,26,18,40,0},{2018,2,26,21,45,0}};
(*\:6bcf\:8282\:8bfe\:7ed3\:675f\:7684\:65f6\:95f4*)
(*TODO:\:589e\:52a0\:4ee3\:7801\:4f7f\:5f97\:5b66\:671f\:4fee\:6539\:65f6\:53ef\:4ee5\:76f4\:63a5\:751f\:6210\:4e0a\:8ff0\:5217\:8868\:4e2d\:7684\:65e5\:671f*)
startTimeTable=Table[DatePlus[#,i]&/@classStartTime,{i,0,6}]//Flatten[#,1]&;

endTimeTable=Table[DatePlus[#,i]&/@classEndTime,{i,0,6}]//Flatten[#,1]&;

timeTable=MapThread[List,{startTimeTable,endTimeTable}];(*\:8ba1\:7b97\:6bcf\:8282\:8bfe\:7684\:5f00\:59cb/\:7ed3\:675f\:65f6\:95f4*)


\:8bfe\:8868URL=SystemDialogInput["FileOpen"];(*TODO:\:52a0\:5165\:81ea\:52a8\:767b\:9646info\:83b7\:53d6\:8bfe\:8868\:529f\:80fd*)
Flatten@Transpose@Cases[#,{_String,_,_,_,_,_,_,_},All](*\:5229\:7528\:8bfe\:8868\:7279\:5f81\:ff1a\:8fde\:7eed\:516b\:4e2a\:6587\:5b57\:5217\:8fdb\:884c\:5339\:914d*)[[2;;All,2;;All]](*\:53bb\:9664\:8868\:5934*)&@
    Import[\:8bfe\:8868URL,"FullData",CharacterEncoding->"MacintoshChineseSimplified"];
classTable=StringCases[name__~~" ("~~__~~"\:ff1b"~~__~~"\:ff1b"~~weeks__~~"\:5468\:ff1b"~~place__~~")"->Sequence[name,weeks,place]]/@%(*\:89e3\:6790\:8bfe\:8868\:4e2d\:7684\:4fe1\:606f\:ff0c\:63d0\:53d6\:8bfe\:7a0b\:540d\:ff0c\:4e0a\:8bfe\:5468\:6570\:ff0c\:4e0a\:8bfe\:5730\:70b9*)
(*\:5f85\:6d4b\:8bd5\:ff1a\:5f53\:540c\:4e00\:65f6\:95f4\:6709\:4e24\:4e2a\:5019\:9009\:8bfe\:7a0b\:65f6\:ff0c\:6a21\:5f0f\:53ef\:80fd\:65e0\:6cd5\:8fc7\:6ee4\:6389\:5019\:9009*)


classList=
    AssociationThread[{"Summary","ClassWeeks","Location","TimeStart","TimeEnd"},#]&/@
    (*\:589e\:52a0\:6807\:5934\:51c6\:5907\:5bfc\:51fa*)Cases[{_,_,__}]@MapThread[Join,{classTable,timeTable}];
(*\:5229\:7528\:7a7a\:8bfe\:7a0b\:4e2dList\:5143\:7d20\:53ea\:6709\:4e24\:4e2a\:53bb\:9664\:6ca1\:6709\:8bfe\:7a0b\:7684\:65e5\:671f*)
Export[FileNameJoin@{NotebookDirectory[],"class.json"},classList,"JSON"];
<<"!python3 yathucal.py"
SystemOpen["classtable.ics"]
