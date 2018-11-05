joincomp=function(idlist,g){
  
  subdist=distances(g,v=idlist,to=idlist)
  closure=graph_from_adjacency_matrix(subdist,mode="undirected",weighted=T)
  clos_mst=mst(closure,algorithm="prim")
  clos_mst_table=as_data_frame(clos_mst,what="edges")
  vnames=unlist(vertex_attr(g,index=V(g)))
  id1=vector()
  id2=vector()
  all2add=list()
  allvec=vector()
  listind=1
  for (i in 1:nrow(clos_mst_table)){
    id1[i]=which(vnames==clos_mst_table[i,1])
    id2[i]=which(vnames==clos_mst_table[i,2])
    if (clos_mst_table[i,3]>1){
      sp=all_shortest_paths(g,from=id1[i],to=id2[i])$res
      temp2add=list()
      for (j in 1:length(sp)){
        spj=as.numeric(sp[[j]])
        temp2add[[j]]=spj[2:(length(spj)-1)]
        allvec=c(allvec,spj[2:(length(spj)-1)])
      }
      all2add[[listind]]=temp2add
      listind=listind+1
    }
  }
  addtable=as.data.frame(table(allvec),stringsAsFactors=F)
  addtable[,1]=as.numeric(addtable[,1])
  for (i in 1:nrow(addtable)){
    addtable[i,3]=length(intersect(as.numeric(neighbors(g,addtable[i,1])),idlist))
  }
  uni2add=list()
  for (i in 1:length(all2add)){
    if (length(all2add[[i]])>1){
      alt_mat=matrix(ncol=2,nrow=length(all2add[[i]]))
      for (j in 1:length(all2add[[i]])){
        alt_mat[j,1]=sum(addtable[is.element(addtable[,1],all2add[[i]][[j]]),2])
        alt_mat[j,2]=sum(addtable[is.element(addtable[,1],all2add[[i]][[j]]),3])
      }
      alt_choice=order(x=-alt_mat[,1],y=-alt_mat[,2])
      uni2add[[i]]=all2add[[i]][[alt_choice[1]]]
    } else {
      uni2add[[i]]=all2add[[i]][[1]]
    }
  }
  uni2add=unique(unlist(uni2add))
  subnodes=union(idlist,uni2add)
  subg=induced_subgraph(g,subnodes)
  mst=cbind(clos_mst_table,id1,id2)
  list(subg=subg, uni=uni2add, all=all2add, addtable=addtable,mst=mst)
}
