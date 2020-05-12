#install.packages("devtools")
library(devtools)
#install_github("DougLuke/UserNetR")
library(UserNetR)
data(Bali)
library(ggnetwork)
class(Bali)#Net is a special class 
ggnetplot <- function(Net=Bali){
  
  Net <- ggnetwork(Net,layout="kamadakawai")   #ggnetwork create a dataframe  Net is a special class 
  (ggplot(Net, aes(x,y, xend=xend, yend=yend)) 
    + geom_edges(color="grey75",curvature = 0.1) 
    + geom_nodes(color="gold",size=5)
    
    + geom_nodetext(aes(label=vertex.names),nudge_x = 0.08,color="gold") 
    +theme(axis.text = element_blank(),
           axis.title = element_blank(),
           panel.background = element_rect(fill = "grey25"),
           panel.grid = element_blank(),
           axis.ticks = element_blank()))
}


ggnetplot()



ggnetplot_role <- function(Net=Bali){
  
  Net <- ggnetwork(Net,layout="kamadakawai")   #ggnetwork create a dataframe  Net is a special class 
  (ggplot(Net, aes(x,y, xend=xend, yend=yend)) 
    + geom_edges(color="grey75",curvature = 0.1) 
    + geom_nodes(size=5,aes(color=role))
    
    + geom_nodetext(aes(label=role),nudge_x = 0.08,color="gold") 
    +theme(axis.text = element_blank(),
           axis.title = element_blank(),
           panel.background = element_rect(fill = "grey25"),
           panel.grid = element_blank(),
           axis.ticks = element_blank()))
}


ggnetplot_role()

