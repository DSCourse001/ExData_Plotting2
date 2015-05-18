## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Of the four types of sources indicated by the type
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
require(data.table)
require(grDevices)
require(ggplot2)
dt<-data.table(NEI)[fips == "24510",sum(Emissions),by=c("year","type")]
setnames(dt,c("Year","Type","Emissions"))

plot<-ggplot(data=dt, aes(x=Year, y=Emissions, group=Type, color=Type)) + 
  geom_line() + 
  geom_point(size=5,shape=16) +
  labs(list(
    title="PM2.5 Emissions by Types\nBaltimore City, Maryland",
    x="Year",
    y="Emissions, Tons"
    ))
ggsave("plot3.png",plot=plot,width=5.25,height=5.25,units="in",dpi=120)