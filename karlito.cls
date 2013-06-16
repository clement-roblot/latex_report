\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{karlito}



%definition des options
\RequirePackage{ifthen}
\RequirePackage{kvoptions}
\newboolean{load-remplissage}
\newboolean{load-impression}

\DeclareOption{remplissage}{\setboolean{load-remplissage}{true}}
\DeclareOption{impression}{\setboolean{load-impression}{true}}


\ProcessKeyvalOptions{karlito}\relax
\ProcessOptions\relax



\LoadClass[a4paper,12pt,onecolumn,twoside]{report}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%			Mise en page				%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\RequirePackage{fancyhdr}	%permet de faire des entêtes et pieds de page
\setlength{\headheight}{15pt}	%définit la taille du header et footer (15pt minimum)

\ifthenelse{\boolean{load-remplissage}}{	%mode remplissage

	\RequirePackage[parfill]{parskip}
	\RequirePackage[a4paper,left=3cm,right=3cm,top=4cm,bottom=4cm]{geometry}	%géometrie de la mise en page

}{			%mode normal

	\RequirePackage[a4paper,left=2cm,right=2cm,top=2cm,bottom=2cm]{geometry}	%géometrie de la mise en page
}

\ifthenelse{\boolean{load-impression}}{	%mode impression

	%\setlength{\oddsidemargin}{5mm}
	%\setlength{\evensidemargin}{-\oddsidemargin}
	\AtEndDocument{
		\ifthenelse{\isodd{\thepage}}{}{\clearpage~\clearpage}	
	}
}{}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		Pour les symboles des equations			%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{gensymb}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\RequirePackage{verbatim}
\RequirePackage{kpfonts}
\RequirePackage[explicit]{titlesec}
\RequirePackage{varwidth}



\newlength{\margeBordCadre}
\setlength{\margeBordCadre}{1cm}

\usetikzlibrary{calc, backgrounds}

\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}

\renewcommand{\maketitle}{

	\begin{titlepage}%
		\begin{tikzpicture}[remember picture,overlay]
			\node[yshift=-\paperheight+\margeBordCadre, xshift=\margeBordCadre] at (current page.north west){
				\begin{tikzpicture}[remember picture, overlay]
					\draw[line width=5pt] (0,0) rectangle(\paperwidth-2*\margeBordCadre,\paperheight-2*\margeBordCadre);
        				\draw node[align=center, yshift=0.5\paperheight-\margeBordCadre, xshift=0.5*\paperwidth-\margeBordCadre, anchor=center]{
						\begin{varwidth}{\linewidth}\begin{center}
							\huge \textbf{\@title}\\[2cm]
							\LARGE \@author
						\end{center}\end{varwidth}%
					};
				\end{tikzpicture}
			};
		\end{tikzpicture}
	\end{titlepage}%
  \setcounter{footnote}{0}%
}





\newcommand{\ps@otherpage}{%

	\pagestyle{fancy}

	\fancyhead{} % vide l’en-tête
	\fancyhead[RE, LO]{\@title}
	\fancyhead[LE]{\leftmark}
	\fancyhead[RO]{\rightmark}
	\fancyfoot{} % vide le pied~de~page
	\fancyfoot[LE, RO]{\thepage}
	%\fancyfoot[LO,CE]{de : H. Dupont}
	\fancyfoot[LO,RE]{\@author}
	\renewcommand{\headrulewidth}{1mm}
	\renewcommand{\footrulewidth}{1mm}
}% otherpage style

\pagestyle{otherpage}% doit être placé après les définitions précédentes



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		Définition du style de chapitre			%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{xcolor}

\hfuzz=100pt	%on génère un warning si on a une boxe trop pleinne de plus de 100pt

\makeatletter
\def\thickhrulefill{\leavevmode \leaders \hrule height 1ex \hfill \kern \z@}

\def\@makechapterhead#1{%
	\reset@font
	\parindent \z@
	\vspace*{10\p@}%
	\hbox{%
		\vbox{%
			\hsize=1.5cm%
			\begin{tabular}{c}
				\scshape \strut \@chapapp{} \\
				\colorbox{black}{\vbox{
					\hbox{\vbox to 1mm{}}
					\hbox{\color{white} \LARGE \bfseries \hspace{1mm}\thechapter\hspace{1mm}}
					\hbox{\vbox to 2cm{}}
				}}%
			\end{tabular}%
		}%
		\vbox{%
			\advance\hsize by -2cm
			\hrule height 0.4pt depth 0pt width \hsize
			\par
			\vskip 6pt%
			\hspace{20pt}%
			\parbox{400pt}{%
				\Huge \bfseries #1
			}%
		}%
	}%
	\vskip 20\p@
}

\def\@makeschapterhead#1{%
	\reset@font
	\parindent \z@
	\vspace*{10\p@}%
	\hbox{%
		\vbox{%
			\hsize=1.5cm%
			\begin{tabular}{c}
				\scshape \strut \phantom{\@chapapp{}} \\
				\colorbox{black}{\vbox{
					\hbox{\vbox to 1mm{}}
					\hbox{\color{white} \LARGE \bfseries \hspace{1mm}\phantom{\thechapter}\hspace{1mm}}
					\hbox{\vbox to 2cm{}}
				}}%
			\end{tabular}%
		}%
		\vbox{%
			\advance\hsize by -2cm
			\hrule height 0.4pt depth 0pt width \hsize
			\par
			\vskip 6pt%
			\hspace{20pt}%
			\parbox{400pt}{%
				\Huge \bfseries #1
			}%
		}%
	}%
	\vskip 100\p@
}
\makeatother

