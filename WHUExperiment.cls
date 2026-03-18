% !Mode:: "TeX:UTF-8"
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\RequirePackage{expl3 , xparse , l3keys2e}
\ProvidesClass{WHUExperiment}[2022/07/22 Wuhan University Thesis Template for Experimental Report]


\ExplSyntaxOn
\msg_new:nnn { WHUExperiment } { 引擎不支持 }
  {
    WHUExperiment ~ 不支持 ~ #1 ~ 引擎。\\\\

    请使用 ~ XeLaTeX ~ 或 ~ LuaLaTeX ~ 进行编译！
  }

\sys_if_engine_xetex:F
  {
    \sys_if_engine_luatex:F
      {
        \msg_fatal:nnx { WHUExperiment } { 引擎不支持 }
          { \c_sys_engine_str }
      }
  }

\ExplSyntaxOff

\LoadClass[zihao=-4,a4paper,oneside]{ctexbook}
%\setmainfont{Times New Roman}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions
\newif\ifprint\printfalse
\DeclareOption{forprint}{\printtrue}
\ProcessOptions

\usepackage[dvipsnames, svgnames, x11names]{xcolor}

%------------------------ Page layout ----------------------------------
\RequirePackage{fancyhdr,hyperref}
\RequirePackage{float}
\RequirePackage{subcaption}

\hypersetup{pdfencoding=auto}  %%% 邓东升修改
 \ifprint
 \hypersetup{hidelinks}
 \else
\hypersetup{citecolor=magenta,linkcolor=blue}
\fi
\RequirePackage[top=30mm,bottom=25mm,left=30mm,right=20mm,includefoot,xetex]{geometry}    % 页面设置%
\RequirePackage{zhnumber}

\setlength{\parskip}{0pt} % 全局取消段前段后间距
\setlength{\parsep}{0pt}


\newtoks\StudentNumber       %学号
\newtoks\miji            %密级
\newtoks\Cmajor          %学科专业中文名
\newtoks\Emajor          %学科专业英文名
\newtoks\Edate           %英文日期
\newtoks\Etitle          %英文题目
\newtoks\Eauthor         %作者英文名
\newtoks\Esupervisor     %指导教师英文名
\newtoks\Csupervisor     %指导教师中文名
\newtoks\Eschoolname      %学院英文名
\newtoks\Cschoolname      %学院中文名
\newtoks\Ccoursename          %课程名称
\newtoks\CsupervisorAnother        %指导教师二
\newtoks\CstudentNum			%学生学号




\pagestyle{fancyplain}
\fancyhf{}  %清除以前对页眉页脚的设置
\renewcommand{\headrulewidth}{0.5pt}
\fancyhead[C]{\zihao{5}\songti 北方民族大学本科毕业论文（设计）}
\fancyfoot[C]{\zihao{5}\songti \thepage}


\fancypagestyle{plain}
{
\fancyhf{}
\fancyhead[C]{\zihao{5}\songti 北方民族大学本科毕业论文（设计）}
\renewcommand{\headrulewidth}{0.5pt}
\fancyfoot[C]{\zihao{5}\songti \thepage}
}

