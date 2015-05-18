## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999–2008?
require(data.table)
require(grDevices)
require(ggplot2)
scc<-data.table(SCC)[EI.Sector %like% "Fuel Comb.*Coal"]
dt<-data.table(NEI)[SCC %chin% as.character(scc$SCC),sum(Emissions),by=c("year")]
setnames(dt,c("Year","Emissions"))
dt$Year<-factor(dt$Year)

plot<-ggplot(data=dt, aes(x=Year, y=Emissions,fill=Year)) +
  geom_bar(stat="identity") +
  labs(list(
    title="US PM2.5 Coal Sources Emissions",
    x="Year",
    y="Emissions, Tons"
  ))
ggsave("plot4.png",plot=plot,width=5.25,height=5.25,units="in",dpi=120)