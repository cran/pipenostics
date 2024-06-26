% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/b31gpf.R
\name{b31gpf}
\alias{b31gpf}
\title{ASME B31G. Failure pressure of the corroded pipe (original)}
\usage{
b31gpf(d, wth, smys, depth, l)
}
\arguments{
\item{d}{nominal outside diameter of pipe, [\emph{inch}]. Type: \code{\link{assert_double}}.}

\item{wth}{nominal wall thickness of pipe, [\emph{inch}]. Type: \code{\link{assert_double}}.}

\item{smys}{specified minimum yield of stress (\emph{SMYS}) as a
characteristics of steel strength, [\emph{PSI}]. Type: \code{\link{assert_double}}.}

\item{depth}{measured maximum depth of the corroded area, [\emph{inch}]. Type: \code{\link{assert_double}}.}

\item{l}{measured maximum longitudinal length of corroded area, [\emph{inch}]. Type: \code{\link{assert_double}}.}
}
\value{
Estimated failure pressure of the corroded pipe, [\emph{PSI}].
 Type: \code{\link{assert_double}}.
}
\description{
Calculate failure pressure of the corroded pipe
 according to \emph{Original B31G},
 \emph{Level-1} algorithm listed
 in \href{https://www.asme.org/codes-standards/find-codes-standards/b31g-manual-determining-remaining-strength-corroded-pipelines}{ASME B31G-2012}.

 The next assumption of the corrosion shape is adopted by
 \href{https://www.asme.org/codes-standards/find-codes-standards/b31g-manual-determining-remaining-strength-corroded-pipelines}{ASME B31G-2012}:

 \figure{b31gpf.png}

 There (a) is a parabolic and (b) is a rectangular idealizations of a
 corroded area.
}
\details{
Since the definition of flow stress, \emph{Sflow}, in
  \href{https://www.asme.org/codes-standards/find-codes-standards/b31g-manual-determining-remaining-strength-corroded-pipelines}{ASME B31G-2012}
  is recommended with \emph{Level 1} as follows:

  \deqn{Sflow =  1.1SMYS}

  no other possibilities of its evaluation are incorporated.

  For this code we avoid possible semantic optimization to
  preserve readability and correlation with original text description
  in \href{https://www.asme.org/codes-standards/find-codes-standards/b31g-manual-determining-remaining-strength-corroded-pipelines}{ASME B31G-2012}.
  At the same time source code for estimated failure pressure preserves
  maximum affinity with its semantic description in \href{https://www.asme.org/codes-standards/find-codes-standards/b31g-manual-determining-remaining-strength-corroded-pipelines}{ASME B31G-2012}
  and slightly differs from that given by \emph{Timashev et al}. The latter
  deviates up to 0.7% on examples supplied with \emph{CRVL.BAS} -
  (\code{\link{b31gdata}}).

  Numeric \code{NA}s may appear in case prescribed conditions of
  use are offended.
}
\examples{
 library(pipenostics)

 ## Example: maximum percentage disparity of original B31G
 ## algorithm and modified B31G showed on CRVL.BAS data
 with(b31gdata, {
   original  <- b31gpf(d, wth, smys, depth, l)
   modified  <- b31gmodpf(d, wth, smys, depth, l)
   round(max(100*abs(1 - original/modified), na.rm = TRUE), 4)
 })
 ## Output:
 #[1] 32.6666

 ## Example: plot disparity of original B31G algorithm and
 ## modified B31G showed on CRVL data
 with(b31gdata[-(6:7),], {
   b31g  <- b31gpf(depth, wth, smys, depth, l)
   b31gmod  <- b31gmodpf(depth, wth, smys, depth, l)
   axe_range <- range(c(b31g, b31gmod))
   plot(b31g, b31g, type = 'b', pch = 16,
        xlab = 'Pressure, [PSI]',
        ylab = 'Pressure, [PSI]',
        main = 'Failure pressure method comparison',
        xlim = axe_range, ylim = axe_range)
   inc <- order(b31g)
   lines(b31g[inc], b31gmod[inc], type = 'b', col = 'red')
   legend('topleft',
          legend = c('B31G Original',
                     'B31G Modified'),
          col = c('black', 'red'),
          lty = 'solid')
 })


}
\references{
\enumerate{
 \item \href{https://store.accuristech.com:443/standards/asme-b31g-2012-r2017?product_id=1842873}{ASME B31G-2012}.
   Manual for determining the remaining strength of corroded pipelines:
   supplement to \emph{B31 Code} for pressure piping.
 \item  S. Timashev and A. Bushinskaya, \emph{Diagnostics and Reliability
   of Pipeline Systems}, Topics in Safety, Risk, Reliability and Quality 30,
   \strong{DOI 10.1007/978-3-319-25307-7}
 }
}
\seealso{
Other fail pressure functions: \code{\link{b31gmodpf}}, \code{\link{dnvpf}},
  \code{\link{shell92pf}}, \code{\link{pcorrcpf}}

Other ASME B31G functions: 
\code{\link{b31crvl}()},
\code{\link{b31gacd}()},
\code{\link{b31gacl}()},
\code{\link{b31gafr}()},
\code{\link{b31gdep}()},
\code{\link{b31gmodpf}()},
\code{\link{b31gops}()},
\code{\link{b31gsap}()}
}
\concept{ASME B31G functions}
