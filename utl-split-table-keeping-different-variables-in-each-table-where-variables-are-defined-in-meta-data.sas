%let pgm=utl-split-table-keeping-different-variables-in-each-table-where-variables-are-defined-in-meta-data;

%stop_submission;

Split table keeping different variables in each table where variables are defined in meta data

PROBLEM
  Create a RED table with variable Num1 Num2 and GREEN table with Num1-Num3

CONTENTS
     1 do_over looping
     2 generate code
     3 debugx mprint macro

PROCESS

  Build macro array for looping

  %put &=_colors1; /*-- _COLORS1=GREEN --*/
  %put &=_colors2; /*-- _COLORS1=RED   --*/
  %put &=_colorsn; /*-- _COLORSN=2     --*/

  Create a table for each color  keeping
  only the variables in the meta data

  Note sql dropsall other variables
 keeping the ones in the meta data

  Use mprint to get generated code

github
https://tinyurl.com/54uxec3s
https://github.com/rogerjdeangelis/utl-split-table-keeping-different-variables-in-each-table-where-variables-are-defined-in-meta-data

communities.sas.com
https://tinyurl.com/6jfv2w3c
https://communities.sas.com/t5/SAS-Programming/Split-a-table-based-on-condition-of-another-table-variable/m-p/820739#M323995


/**************************************************************************************************************************/
/* INPUT                                |        PROCESS                       |            OUTPUT                        */
/* =====                                |        =======                       |            ======                        */
/*                                      |                                      |                                          */
/* WORK.META                            | Create a RED table with              | WORK.GREEN       from meta data          */
/*                                      | variables Num1 Num2 and              |                  ==============          */
/* VARNAME    TABLE                     | GREEN table with Num1-Num3           | COLOR AREA CODE  NUM3 NUM4 NUM5          */
/*                                      |                                      |                                          */
/*  Num1      RED                       | 1 DO_OVER MACRO SOLUTION             | GREEN  NY  A2134  89   43   12           */
/*  Num2      RED                       | ========================             | GREEN  SR  G3897  73   26   18           */
/*  Num3      GREEN                     |                                      |                                          */
/*  Num4      GREEN                     | %array(                              |                                          */
/*  Num5      GREEN                     |   _colors                            | WORK.RED         from meta data          */
/*                                      |   ,values=%utl_concat(               |                  ==============          */
/*                                      |      b                               | COLOR AREA CODE  NUM1 NUM2               */
/* WORK.MASTER                          |     ,var=type                        |                                          */
/* AREA CODE  NUM1 NUM2 NUM3 NUM4 NUM5  |     ,unique=Y));                     |  RED   NY  A2134  34   45                */
/*                                      |                                      |  RED   SR  G3897  94   23                */
/*  NY  A2134  34   45   89   43   12   | %put &=_colors1; * _COLORS1=GREEN;   |                                          */
/*  SR  G3897  94   23   73   26   18   | %put &=_colors2; * _COLORS1=RED  ;   |                                          */
/*                                      | %put &=_colorsn; * _COLORSN=2    ;   |                                          */
/* data meta;                           |                                      |                                          */
/*   input varname$                     | proc datasets lib=work               |                                          */
/*   Type$;                             |   nolist nodetails;                  |                                          */
/* cards4;                              |  delete red green;                   |                                          */
/* Num1 RED                             | run;quit;                            |                                          */
/* Num2 RED                             |                                      |                                          */
/* Num3 GREEN                           |                                      |                                          */
/* Num4 GREEN                           | %do_over(_colors,phrase=%str(        |                                          */
/* Num5 GREEN                           |   data ?;                            |                                          */
/* ;;;;                                 |    length color $8;                  |                                          */
/* run;quit;                            |    set master;                       |                                          */
/*                                      |    drop %nrstr(%dosubl(%nrbquote(    |                                          */
/* data master;                         |     proc sql;                        |                                          */
/*   input  Area$  Code$                |       select                         |                                          */
/*    num1-num5;                        |          varname                     |                                          */
/* cards;                               |       into                           |                                          */
/* NY A2134 34  45  89 43 12            |          :_vars separated by ' '     |                                          */
/* SR G3897 94  23  73 26 18            |       from                           |                                          */
/* ;;;;                                 |          meta                        |                                          */
/* run;quit;                            |       where                          |                                          */
/*                                      |          type ne '?'                 |                                          */
/*                                      |       ;quit;)) &_vars);              |                                          */
/*                                      |    color="?";                        |                                          */
/*                                      |   run;quit;))                        |                                          */
/*                                      |                                      |                                          */
/*                                      | %debugx;                             |                                          */
/*                                      |                                      |                                          */
/*                                      | proc print data=red;                 |                                          */
/*                                      | run;quit;                            |                                          */
/*                                      |                                      |                                          */
/*                                      | proc print data=green;               |                                          */
/*                                      | run;quit;                            |                                          */
/*                                      |                                      |                                          */
/*                                      |                                      |                                          */
/*                                      |                                      |                                          */
/*                                      |                                      |                                          */
/*                                      |------------------------------------- -------------------------------------------*/
/*                                      |                                      |                                          */
/*                                      | 2 SAS GENERATE CODE                  |                                          */
/*                                      | ====================                 |                                          */
/*                                      |                                      |                                          */
/*                                      | If you save the do_over              |                                          */
/*                                      | in the clipboard and run             |                                          */
/*                                      |                                      |                                          */
/*                                      | %debugx;                             |                                          */
/*                                      |                                      |                                          */
/*                                      | The generated code will be           |                                          */
/*                                      | log. In this case                    |                                          */
/*                                      |                                      |                                          */
/*                                      | This is the code in the log          |                                          */
/*                                      |                                      |                                          */
/*                                      | GENERATED CODE                       |                                          */
/*                                      |                                      |                                          */
/*                                      | data GREEN;                          |                                          */
/*                                      | length color $8;                     |                                          */
/*                                      | set master;                          |                                          */
/*                                      | drop                                 |                                          */
/*                                      | Num1 Num2;                           |                                          */
/*                                      | color="GREEN";                       |                                          */
/*                                      | run;                                 |                                          */
/*                                      | quit;                                |                                          */
/*                                      |                                      |                                          */
/*                                      | data RED;                            |                                          */
/*                                      | length color $8;                     |                                          */
/*                                      | set master;                          |                                          */
/*                                      | drop                                 |                                          */
/*                                      | Num3 Num4 Num5;                      |                                          */
/*                                      | color="RED";                         |                                          */
/*                                      | run;                                 |                                          */
/*                                      | quit;                                |                                          */
/*                                      |                                      |                                          */
/*                                      |                                      |                                          */
/*                                      | 3 DEBUGX MPRINT MACRO                |                                          */
/*                                      | =====================                |                                          */
/*                                      |                                      |                                          */
/**************************************************************************************************************************/


