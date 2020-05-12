library("WDI")

wdi_data <- WDI(indicator = c("NY.GDP.PCAP.PP.KD","EN.ATM.CO2E.PC"),start = 2010,end = 2010,extra = TRUE)
wdi_data1 <- tibble(wdi_data)


wdi_data1 <- wdi_data1%>% rename(GDPpercap= NY.GDP.PCAP.PP.KD, Emit_co2Pcap=EN.ATM.CO2E.PC)
dat_map <- map_data("world")


#install.packages("countrycode")
library(countrycode)
dat_map$ccode <- countrycode(dat_map$region, origin = "country.name", destination = "wb")
wdi_data1$ccode <- countrycode(wdi_data1$country, origin = "country.name", destination = "wb")


merged <- full_join(dat_map,wdi_data1,by="ccode")

gg <- (ggplot(merged,aes(x=long,y=lat,group=group,fill=Emit_co2Pcap))
       +geom_polygon(alpha=1,show.legend = TRUE)
       +scale_fill_gradient2(
         low = "blue",
         mid = "white",
         high = "red",
         midpoint = 0.4 * (max(merged[, "Emit_co2Pcap"], na.rm=T) + min(merged[, "Emit_co2Pcap"], na.rm=T)) / 2, 
         space ="Lab",
         aesthetics = "fill",
         breaks = seq(0,20,by = 4),
         guide = guide_legend(),
         oob = scales::squish, 
         name="CO2 Emission",
         na.value = "grey")
       
       +scale_x_continuous("Longitude")
       +scale_y_continuous("Latitude")
       +theme(panel.background = element_rect(fill = "grey25"))
       
)
gg
