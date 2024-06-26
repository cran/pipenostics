% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tracebw.R
\name{tracebw}
\alias{tracebw}
\title{Massively trace backwards thermal-hydraulic regime for district
 heating network}
\usage{
tracebw(
  sender = 6,
  acceptor = 7,
  temperature = 70,
  pressure = pipenostics::mpa_kgf(6),
  flow_rate = 20,
  d = 100,
  len = 72.446,
  loss = 78.4,
  roughness = 0.001,
  inlet = 0.5,
  outlet = 1,
  method = "romeo",
  opinion = "median",
  verbose = TRUE,
  csv = FALSE,
  file = "tracebw.csv"
)
}
\arguments{
\item{sender}{identifier of the node which heat carrier flows out.
Type: any type that can be painlessly coerced to character by
\code{\link{as.character}}.}

\item{acceptor}{identifier of the node which heat carrier flows in. According to topology
of test bench considered this identifier should be unique for every row.
Type: any type that can be painlessly coerced to character by
\code{\link{as.character}}.}

\item{temperature}{Sensor-measured temperature of heat carrier (water) sensor-measured on 
the terminal acceptor node, [\emph{°C}].
 Use \code{NA_float_}s for (terminal) nodes without temperature sensor.
 Type: \code{\link{assert_double}}.}

\item{pressure}{Sensor-measured
\href{https://en.wikipedia.org/wiki/Pressure_measurement#Absolute}{absolute pressure}
of heat carrier (water) inside the pipe (i.e. acceptor's incoming edge),
[\emph{MPa}].
Type: \code{\link{assert_double}}.}

\item{flow_rate}{Sensor-measured amount of heat carrier (water) on terminal node that is
transferred by pipe (i.e. acceptor's incoming edge) during a period, [\emph{ton/hour}]. 
Type: \code{\link{assert_double}}.
Use \code{NA_float_}s for nodes without flow rate sensor.}

\item{d}{internal diameter of pipe (i.e.diameter of acceptor's incoming edge),
[\emph{mm}].
Type: \code{\link{assert_double}}.}

\item{len}{pipe length (i.e. length of acceptor's incoming edge), [\emph{m}].
Type: \code{\link{assert_double}}.}

\item{loss}{user-provided value of \emph{specific heat loss} power for each pipe, 
[\emph{kcal/m/h}]. Values of the argument can be obtained experimentally,
or taken from regulatory documents. 
Type: \code{\link{assert_double}}.}

\item{roughness}{roughness of internal wall of pipe (i.e. acceptor's incoming edge), [\emph{m}].
Type: \code{\link{assert_double}}.}

\item{inlet}{elevation of pipe inlet, [\emph{m}]. Type: \code{\link{assert_double}}.}

\item{outlet}{elevation of pipe outlet, [\emph{m}]. Type: \code{\link{assert_double}}.}

\item{method}{method of determining \emph{Darcy friction factor}:
\itemize{
  \item \code{romeo}
  \item \code{vatankhan}
  \item \code{buzelli}
}
Type: \code{\link{assert_choice}}.
For more details see \code{\link{dropp}}.}

\item{opinion}{method for aggregating values of regime parameters on each node for the
next tracing step:
\describe{
   \item{\code{mean}}{values of parameter are averaged before the next
   tracing step}
   \item{\code{median}}{median of parameter values are used for the next
   tracing step}
 }
Type: \code{\link{assert_choice}}.}

\item{verbose}{logical indicator: should they watch tracing process on console?
Type: \code{\link{assert_flag}}.}

\item{csv}{logical indicator: should they incrementally dump results to \emph{csv}-
file while tracing?
Type: \code{\link{assert_flag}}.}

\item{file}{name of \emph{csv}-file which they dump results to.
Type: \code{\link{assert_character}} of length 1 that can be used safely
to create a file and write to it.}
}
\value{
\code{\link{data.frame}} containing results (detailed log) of tracing in
   \href{https://en.wikipedia.org/wiki/Wide_and_narrow_data}{narrow format}:
   \describe{
      \item{\code{node}}{
        \emph{Tracing job}. Identifier of the node which regime parameters is
        calculated for. Values in this vector are identical to those in
        argument \code{acceptor}. 
        Type: \code{\link{assert_character}}.
      }

      \item{\code{tracing}}{
        \emph{Tracing job}. Identifiers of nodes from which regime parameters
        are traced for the given node. Identifier \code{sensor} is used when
        values of regime parameters for the node are sensor readings.
        Type: \code{\link{assert_character}}.
      }

      \item{\code{backward}}{
         \emph{Tracing job}. Identifier of tracing direction. It constantly
         equals to \code{TRUE}. 
         Type: \code{\link{assert_logical}}.
       }

      \item{\code{aggregation}}{
         \emph{Tracing job}. Identifier of aggregation method: \emph{span}, \emph{median}, \emph{mean}, or \emph{identity}. Type: \code{\link{assert_character}}.
       }
      \item{\code{loss}}{
         \emph{Traced thermal hydraulic regime}. Normative specific heat loss power of adjacent pipe, [\emph{kcal/m/h}]. Type: \code{\link{assert_double}}.
       }
      \item{\code{flux}}{
         \emph{Traced thermal hydraulic regime}. Normative heat flux of adjacent pipe, [\emph{W/m^2}]. Type: \code{\link{assert_double}}.
       }
      \item{\code{Q}}{
        \emph{Traced thermal hydraulic regime}. Normative heat loss of adjacent pipe per day, [\emph{kcal}]. 
        Type: \code{\link{assert_character}}.
      }

      \item{\code{temperature}}{
        \emph{Traced thermal hydraulic regime}. Traced temperature of heat
        carrier (water) that is associated with the node, [\emph{°C}].
        Type: \code{\link{assert_double}}.
      }

      \item{\code{pressure}}{
        \emph{Traced thermal hydraulic regime}. Traced pressure of heat
        carrier (water) that is associated with the node, [\emph{MPa}].
        Type: \code{\link{assert_double}}.
      }

      \item{\code{flow_rate}}{
         \emph{Traced thermal hydraulic regime}. Traced flow rate of heat
         carrier (water) that is associated with the node, [\emph{ton/hour}].
         Type: \code{\link{assert_double}}.
      }

      \item{\code{job}}{
         \emph{Tracing job}. Value of tracing job counter. 
         Type: \code{\link{assert_count}}.
      }
 }
 Type: \code{\link{assert_data_frame}}.
}
\description{
Trace values of thermal-hydraulic regime (temperature, pressure,
 flow rate, and other) in the bunched pipeline against the flow direction using
 user-provided values of \emph{specific heat loss power}.

 Algorithm also suits for partially measurable district heating network with
 massive data lack conditions, when there are no temperature and pressure
 sensor readings on the majority of terminal nodes.
}
\details{
They consider the topology of district heating network represented by
 \code{\link{m325testbench}}:

 \figure{m325tracebw0.png}

 The network may be partially sensor-equipped too:
 
 \figure{m325tracebwp.png}

 In latter case no more than two nodes must be equipped with pressure and temperature
 sensors whereas for other nodes only flow rate sensors must be installed.

 Tracing starts from sensor-equipped nodes and goes backwards, i.e against
 the flow direction.

 Though some input arguments are natively vectorized their individual values
 all relate to common part of district heating network, i.e. associated with
 common object. It is due to isomorphism between vector representation and
 directed graph of this network. For more details of isomorphic topology
 description see \code{\link{m325testbench}}.

 Before tracing starts for the next node, previously calculated values of
 thermal-hydraulic parameters are aggregated by either averaging or
 by median. The latter seems more robust for avoiding strong influence of
 possible outliers which may come from actual heating transfer anomalies,
 erroneous sensor readings or wrong pipeline specifications.

 Aggregation for values of flow rate at the node is always \code{\link{sum}}.
}
\examples{
library(pipenostics)

# It is possible to run without specification of argument values:
m325tracebw()

# Consider isomorphic representation of District Heating Network graph:
DHN <- pipenostics::m325testbench

# * Adapt units:
DHN$d <- 1e3*DHN$d  # convert [m] to [mm]

# * Adapt node identifiers for ordering representation simplification:
DHN[["sender"]]   <- sprintf("N\%02i", DHN[["sender"]])
DHN[["acceptor"]] <- sprintf("N\%02i", DHN[["acceptor"]])

# * Provided actual values of specific heat loss power (say, field measurements) for each
#   pipe in DHN, [kcal/m/h]:
 actual_loss <- c(
               # acceptor:
      96.236,  #  1 
      96.288,  #  2
      70.584,  #  3
     116.045,  #  4
      70.734,  #  5
      96.211,  #  6
      78.400,  #  7
     116.016,  #  8
      28.115,  #  9
      24.918,  # 10
     116.679,  # 11
       0.000,  # 12, may be unmeasured!
     153.134,  # 13 
      96.733,  # 14 
      96.600,  # 15 
     116.667,  # 16
      24.960,  # 17
     115.923,  # 18
      28.166,  # 19
      96.123,  # 20
      77.824,  # 21
     115.946,  # 22
      70.690,  # 23
      96.184,  # 24
      96.236,  # 25
      70.540   # 26
 )

# * Remove inappropriate attributes of the graph:
DHN.1 <- DHN[, setdiff(colnames(DHN), c("year", "insulation", "laying", "beta", "exp5k"))]

# * Trace thermal-hydraulic regime for DHN:
tracebw_report <- do.call("tracebw", c(as.list(DHN.1), list(loss = actual_loss)))

# * If the actual values of specific heat loss power presented above are close 
#   to those in Minenergo-325, then the results of regime tracing match the 
#   normative procedure:
m325_report <- do.call("m325tracebw", DHN)

stopifnot(
   all.equal(tracebw_report$temperature, m325_report$temperature, tolerance = 1e-4),
   all.equal(tracebw_report$pressure   , m325_report$pressure   , tolerance = 1e-4),
   all.equal(tracebw_report$flow_rate  , m325_report$flow_rate  , tolerance = 1e-4)
  )

}
\seealso{
Other Regime tracing: 
\code{\link{m325tracebw}()},
\code{\link{m325tracefw}()},
\code{\link{m325traceline}()},
\code{\link{tracefw}()},
\code{\link{traceline}()}
}
\concept{Regime tracing}
