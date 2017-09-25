#!/usr/bin/awk -f
BEGIN {
}
{
  if (NF>2) {
     print "copy file '"$3"' to :version/"$2
     system("cp "$3" :version/"$2)
  }
}
END {
}
