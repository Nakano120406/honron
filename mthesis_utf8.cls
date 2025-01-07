%
% mthesis.cls : Classfile for master thesis
%


%参考文献部分が複数ページにわたる場合，エラーが出ることがあります．その場合は
%mthesis_utf8.cls内193行目に記載されている\newpageをコメントアウトしてください．（市原追記2020/1/14）

%% 1999/12/23 Master thesis style file for Hiroshima City Univ.
%% 1999/12/24 Port to ASCII-pTeX
%% 1999/12/27 Enable to line feed in title line
%% 1999/12/27 Add draft mode
%% 2000/01/04 Add english abstract
%% 2000/01/07 Fix page style of abstract
%% 2000/02/06 Fix heading of thebibliography
%% 2000/02/06 Add 'kyoju' and 'Prof' to abstract

\typeout{広島市立大学 修士論文作成用スタイルファイル}
\typeout{Style file for master thesis of Hiroshima City Univ.}
\typeout{1999-2000 Sasaki}

\input jreport.cls

%%%
%%% Page style, size, etc
%%% 	297*210
\textwidth      =  159.0mm
%\textheight     =  227.0mm
\textheight     =  237.0mm
%\textheight     =  180.0mm
\topmargin      =    4.6mm
\oddsidemargin  =    4.6mm
\evensidemargin =    4.6mm
\headheight     =    1.0zh
\footskip       =     10mm
%\footheight     =     10mm
%\headsep        =      3mm
\headsep        =      2.0zh
\partopsep      =   -0.5em
\textfloatsep   =      2mm
\intextsep      =      2mm
\parindent      =      1zw
\parskip        =    0.5zw
%%%
%%% Floating Objects
%%%
\renewcommand{\textfraction}{0.0}
\renewcommand{\floatpagefraction}{1.0}
\renewcommand{\topfraction}{1.0}
\renewcommand{\bottomfraction}{0.0}
\renewcommand{\dblfloatpagefraction}{1.0}
\renewcommand{\dbltopfraction}{1.0}

\setcounter{topnumber}{6}
\setcounter{bottomnumber}{6}
\setcounter{totalnumber}{6}
\setcounter{dbltopnumber}{6}

%\abovecaptionskip -0.1zw

% Comment out the next one line, if you want to use
% other mode.  Otherwise 36x32 mode is used.
% 40 x 32
%\jintercharskip=0.6pt plus 0.6pt minus 0pt
% 38 x 32
%\jintercharskip=1.2pt plus 1.2pt minus 0pt


%%%
%%% Misc command/environment
%%%
\renewcommand{\baselinestretch}{1.0}
\newcommand{\comment}[1]{}
\def\acknowledgment{\par
	\newpage
	\thispagestyle{plain}
	\addtocontents{toc}{\protect\contentsline{chapter}%
	{\hbox to\@tempdima {\hfil}謝辞}{\thepage}{}}%
	{{\large \dg\bf 謝辞} \ignorespaces}\newline\indent}
\let\endacknowledgment\par
\newif\ifusehead
\def\usehead{\useheadtrue}
\newif\ifasciitex
\def\asciitex{\asciitextrue}
\def\draftmode{
\def\fps@figure{p}\def\fps@table{p}
}

%%%
%%% List environment
%%%
\let\myitemize\itemize
\def\itemize{\vspace*{-5pt} \myitemize\itemsep=-3pt}
\let\myenditemize\enditemize
\def\enditemize{\myenditemize\vspace*{-5pt}}

\let\myenumerate\enumerate
\def\enumerate{\vspace*{-5pt} \myenumerate\itemsep=-3pt}
\let\myendenumerate\endenumerate
\def\endenumerate{\myendenumerate\vspace*{-5pt}}


