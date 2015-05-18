## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City? 
require(data.table)
require(grDevices)
require(ggplot2)
dt<-data.table(NEI)[fips == "24510" & type=="ON-ROAD",sum(Emissions),by=c("year")]
setnames(dt,c("Year","Emissions"))
dt$Year<-factor(dt$Year)

plot<-ggplot(data=dt, aes(x=Year, y=Emissions,fill=Year)) +
  geom_bar(stat="identity") +
  labs(list(
    title="PM2.5 Motor Vehicle Sources Emissions in\nBaltimore City,Maryland",
    x="Year",
    y="Emissions, Tons"
  ))
ggsave("plot5.png",plot=plot,width=5.25,height=5.25,units="in",dpi=120)