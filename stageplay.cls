% vim: set ft=tex:
% stageplay.cls
% Based on the stage class.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{stageplay}[2023/06/10 Stage play formatting]

\newif\if@final

\DeclareOption{final}{\@finaltrue}
\DeclareOption{draft}{\@finalfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{stage}}
\ProcessOptions\relax
\LoadClass{stage}
\RequirePackage{xspace}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{microtype}

\pretolerance=150
\tolerance=300
\raggedright
\setlength{\parskip}{12pt}

\renewcommand*{\familydefault}{\ttdefault}

\def\character#1#2{%
	\expandafter\def\csname#1\endcsname{\MakeUppercase{#2}\xspace}
	\expandafter\def\csname#1speaks\endcsname{\dialog{#2}}
	\expandafter\def\csname#1name\endcsname{#2\xspace}
}

\renewcommand{\dialog}[2]{%
	\needspace{2\baselineskip}%
	{\begin{adjustwidth}{2.5in}{0in}\MakeUppercase{#1}\saveparskip=\parskip\parskip=0pt\end{adjustwidth}%
  \extramarks{}{}%
  {\begin{adjustwidth}{0in}{0in}\parskip=\saveparskip#2\end{adjustwidth}}%
  \extramarks{\MakeUppercase{#1} (\continuedname)}{}}
}

\renewcommand{\charsd}[1]{%
	\parskip=0pt%
	\stage{#1}\par\leavevmode\parskip=\saveparskip\ignorespaces
}

\renewcommand{\act}{%
	\renewcommand{\thepage}{\Roman{actcounter}-\arabic{page}}%
	\ifthenelse{\value{actcounter} > 1}{\newpage}{\vspace{\parskip}}
	\stepcounter{actcounter}
	\hspace*{2.5in}\textsc{\actname} \Roman{actcounter}%
	\setcounter{page}{1}%
	\par
}

\renewcommand{\scene}{%
	\extramarks{}{}%
	\stepcounter{scenecounter}
	\ifthenelse{\value{scenecounter} > 1}{\newpage}{\vspace{\parskip}}
	\hspace*{2.5in}\textsc{\scenename} \arabic{scenecounter}%
	\par
}

\newcommand*{\note}[1]{\if@final\ignorespaces\else{\color{Red}#1}\fi}
\newcommand*{\charnote}[1]{\if@final\ignorespaces\else{\color{Red}\charsd{#1}}\ignorespaces\fi}
\newcommand*{\stagenote}[1]{\if@final\ignorespaces\else{\color{Red}\stage{#1}}\ignorespaces\fi}
\newcommand*{\opennote}[1]{\if@final\ignorespaces\else{\color{Red}\open{#1}}\ignorespaces\fi}