%%=====封面===================== 
\def\maketitle{%
  \null
  \thispagestyle{empty}%
  \begin{center}\leavevmode
    {\heiti \zihao{5}%
    \begin{tabular}{p{9cm}lp{3cm}l}
    \end{tabular}
    }
    \par
    \begin{figure}
      \centering
      \includegraphics[width=35mm]{figures/cover/xiaobiao.png}
    \end{figure}
    {\songti \zihao{1} \makebox[13cm][s]{北方民族大学}}\\
	\vspace{0.8cm}
	{\songti \zihao{1} \makebox[10cm][s]{本科毕业论文（设计）}}\\
    \vspace{1.0cm}
    {\heiti \zihao{2} 题目：\underline{\@title} \par}%
%    \vspace{4.2cm}
    {\songti\zihao{-3}
    \begin{tabular}{l l}
      \makebox[3.5cm][s]{学\hfill 院\hfill 名\hfill 称\hfill:\hfill} & \underline{\makebox[8cm][c]{\the\Ccoursename}} \\[1.5ex]
      \makebox[3.5cm][s]{专\hfill 业\hfill :\hfill} & \underline{\makebox[8cm][c]{\the\Cmajor}} \\[1.5ex]
	  \makebox[3.5cm][s]{学\hfill 生\hfill 姓\hfill 名\hfill:\hfill} & \underline{\makebox[8cm][c]{\@author}} \\[1.5ex]
	  \makebox[3.5cm][s]{学\hfill 号\hfill :\hfill} & \underline{\makebox[8cm][c]{\the\CstudentNum}} \\[1.5ex]
	  \makebox[3.5cm][s]{指\hfill 导\hfill 教\hfill 师\hfill 姓\hfill 名\hfill:\hfill} & \underline{\makebox[8cm][c]{\the\Csupervisor}} \\[1.5ex]
      \makebox[3.5cm][s]{企\hfill 业\hfill 指\hfill 导\hfill 教\hfill 师\hfill:\hfill} & \underline{\makebox[8cm][c]{\the\CsupervisorAnother}} \\[1.5ex]
      \makebox[3.5cm][s]{论\hfill 文\hfill 提\hfill 交\hfill 时\hfill 间\hfill:\hfill} & \underline{\makebox[8cm][c]{\@date}} \\[1.5ex]
     \end{tabular}
    }
    \par
    \vfill
    {\heiti\zihao{4} 北方民族大学教务处制 \par}
  \end{center}%
%  \null
%   \cleardoublepage
  }