%%%
%%% Table of contexts
%%%
\def\contentsname{目次}
\def\tableofcontents{%
	\if@twocolumn
		\@restonecoltrue\onecolumn
	\else
		\@restonecolfalse
	\fi
	\newpage
	\pagestyle{plain}
	\pagenumbering{roman}
	\baselineskip=14pt
	\chapter*{
	\vspace*{-2.5cm}%
	\begin{center}\large\dg\bf\leavevmode\@title\end{center}
	\large\dg\bf\contentsname\vspace*{-1.5cm}
	\@mkboth{%
	\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
	\@starttoc{toc}%
	\if@restonecol\twocolumn\fi
	\baselineskip=20pt
	\newpage
	\pagenumbering{arabic}
}


%%%
%%% Title page
%%%
\def\title#1{\gdef\@title{#1}}
\def\etitle#1{\gdef\@etitle{#1}}
\def\supervisor#1{\gdef\@supervisor{#1}}
\def\esupervisor#1{\gdef\@esupervisor{#1}}
\def\admdate#1{\gdef\@admdate{#1}}
\def\regnum#1{\gdef\@regnum{#1}}
\def\author#1{\gdef\@author{#1}}
\def\eauthor#1{\gdef\@eauthor{#1}}
\def\submission#1{\gdef\@submission{#1}}

\def\maketitle{
\thispagestyle{empty}
\ifasciitex
\def\dg{}
\fi
\begin{center}
\vspace*{5mm}
{\Huge 修\hspace*{1zw}士\hspace*{1zw}論\hspace*{1zw}文}\\
\vspace*{20mm}
\begin{tabular}{lp{25zw}}
{\Large 題\hspace*{1zw}目\hspace*{1zw}} & {\Large \@title}
\end{tabular}\\
\vspace*{23mm}
{\large 指導教員 \underline{\makebox[16zw][l]{
	\hspace*{1zw}\@supervisor \hspace*{1zw}教授}}}\\
\vspace*{76mm}
{\large 広島市立大学大学院 情報科学研究科\\ 博士前期課程 情報工学専攻}\\
\vspace*{2mm}
{\large \@admdate 年度入学\hspace*{2.5zw}
	学籍番号\hspace*{0.5zw}\@regnum}\\
\vspace*{9mm}
{\large 氏名 \underline{\hspace*{1zw}\makebox[10zw][l]{\@author}}}\\
\vspace*{11mm}
{\large \@submission 提出}\\
\end{center}
\baselineskip=20pt
\ifusehead
\def\@oddhead{\hfil{\small\chaptername{\thechapter}\hspace*{1zw}\rightmark}}%
\def\@evenhead{\hfil{\small\chaptername{\thechapter}\hspace*{1zw}\rightmark}}%
\def\chaptermark##1{\markright{##1}}
\fi
}

\def\chaptername#1{第 \lower0.1ex\hbox{#1} 章}

%%%%%% Bibliography
%%%
\newcounter{bibcounter}

\def\name@bib{参考文献}
\def\thebibliography#1{%
	\let\chaptername\comment
        \chap@emptychapter{\name@bib}
        \list{[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}
                \leftmargin\labelwidth \advance\leftmargin\labelsep
                \usecounter{enumi}}
        \def\newblock{\hskip.11em plus.33em minus.07em}
        \sloppy \frenchspacing \clubpenalty4000 \widowpenalty4000
        \markright{\name@bib}
}
\def\endthebibliography{%
	\setcounter{bibcounter}{\value{enumi}}
	\endlist
%	\newpage
}

\let\chap@chap\chapter
\def\chap@emptychapter#1{\chap@chap*{#1\@mkboth{#1}{#1}}
        \addcontentsline{toc}{chapter}{\numberline{}#1}}

%%%
%%% Appendix
%%%
\let\myappendix\appendix
\def\appendix{
\def\chaptername##1{}
  \newpage
  \addtocontents{toc}{\protect\contentsline{chapter}%
     {\hbox to\@tempdima {\hfil }付録}{\ }}%
  \def\chaptername##1{付録 \lower0.1ex\hbox{##1}}
  \myappendix
}


%%%
%%% Abstract(Japanese/English)
%%%
\def\abstract{
\def\@oddhead{\hfil{\roman{page}}}
\def\@evenhead{\hfil{\roman{page}}}
\def\@oddfoot{}
\def\@evenfoot{}
%\ifusehead
%\def\@oddhead{}
%\def\@evenhead{}
%\def\chaptermark##1{\markright{##1}}
%\fi
\newpage
\setcounter{page}{1}
\baselineskip=20pt
\begin{center}
{\large \@title}\\
\end{center}
\begin{flushright}
{\large 指導教員\hspace*{1zw}\@supervisor\hspace*{0.5zw}教授%
	\hspace*{2zw}\@regnum
	\hspace*{1zw}\@author}\\
\end{flushright}
{\large {\bf 概要}}\\
}

\def\endabstract{
%\tableofcontents
\newpage
}

\def\eabstract{
\def\@oddhead{\hfil{\roman{page}}}
\def\@evenhead{\hfil{\roman{page}}}
\def\@oddfoot{}
\def\@evenfoot{}
%\ifusehead
%\def\@oddhead{}
%\def\@evenhead{}
%\def\chaptermark##1{\markright{##1}}
%\fi
\newpage
%\setcounter{page}{1}
%\baselineskip=20pt
\begin{center}
{\large \@etitle}\\
\end{center}
\begin{flushright}
{\large Supervisor\hspace*{1zw}Prof. \@esupervisor\hspace*{2zw}\@regnum
	\hspace*{1zw}\@eauthor}\\
\end{flushright}
\noindent
{\large {\bf Abstract}}\\
}

\def\endeabstract{
\tableofcontents
}
%%%
%%% Command
%%%
\sloppy


%% 新しく追加（付録）
%% 次のbeginとendで囲って使用
%% \begin{theappendix} 
%% \end{theappendix}
\def\theappendix{
  \let\chaptername\comment
  \chap@emptychapter{付録}
}
\def\endtheappendix{}