/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

data meta;
  input varname$
  Type$;
cards4;
Num1 RED
Num2 RED
Num3 GREEN
Num4 GREEN
Num5 GREEN
;;;;
run;quit;

data master;
  input  Area$  Code$
   num1-num5;
cards;
NY A2134 34  45  89 43 12
SR G3897 94  23  73 26 18
;;;;
run;quit;

/**************************************************************************************************************************/
/* INPUT                                                                                                                  */
/* =====                                                                                                                  */
/*                                                                                                                        */
/* WORK.META                                                                                                              */
/*                                                                                                                        */
/* VARNAME    TABLE                                                                                                       */
/*                                                                                                                        */
/*  Num1      RED                                                                                                         */
/*  Num2      RED                                                                                                         */
/*  Num3      GREEN                                                                                                       */
/*  Num4      GREEN                                                                                                       */
/*  Num5      GREEN                                                                                                       */
/*                                                                                                                        */
/*                                                                                                                        */
/* WORK.MASTER                                                                                                            */
/* AREA CODE  NUM1 NUM2 NUM3 NUM4 NUM5                                                                                    */
/*                                                                                                                        */
/*  NY  A2134  34   45   89   43   12                                                                                     */
/*  SR  G3897  94   23   73   26   18                                                                                     */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*       _                               _                   _
/ |   __| | ___    _____   _____ _ __  | | ___   ___  _ __ (_)_ __   __ _
| |  / _` |/ _ \  / _ \ \ / / _ \ `__| | |/ _ \ / _ \| `_ \| | `_ \ / _` |
| | | (_| | (_) || (_) \ V /  __/ |    | | (_) | (_) | |_) | | | | | (_| |
|_|  \__,_|\___/__\___/ \_/ \___|_|    |_|\___/ \___/| .__/|_|_| |_|\__, |
              |____|                                 |_|            |___/
*/

 *BUILD MACRO ARRAY ;

 %array(
   _colors
   ,values=%utl_concat(
      b
     ,var=type
     ,unique=Y));

 %put &=_colors1; * _COLORS1=GREEN
 %put &=_colors2; * _COLORS1=RED
 %put &=_colorsn; * _COLORSN=2

 proc datasets lib=work
   nolist nodetails;
  delete red green;
 run;quit;


 %do_over(_colors,phrase=%str(
   data ?;
    length color $8;
    set master;
    drop %nrstr(%dosubl(%nrbquote(
     proc sql;
       select
          varname
       into
          :_vars separated by ' '
       from
          meta
       where
          type ne '?'
       ;quit;)) &_vars);
    color="?";
   run;quit;))

 %debugx;

 proc print data=red;
 run;quit;

 proc print data=green;
 run;quit;

 /**************************************************************************************************************************/
 /* WORK.GREEN                                                                                                             */
 /*                                                                                                                        */
 /* COLOR AREA CODE  NUM3 NUM4 NUM5                                                                                        */
 /*                                                                                                                        */
 /* GREEN  NY  A2134  89   43   12                                                                                         */
 /* GREEN  SR  G3897  73   26   18                                                                                         */
 /*                                                                                                                        */
 /*                                                                                                                        */
 /* WORK.RED                                                                                                               */
 /*                                                                                                                        */
 /* COLOR AREA CODE  NUM1 NUM2                                                                                             */
 /*                                                                                                                        */
 /*  RED   NY  A2134  34   45                                                                                              */
 /*  RED   SR  G3897  94   23                                                                                              */
 /**************************************************************************************************************************/


/*___                                    _                       _
|___ \    __ _  ___ _ __   ___ _ __ __ _| |_ ___    ___ ___   __| | ___
  __) |  / _` |/ _ \ `_ \ / _ \ `__/ _` | __/ _ \  / __/ _ \ / _` |/ _ \
 / __/  | (_| |  __/ | | |  __/ | | (_| | ||  __/ | (_| (_) | (_| |  __/
|_____|  \__, |\___|_| |_|\___|_|  \__,_|\__\___|  \___\___/ \__,_|\___|
         |___/
*/

If you save the do_over code
in the clipboard and run

%debugx;

The generated code will be
log. In this case

/**************************************************************************************************************************/
/* GENERATED CODE                                                                                                         */
/*                                                                                                                        */
/* data GREEN;                                                                                                            */
/* length color $8;                                                                                                       */
/* set master;                                                                                                            */
/* drop                                                                                                                   */
/* Num1 Num2;                                                                                                             */
/* color="GREEN";                                                                                                         */
/* run;                                                                                                                   */
/* quit;                                                                                                                  */
/*                                                                                                                        */
/* data RED;                                                                                                              */
/* length color $8;                                                                                                       */
/* set master;                                                                                                            */
/* drop                                                                                                                   */
/* Num3 Num4 Num5;                                                                                                        */
/* color="RED";                                                                                                           */
/* run;                                                                                                                   */
/* quit;                                                                                                                  */
/**************************************************************************************************************************/

/*____       _      _
|___ /    __| | ___| |__  _   _  __ ___  __  _ __ ___   __ _  ___ _ __ ___
  |_ \   / _` |/ _ \ `_ \| | | |/ _` \ \/ / | `_ ` _ \ / _` |/ __| `__/ _ \
 ___) | | (_| |  __/ |_) | |_| | (_| |>  <  | | | | | | (_| | (__| | | (_) |
|____/   \__,_|\___|_.__/ \__,_|\__, /_/\_\ |_| |_| |_|\__,_|\___|_|  \___/
                                |___/
*/

filename ft15f001 "c:/oto/debugx.as";
parmcards4;
%macro debugx;
   %let rc=%sysfunc(filename(myRef,%sysfunc(pathname(work))/mactxt.sas));
   %let sysrc=%sysfunc(fdelete(&myRef));
   %let rc=%sysfunc(filename(&myref));
   filename clp clipbrd ;
   data _null_;
     infile clp;
     file "%sysfunc(pathname(work))/macraw.sas";
     input;
     put _infile_;
   run;
   filename mprint  "%sysfunc(pathname(work))/mactxt.sas";
   options mfile mprint source2;
   %inc "%sysfunc(pathname(work))/macraw.sas";
   run;quit;
   options nomfile nomprint;
   filename mprint clear;
   %inc "%sysfunc(pathname(work))/mactxt.sas";
   run;quit;
   data _null_;
     infile "%sysfunc(pathname(work))/mactxt.sas";
     input;
     putlog _infile_;
   run;quit;
%mend debugx;
;;;;
run;quit;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