%------------------------ Abstract & Keywords -------------------------
\newcommand\usefonttimes{\fontencoding{T1}\fontfamily{ptm}\selectfont}
\newcommand\cnabstractname{摘要}
\newcommand\teachername{教师评语评分}
\newcommand\enabstractname{ABSTRACT}
\newcommand\cnkeywords[1]{ {\noindent\heiti\zihao{3}\cnkeywordsname: }\songti\zihao{-4}#1}
\newcommand\cnkeywordsname{关键词}
\newcommand\enkeywords[1]{ {\usefonttimes{\noindent\bfseries\zihao{3}\enkeywordsname: }\zihao{-4}#1} }
\newcommand\enkeywordsname{Key words}
\newenvironment{cnabstract}{
    \newpage
    \begin{center}
        \vspace*{1\baselineskip} % 段前空一行
        {\heiti\zihao{2}\bfseries \@title \par}
        \vspace{1.5em}
        {\heiti\zihao{3}\bfseries \cnabstractname}
    \end{center}
    \addcontentsline{toc}{chapter}{\cnabstractname}
    \songti\zihao{-4}\linespread{1.5}\selectfont
    \@afterheading}
    {\par}

\newenvironment{enabstract}{
    \newpage
    \begin{center}
        \vspace*{1\baselineskip} % 段前空一行
        {\usefonttimes\zihao{2}\bfseries \the\Etitle \par}
        \vspace{1.5em}
        {\usefonttimes\zihao{3}\bfseries \enabstractname}
    \end{center}
    \addcontentsline{toc}{chapter}{\enabstractname}
    \usefonttimes\zihao{-4}\linespread{1.5}\selectfont
    \@afterheading}
    {\par}
	
\newenvironment{teacher}{
    \newpage
\chapter*{{\teachername}}   
    \songti\zihao{4}
    \@afterheading}
    {\par}
	
%%------------------------常用宏包-----------------------------------
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}
% \RequirePackage[tbtags]{amsmath}
\RequirePackage{extarrows}
\RequirePackage{ragged2e} % for \RaggedRight macro
\RequirePackage{booktabs}
\RequirePackage[normalem]{ulem}
\RequirePackage{physics}
\RequirePackage{supertabular}
\RequirePackage{multirow}
\RequirePackage[amsmath,thmmarks]{ntheorem}% AMSLaTeX宏包.
\RequirePackage[sort&compress]{gbt7714} % 引用 gbt7714 宏包
\citestyle{super} % 设置为上标模式
\RequirePackage{graphicx}                 % 图形
\RequirePackage { tikz, pgfplots } % 绘图
\pgfplotsset { compat = 1.17 }
\RequirePackage{color}             %支持彩色
\RequirePackage{listings}
%\RequirePackage{mathrsfs}   % 不同于\mathcal or \mathfrak 之类的英文花体字体
\RequirePackage{url}
\RequirePackage{enumerate}
\RequirePackage{CJKfntef}
\RequirePackage{natbib}

\RequirePackage{hhline, boldline}
\RequirePackage{seqsplit, caption} %for table spacing to second row
\RequirePackage{siunitx} %for table spacing to second row
\RequirePackage{threeparttable} %to add footnote below table

% 使用 tabularx 创建占满宽度的表格
\RequirePackage { tabularx }

\newcolumntype{L}{>{\RaggedRight\hangafter=1\hangindent=0em}X}
\newcolumntype{C}{>{\Centering\hangafter=1\hangindent=0em}X}
\newcolumntype{R}{>{\RaggedLeft\hangafter=1\hangindent=0em}X}

\ProvideDocumentCommand { \tabularxcolumn } { m }
  { m { #1 } }  % 使表格内容垂向居中

\RequirePackage
{
    longtable,
    xltabular, % 长表格
    booktabs,  % 三线表
    makecell,
    multirow,  % 跨行表格
    diagbox    % 斜线表头
}

\RequirePackage { algorithm2e }     % 算法代码
\ExplSyntaxOn
\tl_set:Nn \algorithmcfname { 算法 }
\SetAlCapSty {}
\SetAlCapFnt {}
\box_new:N \l__whu_space_box
\hbox_set:Nn \l__whu_space_box { \nobreakspace }
\SetAlgoCaptionSeparator
  { \hbox_to_wd:nn { 1 em - \box_wd:N \l__whu_space_box } {} }
% 算法标题后会跟一个不间断空格 ~，这里将其宽度减掉
\ExplSyntaxOff

%%-------------------------代码高亮-----------------------------------
\renewcommand{\lstlistlistingname}{代码汇总} % 代码高亮caption的名称
\renewcommand{\lstlistingname}{代码}

\lstset{
	basicstyle=\linespread{1.0}\ttfamily, % 设置字体族
	breaklines=true, % 自动换行
	keywordstyle=\bfseries\color{blue!70!black}, % 设置关键字为粗体，颜色为 NavyBlue
	morekeywords={}, % 设置更多的关键字，用逗号分隔
	emph={self}, % 指定强调词，如果有多个，用逗号隔开
  emphstyle=\bfseries\color{Rhodamine}, % 强调词样式设置
  commentstyle=\itshape\color{PineGreen!90!black}, % 设置注释样式，斜体，浅灰色
  stringstyle=\bfseries\color{red!90!black}, % 设置字符串样式
  backgroundcolor = \color{yellow!10},
  columns=flexible,
  numbers=left, % 显示行号在左边
  numbersep=2em, % 设置行号的具体位置
  numberstyle=\footnotesize, % 缩小行号
  % frame=single, % 边框
  % framesep=1em % 设置代码与边框的距离
}

%%----------------------- Theorems -----------------------------------
\theoremstyle{plain}
\theoremheaderfont{\heiti}
\theorembodyfont{\songti} \theoremindent0em
\theorempreskip{0pt}
\theorempostskip{0pt}
\theoremnumbering{arabic}
%\theoremsymbol{} %定理结束时自动添加的标志
\newtheorem{theorem}{\hspace{2em}定理}[section]
\newtheorem{definition}{\hspace{2em}定义}[section]
\newtheorem{lemma}{\hspace{2em}引理}[section]
\newtheorem{corollary}{\hspace{2em}推论}[section]
\newtheorem{proposition}{\hspace{2em}性质}[section]
\newtheorem{example}{\hspace{2em}例}[section]
\newtheorem{remark}{\hspace{2em}注}[section]

\theoremstyle{nonumberplain}
\theoremheaderfont{\heiti}
\theorembodyfont{\normalfont \rm \songti}
\theoremindent0em \theoremseparator{\hspace{1em}}
\theoremsymbol{$\square$}
\newtheorem{proof}{\hspace{2em}证明}


\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}  %自定义新命令\upcite, 使参考文献引用以上标出现

%%%%%%%-------------------------------------------------
%%%===  suppress extra inter-line spacing in \list environments
\makeatletter \setlength\partopsep{0pt}
\def\@listI{\leftmargin\leftmargini
            \parsep 0pt
            \topsep \parsep
            \itemsep \parsep}
\@listI
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listiv{\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listv{\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listvi{\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
%
% Change default margins for \list environments
\setlength\leftmargini   {2\ccwd} \setlength\leftmarginii
{\leftmargini} \setlength\leftmarginiii {\leftmargini}
\setlength\leftmarginiv  {\leftmargini} \setlength\leftmarginv
{\ccwd} \setlength\leftmarginvi  {\ccwd} \setlength\leftmargin
{\leftmargini} \setlength\labelsep      {.5\ccwd}
\setlength\labelwidth    {\leftmargini}
%
\setlength\listparindent{2\ccwd}
% Change \listparindent to 2\ccwd in \list
\def\list#1#2{\ifnum \@listdepth >5\relax \@toodeep
     \else \global\advance\@listdepth\@ne \fi
  \rightmargin \z@ \listparindent2\ccwd \itemindent \z@
  \csname @list\romannumeral\the\@listdepth\endcsname
  \def\@itemlabel{#1}\let\makelabel\@mklab \@nmbrlistfalse #2\relax
  \@trivlist
  \parskip\parsep \parindent\listparindent
  \advance\linewidth -\rightmargin \advance\linewidth -\leftmargin
  \advance\@totalleftmargin \leftmargin
  \parshape \@ne \@totalleftmargin \linewidth
  \ignorespaces}

\makeatother
%---------------------------------------------------
\newcommand\acknowledgement{\chapter*{致\hspace{2em}谢}\addcontentsline{toc}{chapter}{致谢}}

%%% ---- 章节标题设置 ----- %%%%
\ctexset{chapter={
    format={\linespread{1.5}\heiti\zihao{3}\bfseries\centering},
    name={第,章},
    number=\chinese{chapter},
    afterskip={18pt},
    beforeskip={1\baselineskip}
}}
\ctexset{section={
    format={\linespread{1.5}\heiti\zihao{4}\bfseries\raggedright},
    afterskip={0pt},
    beforeskip={0pt}
}}
\ctexset{subsection={
    format={\linespread{1.5}\heiti\zihao{-4}\bfseries\raggedright},
    afterskip={0pt},
    beforeskip={0pt}
}}
\ctexset{subsubsection={
    format={\linespread{1.5}\heiti\zihao{-4}\raggedright},
    afterskip={0pt},
    beforeskip={0pt}
}}

\setcounter{tocdepth}{4}
\setcounter{secnumdepth}{4}

%%% ---- 图表标题设置 ----- %%%%
\RequirePackage[labelsep=quad]{caption} %% 序号之后空一格写标题
\DeclareCaptionFont{wuhao}{\zihao{5}} % 声明五号字体
\captionsetup{font={bf,wuhao},labelfont={bf,wuhao}} % 全局设为五号黑体
\captionsetup[table]{position=top}
\captionsetup[figure]{position=bottom}

\renewcommand\figurename{图}
\renewcommand\tablename{表}

\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\thechapter.\arabic{table}}

%%% ------ 目录设置 ------- %%%%
\ctexset{contentsname={目\hspace{2em}录}}
 
\RequirePackage{tocloft} 
\renewcommand{\cfttoctitlefont}{\hfill\heiti\zihao{3}\bfseries}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftchapfont}{\songti\zihao{4}\bfseries}
\renewcommand{\cftchappagefont}{\songti\zihao{4}\bfseries}
\renewcommand{\cftsecfont}{\songti\zihao{-4}}
\renewcommand{\cftsecpagefont}{\songti\zihao{-4}}
\renewcommand{\cftsubsecfont}{\songti\zihao{-4}}
\renewcommand{\cftsubsecpagefont}{\songti\zihao{-4}}

\setlength{\cftbeforechapskip}{0.5em}
\setlength{\cftbeforesecskip}{0pt}
 
%%% ------ 脚注设置 ------- %%%%
% \RequirePackage{ctex}  %
\RequirePackage{pifont}
\RequirePackage[perpage,symbol*]{footmisc}
\DefineFNsymbols{circled}{{\ding{192}}{\ding{193}}{\ding{194}}
{\ding{195}}{\ding{196}}{\ding{197}}{\ding{198}}{\ding{199}}{\ding{200}}{\ding{201}}}
\setfnsymbol{circled}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\graphicspath{{figures/}}        % 图片文件路径
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\allowdisplaybreaks

\endlinechar `\^^M
\endinput
