library(dplyr)

dfEmails = read.csv("./datasets/Emails.csv")
dfIncidents = read.csv("./datasets/incidents.csv")
dfRequests = read.csv("./datasets/sc_req_item.csv")

dfEmails$category = ""
dfEmails$sub_category1 = ""
dfEmails$sub_category2 = ""

dfIncidents$ticket_type = "Incident"

dfRequests$ticket_type = "Request"
dfRequests$urgency = ""
dfRequests$impact = ""
dfRequests$priority = ""


columnsEmail <- c('Summary', 'Description', 'Record.Type', 
                  'Business.service..task.','category', 'sub_category1', 'sub_category2')
      
columnsIncident <- c('Summary', 'Description', 'ticket_type',  
                   'Business.Service..Incident.', 'Category', 'Sub.Category', 'Sub.Category.2')
columnsRequest <- c('short_description', 'description', 'ticket_type', 
                    'business_service', 'u_category', 'u_sub_category', 'u_sub_category_2')

columnsExport <- c('title', 'body', 'ticket_type', 
                   'business_service','category', 'sub_category1', 'sub_category2' 
                   )

dfEmailsExport <- dfEmails[,columnsEmail]
dfIncidentsExport <- dfIncidents[,columnsIncident]
dfRequestsExport <- dfRequests[,columnsRequest]

colnames(dfEmailsExport) <- columnsExport
colnames(dfIncidentsExport) <- columnsExport
colnames(dfRequestsExport) <- columnsExport


write.csv(dfEmailsExport,"preprocessed_emails.csv", fileEncoding = "UTF-8", row.names = FALSE)
write.csv(dfRequestsExport,"preprocessed_requests.csv", fileEncoding = "UTF-8", row.names = FALSE)
write.csv(dfIncidentsExport,"preprocessed_incidents.csv", fileEncoding = "UTF-8", row.names = FALSE)

library(dplyr)
library(plotly)
dfTickets = bind_rows(dfIncidentsExport, dfRequestsExport)


#ticket_type
dfTickets %>% group_by(ticket_type) %>% 
  summarise(TicketsType = length(body)) %>% ungroup() -> ticket_types
plot_ly(ticket_types, x = ~ticket_type) %>%
  add_trace(y = ~TicketsType, name = 'Total %', showlegend=TRUE, type = 'bar', mode = 'lines+markers') %>%
  layout(title="Number of tickets type",
         xaxis = list(title = "Type of tickets",showticklabels = TRUE, tickangle = 45, tickfont = list(size = 8)),
         yaxis = list(title = "Total"),
         hovermode = 'compare')  

#category
dfTickets %>% group_by(category) %>% 
  summarise(Category = length(body)) %>% ungroup() -> categories
plot_ly(categories, x = ~category) %>%
  add_trace(y = ~Category, name = 'Total', showlegend=TRUE, type = 'bar', mode = 'legendgroup') %>%
  layout(title="Number of categories",
         xaxis = list(title = "Categories",showticklabels = TRUE, tickangle = 45, tickfont = list(size = 9)),
         yaxis = list(title = "Total"),
         hovermode = 'compare')


#business_service
dfTickets %>% group_by(business_service) %>% 
  summarise(BusinessService = length(body)) %>% ungroup() -> business_services
plot_ly(business_services, x = ~business_service) %>%
  add_trace(y = ~BusinessService, name = 'Total', showlegend=TRUE, type = 'bar', mode = 'legendgroup') %>%
  layout(title="Number of business services",
         xaxis = list(title = "Business services",showticklabels = TRUE, tickangle = 45, tickfont = list(size = 9)),
         yaxis = list(title = "Total"),
         hovermode = 'compare')

