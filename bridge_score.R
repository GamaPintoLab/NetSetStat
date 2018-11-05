bridge_score=function(g,gadj,from,to){
  #gadj=as_adjacency_matrix(g)
  gadj2=gadj%*%gadj
  gadj3=gadj2%*%gadj
  gadj4=gadj3%*%gadj
  tot_1=gadj2[from,to]
  tot_2=gadj3[from,to]
  tot_3=gadj4[from,to]
  
  node_tab=data.frame(uniprot=unlist(vertex_attr(g)),stringsAsFactors = F)
  node_tab$b1=gadj[,from]*gadj[,to]/tot_1
  node_tab$b2=(gadj[,from]*gadj2[,to]+gadj[,to]*gadj2[,from])/tot_2
  node_tab$b3=(gadj2[,from]*gadj2[,to]+gadj[,to]*gadj3[,from]+gadj3[,to]*gadj[,from])/tot_3
  node_tab$b1[is.na(node_tab$b1)]=0
  node_tab$b2[is.na(node_tab$b2)]=0
  node_tab$b3[is.na(node_tab$b3)]=0
  node_tab$w=node_tab$b1+0.5*node_tab$b2+0.25*node_tab$b3
  node_tab
}
