% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dropt.R
\name{dropt}
\alias{dropt}
\title{Temperature drop in pipe due heat losses}
\usage{
dropt(temperature = 130, pressure = mpa_kgf(6), consumption = 250, flux = 7000)
}
\arguments{
\item{temperature}{temperature of heat carrier (water) inside the pipe measured at the
inlet of pipe, [\emph{°C}]. Type: \code{\link{assert_double}}.}

\item{pressure}{\href{https://en.wikipedia.org/wiki/Pressure_measurement#Absolute}{absolute pressure}
of heat carrier (water) inside the pipe, [\emph{MPa}]. Type: \code{\link{assert_double}}.}

\item{consumption}{amount of heat carrier (water) that is transferred by pipe during a period,
[\emph{ton/hour}]. Type: \code{\link{assert_double}}.}

\item{flux}{heat flux emitted by pipe during a period, [\emph{kcal/hour}].
Type: \code{\link{assert_double}}.}
}
\value{
temperature drop at the outlet of pipe, [\emph{°C}]. Type: \code{\link{assert_double}}.
}
\description{
Calculate temperature drop in steel pipe of \emph{district heating system}
 (where water is a heat carrier) that is a result of heat losses through
 pipe wall and insulation.
}
\details{
Specific isobaric \href{https://en.wikipedia.org/wiki/Heat_capacity}{heat capacity}
  used in calculations is calculated according to
  \href{http://www.iapws.org/relguide/IF97-Rev.pdf}{IAPWS R7-97(2012)}
  for \strong{Region 1} since it is assumed that state of water in
  \emph{district heating system} is always in that region.
}
\examples{
 # Calculate normative temperature drop based on Minenergo-325 for pipe segment
 pipeline <- list(
   year = 1968,
   laying = "channel",
   d = 700,
   l = 1000
 )
 operation_temperature <- c(130, 150)  # [°C]

 foo <- dropt(
   temperature = operation_temperature,
   flux = do.call(
     m325nhl,
     c(pipeline, temperature = list(operation_temperature))
   )
 )

 foo
 # [1] 1.366806 1.433840

 # This is the same as using m325dropt:
 bar <- m325dropt(temperature = operation_temperature,
   year = 1968, laying = "channel", d = 700, len = 1000
 )

 bar
 # [1] 1.366806 1.433840

}
\seealso{
\code{\link{m325dropt}} for calculating normative values of temperature drop

Other district heating: 
\code{\link{dropg}()},
\code{\link{dropp}()}
}
\concept{district heating}
