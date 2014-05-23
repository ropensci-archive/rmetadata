#' Search metadata from the Digital Public Library of America (DPLA).
#'
#' @import ggplot2 stringr plyr
#' @importFrom reshape sort_df
#' @importFrom lubridate ymd
#' @export
#' @param input A data.frame from calling a variety of dpla_* functions.
#' @param plottype One of a number of types. These are for convenience. You
#'    can of course create your own plots with more flexibility.
#' @return A ggplot2 object, a plot that is.
#' @examples \dontrun{
#' # Plot results, summarising subjects by number of subjects listed
#' out <- dpla_basic(q="ecology", fields=c("publisher","subject"), limit=90)
#' dpla_plot(input=out)
#'
#' # Another example
#' out <- dpla_basic(q="science", date.before=1900, limit=200)
#' dpla_plot(input=out, plottype="subjectsbydate")
#' }

dpla_plot <- function(input, plottype = "subjectsum")
{
  # subject summary
  if(plottype == "subjectsum"){
    input$record <- 1:nrow(input)
    input_summary <- ddply(input, .(record), summarise,
                           numsubjects = length(str_split(subject,";")[[1]]))

    ggplot(input_summary, aes(reorder(record, X=numsubjects), numsubjects)) +
      geom_bar(stat="identity", width=.5) +
      theme_bw(base_size=16) +
      labs(x="Record",y="Number of subjects listed") +
      theme(panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank())

  } else
    if(plottype=="subjectsbydate"){
      subjectvec <- lapply(input$subject, function(x) data.frame(str_split(x,";")[[1]]))
      names(subjectvec) <- input$date
      subjectvec_df <- ldply(subjectvec)
      names(subjectvec_df) <- c("date","subject")
      rangetofirst <- function(x) if(length(str_split(x,"\\s+-\\s+|-")[[1]])>1){str_split(x,"\\s+-\\s+|-")[[1]][[1]]} else {x}
      subjectvec_df$date <- sapply(subjectvec_df$date, rangetofirst, USE.NAMES=FALSE)
      subjectvec_df$date <- ymd(paste0(gsub("\\?", "", subjectvec_df$date), "-1-1"))

      input_summary <- ddply(subjectvec_df, .(date, subject), summarise,
                             numsubjects = length(subject))
      top10df <- ddply(input_summary, .(subject), summarise, sum(numsubjects))
      toplot <- sort_df(top10df,"..1")[(nrow(sort_df(top10df,"..1"))-10):nrow(sort_df(top10df,"..1")),"subject"]
      plotme <- droplevels(input_summary[input_summary$subject %in% toplot,])

      ggplot(plotme, aes(date, numsubjects, color=subject)) +
        geom_line() +
        theme_bw(base_size=16) +
        labs(x="Date",y="Number of records found") +
        theme(panel.grid.major=element_blank(),
              panel.grid.minor=element_blank())
    } else
    {
      message("select one of xxxxx")
    }
}
