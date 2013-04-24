#' Search metadata from the Digital Public Library of America (DPLA).
#' 
#' @import ggplot2 plyr
#' @param input XXXX
#' @return A list for now...
#' @examples \dontrun{
#' # Plot results from basic search
#' out <- dpla_basic(q="ecology", fields=c("publisher","subject"), page_size=90)
#' 
#' # lets summarise subjects by number of subjects listed
#' dpla_plot(input=out)
#' }
#' @export
dpla_plot <- function(input, plottype = "subjectsum")
{ 
  # subject summary
  if(plottype == "subjectsum"){  
    input$record <- 1:nrow(input)
    input_summary <- ddply(input, .(record), summarise, 
                           numsubjects = length(str_split(subject,";")[[1]]))
    
    ggplot(input_summary, aes(reorder(record, X=numsubjects), numsubjects)) + 
      geom_bar(stat="identity") +
      theme_bw(base_size=16) +
      labs(x="",y="Number of subjects listed") +
      theme(panel.grid.major=element_blank(), 
            panel.grid.minor=element_blank(),
            axis.text.x=element_blank())
    
  } else
  {message("select one of xxxxx")}
}