alias ports="netstat -anvp tcp | awk 'NR<3 || /LISTEN/'"
