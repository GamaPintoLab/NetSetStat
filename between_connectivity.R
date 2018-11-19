between_connectivity=function(g,s1,s2,method,nrep){
  bc=sub_bc(g,s1,s2)
  if (method=="rand_seeds"){
    pval=0
    dist=vector()
    for (i in 1:nrep){
      rs1=sample(igraph::vcount(g),length(s1))
      rs2=sample(igraph::vcount(g),length(s2))
      dist[i]=sub_bc(g,rs1,rs2)
      pval=pval+1*(dist[i]>wc)+0.5*(dist[i]==wc)
    }
    pval=pval/nrep
  } else if (method=="rand_edges"){
    pval=0
    dist=vector()
    degseq=degree(g)
    for (i in 1:nrep){
      rg=igraph::sample_degseq(degseq,method="vl")
      dist[i]=sub_bc(rg,s1,s2)
      pval=pval+1*(dist[i]>wc)+0.5*(dist[i]==wc)
    }
    pval=pval/nrep
  } else if (method=="hyper"){
    ntot=igraph::vcount(g)*(igraph::vcount(g)-1)/2
    m=igraph::ecount(g)
    n=ntot-m
    k=length(s1)*length(s2)
    pval=phyper(wc-1,m,n,k,lower.tail=F)
    dist=vector()
  }
  list(wc=wc,p=pval,dist=dist)
}

sub_bc=function(g,s1,s2){
  wc1=igraph::ecount(igraph::induced_subgraph(g,s1))
  wc2=igraph::ecount(igraph::induced_subgraph(g,s2))
  # s1 and s2 should have no intersection
  bc=igraph::ecount(igraph::induced_subgraph(g,base::union(s1,s2)))-wc1-wc1
  bc                  
}
